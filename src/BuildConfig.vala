/*
    Author: Patrick J
*/

using Gee;

namespace VBuild {

    public class BuildConfig : Object {

        public string name { get; set; }

        public string description { get; set; }

        public string version { get; set; }

        public string author { get; set; }

        public string binary { get; set; }

        public ArrayList<string> dependencies { get; set; default = new ArrayList<string> (); }

        public ArrayList<string> compiler_flags { get; set; default = new ArrayList<string> (); }

        public ArrayList<string> build_files { get; set; default = new ArrayList<string> (); }

    }

}
