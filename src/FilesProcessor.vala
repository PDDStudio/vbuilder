/*
    Author: Patrick J
*/

using Gee;
using GLib;

namespace VBuild {

    public class FilesProcessor : Object {

        public static ArrayList<string> get_project_files (ArrayList<string> files) {
            FilesProcessor processor = new FilesProcessor ();
            return processor.get_included_files (files);
        }

        private string current_directory;

        public FilesProcessor () {
            this.current_directory = Environment.get_current_dir ();
        }

        private bool is_valid_file (string file_location) {
            File file = File.new_for_path (file_location);
            string file_name = file.get_basename ();
            return file_name.has_suffix (".vala");
        }

        private bool is_directory (string location) {
            return FileUtils.test (location, FileTest.IS_DIR);
        }

        private bool is_file (string location) {
            return FileUtils.test (location, FileTest.IS_REGULAR);
        }

        private string build_file_name (string file) {
            return Path.build_filename (current_directory, file);
        }

        private ArrayList<string> list_files_in_directory (string location) {
            var files = new ArrayList<string> ();
            Dir dir = Dir.open (location);
            string name;
            while ((name = dir.read_name ()) != null) {
                if(is_valid_file (name)) {
                    files.add (Path.build_filename (location, name));
                }
            }
            return files;
        }

        public ArrayList<string> get_included_files (ArrayList<string> files) {
            stdout.printf("Current dir: %s\n", current_directory);
            ArrayList<string> project_files = new ArrayList<string> ();

            foreach (string entry in files) {
                string location = build_file_name (entry);
                if (is_directory (location)) {
                    ArrayList<string> dir_content = list_files_in_directory (location);
                    foreach (string dir_file in dir_content) {
                        if(is_file (dir_file) && is_valid_file (dir_file)) {
                            project_files.add (dir_file);
                        } else if(is_directory (dir_file)) {
                            //TODO
                        }
                    }
                } else if (is_file (location) && is_valid_file (location)) {
                    project_files.add (location);
                } else {
                    stdout.printf ("%s does not exist!\n", location);
                }
            }

            return project_files;
        }

    }

}
