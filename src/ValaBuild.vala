/*
Author: Patrick J
*/

namespace VBuild {

    public class Builder : Object {

        private ConfigParser config_parser;

        public Builder() {
            this.config_parser = new ConfigParser ();
        }

        public void process_build_config (string location) {
            stdout.printf("processing file: %s\n", location);
            string? file_content = read_package_json (location);
            stdout.printf("file content:\n%s\n", file_content);
            if (file_content != null) {
                BuildConfig build_config = config_parser.parse_configuration (file_content);
                trigger_build_process (build_config);
            } else {
                stdout.printf ("content is null. Aborting.\n");
            }
        }

        private void trigger_build_process (BuildConfig? build_config) {
            if (build_config != null) {
                CommandBuilder.build (build_config);
            }
        }

        private string? read_package_json (string location) {
            try {
                string content;
                FileUtils.get_contents (location, out content);
                return content;
            } catch (FileError e) {
                stderr.printf("%s\n", e.message);
                return null;
            }
        }

    }

    public static int main(string[] args) {
        return ArgumentParser.process_command_arguments (args);
    }
}
