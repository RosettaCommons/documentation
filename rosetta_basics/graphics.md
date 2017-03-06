OpenGL graphics
=====
Graphics or "viewer" is a native graphics viewer in Rosetta that allows you to watch a given pose in real-time. It is often used to troubleshoot protocols in rosetta_scripts. These are the same graphics that are used in Rosetta@home BOINC screensaver. 

The advantage of using the native rosetta graphics viewer over the PyMol mover is that it is VERY lightweight and can be used to render nearly LIVE graphics with no lag, even over an SSH connection!

## Controling the graphics
To control the visuals, use keyboard shortcuts:
* C = color (color by chain, or rainbow, atom type etc.)
* B = backbone (ribbon, cartoon, etc.)
* S = sidechain on/off
* H = hydrogen on/off

## Running RosettaScripts with Graphics!
You just need to include a single flag:
`rosetta_scripts.graphics.linuxgccrelease -parser:view`

Note: Some movers automatically assign the secondary structure to the working pose, for movers that do not you need to first run the Dssp mover.

## Compiling with graphics mode

#### In linux
Before you can compile, you need copy the libglut.so file into the external lib directory:
` ~/rosetta/main/source/external/lib/libglut.so `

Then using scons, specify graphics as extras:
`./scons.py bin/rosetta_scripts.graphics.linuxgccrelease mode=release extras=graphics -j 2`

#### In Mac OS X
Specify graphics as extras.
`./scons.py bin/rosetta_scripts.graphic.macosclangrelease mode=release extras=graphics -j2`
