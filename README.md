## vbuilder

> A small build system for `Vala` Projects.

### Description

`vbuilder` can be used to build your `Vala`-Projects.

### Usage

A vala project can be build using the following command:

```bash
vbuilder --build <package.json>
```

This requires your project to have a `vbuilder` compatible `package.json` file in your project's root directory.

For more detailed configuration instructions see the `package.json` example section below.

### Installing `vbuilder`

#### From Source

As of now, `vbuilder` is only available if you build it from source.

To do this, follow the instructions below:

```bash
git clone https://github.com/pddstudio/vbuilder
cd vbuilder/
./build.sh
```

### Building `vbuilder`

Get a copy of this repository and execute the `build.sh` located at the top of this repository.

```bash
git clone https://github.com/pddstudio/vbuilder
cd vbuilder/
./build.sh
```

### `package.json` Example

Below is an example configuration with all current available fields.

```json
{
    "name": "Test Application",
    "description": "This is some test description",
    "version": "1.0.0-SNAPSHOT",
    "author": "Patrick J",
    "website" : "https://github.com/pddstudio/vbuild",
    "dependencies" : [
        "gtk+-3.0"
    ],
    "scripts": {
        "run" : "./ {}"
    },
    "compiler" : {
        "flags" : [ "-l somelib" ]
    },
    "files" : [
        "src/",
        "Test.vala"
    ],
    "binary" : "sample-binary"
}
```

### Author

* Patrick Jung [<patrick.pddstudio@gmail.com>](mailto:patrick.pddstudio@gmail.com)
* Google+ [Profile](https://plus.google.com/+PatrickJung42)


### License

	Copyright 2017 Patrick Jung

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.


