/*
    Author: Patrick J
*/

using GLib;

namespace VBuild {

    public class CommandBuilder : Object {

        public static void build (BuildConfig build_config) {
            CommandBuilder builder = new CommandBuilder (build_config);
            builder.start_building ();
        }

        private static string PKG_DEPENDENCY = "--pkg";
        private static string COMPILER_PARAM_OUT = "-o";

        private static string VALA_COMPILER_BINARY = "valac";

        private BuildConfig build_config;

        public CommandBuilder (BuildConfig build_config) {
            this.build_config = build_config;
        }

        private string build_dependencies_snippet () {
            var builder = new StringBuilder ();
            foreach (string dependency in build_config.dependencies) {
                builder.append ( PKG_DEPENDENCY );
                builder.append ( " " );
                builder.append ( dependency );
                builder.append ( " " );
            }
            return builder.str;
        }

        private bool binary_name_defined () {
            return build_config.binary != null;
        }

        private string build_binary_output_name () {
            return COMPILER_PARAM_OUT +  " " + build_config.binary;
        }

        private void create_shell_command () {

        }

        private string build_files_list () {
            var builder = new StringBuilder ();
            foreach (string file in build_config.build_files) {
                builder.append ( file );
                builder.append ( " " );
            }
            return builder.str;
        }

        private void execute_build_command (string build_command) {
            try {
                Process.spawn_command_line_sync (build_command);
                stdout.printf ("Build execution finished!\n");
            } catch (SpawnError e) {
                stderr.printf("%s\n", e.message);
            }
        }

        //TODO: include compiler flags

        public void start_building () {
            stdout.printf ("start_building () invoked!\n");
            string dep_snippet = build_dependencies_snippet ();
            stdout.printf ("deps => %s\n", dep_snippet);

            string target_files = build_files_list ();

            var builder = new StringBuilder ();
            builder.append ( VALA_COMPILER_BINARY );
            builder.append ( " " );
            builder.append ( dep_snippet );
            builder.append ( target_files );

            if (binary_name_defined ()) {
                string binary_name_param = build_binary_output_name ();
                builder.append ( " " );
                builder.append ( binary_name_param );
            }

            execute_build_command (builder.str);
        }

    }

}
