#Rosetta Code Templates

#Author
Jared Adolf-Bryfogle (jadolfbr@gmail.com); November 2015

#Overview
These scripts help developers decrease coding time by creating pre-configured header, source, and fwd header files (templates) 
from a stub for common rosetta classes and file types using the magic of Python. 


It works for movers, task ops, general classes, util files, applications, and unit test class (just to name a few). 
More are being added, so this is not a full list.  

Code Templates are located in ```main/source/code_templates```

Here, you will find three scripts.  These can be run from any directory.

- __generate_templates.py__
 - Generate pre-configured hh, fwd.hh, and cc files (templates) that will go in src

- __generate_app_template_JD2.py__
 - Generate templates for pilot or public applications

- __generate_unit_test_template.py__
 - Generate templates for unit test class
 
For a quick overview (and to get a list of implemented class types), use the ```--help``` option on a particular app: 
 - ```./generate_templates.py --help```
 
The code will fill in author and email fields from git. 
The file will be created and placed into the same directory as the namespace given 
(or the directory passed using the ```dir_override``` option)


Stubs are located in the src, application, and unit_test directories. 

Here is an example of creating a new mover for carbohydrates:
```
./generate_templates.py --type mover --class_name TestMover --brief "A simple testing Mover" --namespace protocols carbohydrates

```
   
   
#More Information

The README in the directory will help you get started.  This page also has information on adding new src templates for new Rosetta classes.

https://github.com/RosettaCommons/main/blob/master/source/code_templates/README.md

#Etc

If you find this useful, find me at RosettaCon and let me know.  Lets have a beer!  
Seriously though, please think about supporting the project by adding new template types!  Having a template can be extremely beneficial for collaboration and adaptation of specific class types.  Totally makes it more fun to code too!


Cheers!

