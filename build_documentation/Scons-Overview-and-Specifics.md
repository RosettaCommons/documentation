#Scons Overview

Original Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)

## Browsing the build system:
It is recommended to load the source directory as a PyCharm project.  PyCharm is a great and free IDE for python.  Next, add the following file types File->Settings->File Types [Python] under IDE settings:
* <code>SConscript*</code>
* <code>SConstruct*</code>
* <code>*.settings</code>
* <code>*.src</code>

## Important files and what they do
Each _project_ has a SConscript associated with it. These SConscripts handle setting up project-specific settings. The settings are loaded via classes in <code>main/source/tools/build/settings.py</code>. Each class is a dictionary, and each other class inherits from Settings class. 

Classes include:
* Settings(dict)
* BuildOptionsSupported (Settings)
* BuildOptions (Settings)
* BuildFlags (Settings)
* BuildSettings (Settings)
* BuildSettingsCombined (Settings)
* ProjectSettings (Settings)

### SConscripts:
Each _project_ has a SConscript associated with it. These SConscripts handle setting up project-specific settings. 

#### Main:
These files are responsible for setting up the build. 

* <code>main/source/SConstruct</code> which calls <code>main/source/tools/build/setup.py</code> and then SConscript.  
* <code>main/source/SConscript</code>


#### Apps/Src:
These files are responsible for parsing the xxx.apps.settings and xxx.src.settings such as pilot_apps.src.settings and core1.src.settings through the settings.py classes.  
There are 5 categories that are parsed in each .settings file here.  They include: sources, include_path, library_path, libraries, subprojects.

These files are:
* <code>main/source/src/SConscript.src</code>
* <code>main/source/src/SConscript.apps</code>

#### External
Responsible primarily for setting up build settings for sqlite3 and cppdb external libraries.
* <code>main/source/external/SConscript.external</code>

### Settings

#### site.settings
The site.settings files in <code>main/source/tools/build</code> allow you to override any of the settings in the scons build system.  This allows you to add specific libraries, include paths, or overide very specific build settings. Both site and user .settings files are loaded via <code>main/source/tools/setup.py</code> via the main SConstruct file.  

#### basic.settings
The basic.settings file in <code>main/source/tools/build </code> control settings for specific platforms and compilers.  If a new version of your favorite compiler is released and requires specific tweaks, here is where you would edit what it uses for cc, cxx, link settings, etc.  This file is also loaded by <code>main/source/tools/setup.py</code>

#### options.settings
The options.settings file in <code>main/source/tools/build</code> is a compilation of what is actually supported by the Rosetta build system.  Supported compilers, modes, extras, and systems are loaded from here first by <code>main/source/tools/setup.py</code>

#### platforms
Platforms are initially setup by functions in the <code>main/source/tools/build/setup_platforms</code> file.  If new computer architecture is being tested, add it to here first.  

##See Also

* [[Build Documentation]]: Information on setting up Rosetta
* [[Getting Started]]: A page for people new to Rosetta. New users start here.
* [[TACC]]: Information for running Rosetta on the TACC/Stampede cluster.
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Platforms]]: Supported platforms for Rosetta