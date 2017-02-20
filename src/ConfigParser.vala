/*
    Author: Patrick J
*/

using Json;
using Gee;

namespace VBuild {

    public errordomain ConfigParserError {
        INVALID_FORMAT
    }

    public class ConfigParser : GLib.Object {

        private static string[] config_fields = { "name", "description", "version", "author", "dependencies", "scripts" };

        private Json.Parser parser;

        public ConfigParser () {
            this.parser = new Json.Parser ();
        }

        private bool is_valid_config_entry (string entry) {
            foreach (unowned string item in config_fields) {
                if (item == entry) {
                    return true;
                }
            }
            return false;
        }

        private string? parse_object_string (Json.Object obj, string key) {
            string? val = obj.get_string_member (key);
            return val;
        }

        private Json.Array? parse_object_array (Json.Object obj, string key) {
            if(!obj.has_member (key)) {
                stdout.printf ("Member does not exist: %s\n", key);
                return null;
            } else {
                Json.Array? array = obj.get_array_member (key);
                return array;
            }
        }

        private ArrayList<string> parse_object_dependencies (Json.Array? array) {
            var dependency_list = new ArrayList<string> ();

            if(array == null) {
                stdout.printf ("No dependencies found. Skipping!\n");
                return dependency_list;
            }

            foreach (unowned Json.Node node in array.get_elements ()) {
                if (node != null) {
                    string dep = node.get_string ();
                    dependency_list.add (dep);
                } else {
                    stdout.printf("Node is null!\n");
                }
            }
            return dependency_list;
        }

        private ArrayList<string> parse_json_array (Json.Array? array) {
            var items = new ArrayList<string> ();

            if(array != null) {
                foreach (unowned Json.Node node in array.get_elements ()) {
                    if (node != null) {
                        string item = node.get_string ();
                        items.add (item);
                    }
                }
            }

            return items;
        }

        private ArrayList<string> parse_object_compiler (Json.Object? obj) {
            Json.Array compiler_flags_array = parse_object_array (obj, "flags");
            ArrayList<string> compiler_flags = parse_json_array (compiler_flags_array);
            return compiler_flags;
        }

        private ArrayList<string> parse_files_array (Json.Array? array) {
            var files = new ArrayList<string> ();

            if(array != null) {
                ArrayList<string> file_list = parse_json_array (array);
                files = FilesProcessor.get_project_files (file_list);
            }

            return files;
        }

        private BuildConfig process (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new ConfigParserError.INVALID_FORMAT ("Unexpected element type: %s", node.type_name ());
            }

            BuildConfig build_config = new BuildConfig ();
            unowned Json.Object jsonObject = node.get_object ();

            string name = parse_object_string (jsonObject, "name");
            build_config.name = name;

            string description = parse_object_string (jsonObject, "description");
            build_config.description = description;

            string version = parse_object_string (jsonObject, "version");
            build_config.version = version;

            string author = parse_object_string (jsonObject, "author");
            build_config.author = author;

            string binary = parse_object_string (jsonObject, "binary");
            build_config.binary = binary;

            Json.Array dependencies = parse_object_array (jsonObject, "dependencies");
            ArrayList<string> deps = parse_object_dependencies (dependencies);
            build_config.dependencies = deps;

            Json.Object compiler_flags = jsonObject.get_object_member ("compiler");
            ArrayList<string> flags = parse_object_compiler (compiler_flags);
            build_config.compiler_flags = flags;

            Json.Array files_array = parse_object_array (jsonObject, "files");
            ArrayList<string> files = parse_files_array (files_array);
            build_config.build_files = files;

            return build_config;
        }

        public BuildConfig? parse_configuration (string config) {
            try {
                parser.load_from_data (config);
                //get the root node of the config
                Json.Node root = parser.get_root ();
                //process the given node
                return process (root);
            } catch (Error e) {
                stdout.printf ("Unable to process config file: %s\n", e.message);
                return null;
            }
        }

    }

}
