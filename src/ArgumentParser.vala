/*
    Author: Patrick J
*/

namespace VBuild {

    public class ArgumentParser : Object {

        private static string APP_VERSION = "v0.0.1";
        private static string APP_NAME = "vbuild";

        private static string[] ARG_HELP = { "--help", "-h" };
        private static string[] ARG_VERSION = { "--version", "-v" };
        private static string[] ARG_BUILD = { "--build", "-b" };

        public static int process_command_arguments (string[] args) {
            ArgumentParser parser = new ArgumentParser (args);
            if (should_show_help (args)) {
                parser.show_help ();
            } else {
                parser.parse_args ();
            }
            return 0;
        }

        private static bool should_show_help (string[] args) {
            if (args.length == 1) {
                return true;
            } else if (args.length == 2 && is_help_arg (args[1])) {
                return true;
            }
            return false;
        }

        private static bool is_help_arg (string arg) {
            foreach(string item in ARG_HELP) {
                if (arg == item) {
                    return true;
                }
            }
            return false;
        }

        private string[] args;

        private ArgumentParser (string[] args) {
            this.args = args;
        }

        private void print_line (string message) {
            stdout.printf (message + "\n");
        }

        private bool is_in_array (string[] array, string entry) {
            foreach(string item in array) {
                if(item == entry) {
                    return true;
                }
            }
            return false;
        }

        private void parse_args () {
            if (args.length >= 2) {
                string arg = args[1];
                if (is_in_array (ARG_HELP, arg)) {
                    show_help ();
                } else if (is_in_array (ARG_VERSION, arg)) {
                    show_version ();
                } else if (is_in_array (ARG_BUILD, arg)) {
                    if(args.length < 3) {
                        show_help ();
                    } else {
                        trigger_build (args[2]);
                    }
                }
            }
        }

        private void show_help () {
            print_line ("vbuild - Tiny Vala Build System");
            print_line (" ");
            print_line ("usage:");
            print_line (" ");
            print_line ("vbuild [-h/--help] - Print this help information");
            print_line ("vbuild [-v/--version] - Prints the current version");
            print_line (" ");
            print_line ("vbuild [-b/--build] <package.json> - Build a project with the given <package.json>");
        }

        private void show_version () {
            print_line (APP_NAME + " " + APP_VERSION);
        }

        private void trigger_build (string file_name) {
            Builder builder = new Builder ();
            builder.process_build_config (file_name);
        }

    }

}
