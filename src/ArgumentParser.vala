/*
    Author: Patrick J
*/

namespace VBuild {

    public class ArgumentParser : Object {

        public static void process_command_arguments (string[] args) {
            ArgumentParser parser = new ArgumentParser (args);
        }

        private string[] args;

        private ArgumentParser (string[] args) {
            this.args = args;
        }

    }

}
