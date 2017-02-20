 #!/bin/bash
echo "Building vbuild..."
valac --pkg json-glib-1.0 --pkg gee-0.8 --pkg glib-2.0 src/ValaBuild.vala src/FilesProcessor.vala src/ConfigParser.vala src/BuildConfig.vala src/CommandBuilder.vala src/ArgumentParser.vala -o vbuild
