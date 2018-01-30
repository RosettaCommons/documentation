Rosetta Database Output tutorial
================================

Overview
--------

Rosetta allows us to generate output in several ways, most of them
include 'regular' or compressed pdb files. (silent files, pdb\_gz, etc)
The newly added feature of outputting results to a database allows users
to interact with Rosetta's output in a much more convenient way,
eliminating most of the needs for clumsy scripts, file corruption, etc..
The current implementation permits 2 formats of databases - mysql and
sqlite.

Creating a Rosetta run with a Database output
---------------------------------------------

In order to use the database output feature you have to include 2 basic
flags: (for mysql you will also need the following flags - mysql::host,
mysql::user, mysql::password, mysql::port) For the purpose of this
tutorial , I will concentrate on sqlite3 which suites best our needs and
is much simpler to use)

*-out:use\_database* - indicating you are interested in a database
output format

*-inout:dbms:database\_name* - the database filename

*-inout:database\_mode* - default is sqlite3 so we won’t touch that.

Using these command line flags is fairly simple, for example:

    $ROSETTA_BIN/<protocol>.linuxgccrelease -s 1SFI_cyc.pdb 
    -database $ROSETTA_DB -ex1 -ex2 -use_input_sc -nstruct  1 -out:use_database -inout:dbms:database\_name results.db

Getting structures out of the database
--------------------------------------

How to get results of the database to a pdb file(s)?

###Getting all the decoys out of the database


In order to get all the structures out of the database , you can use the
score\_jd2 flag with the following options:

*-inout:dbms:database\_name* file.db *-in:use\_database* *-out:pdb*

###Getting specific decoys out of the database

If you want to acquire only a subset of structures (for example, the
ones that have total\_score\<0) you just input a query to sqlite3:
(verify you have it installed first...)

    sqlite3 results.db < query.txt

The query file should look like (remove comments /\* \*/ when run):

    .output structures.txt  /*set the output to file mode*/
    select tag from structures;  /*the query, should output tag names only!*/
    .exit

Next, just feed the query output to the *-in:file:tags* tag, could be in
the following way:

    $ROSETTA_BIN/score_jd2.linuxgccrelease -inout:dbms:database\_name results.db 
    -in:use_database -out:pdb -in:file:tags `cat structures.txt` -database $ROSETTA_DB

###Moving old results to a database file


Again , we'll use the score\_jd2 application to rescore a set of pdb
files and directing the output to a database:

    score_jd2.linuxgccrelease -s decoy_* -database $ROSETTA_DB -out:use_database -inout:dbms:database\_name results.db

Useful queries
--------------

**TODO** ...

Links
-----

[Simple sqlite examples](http://www.sqlite.org/sqlite.html)

##See Also

* [[Database IO]]: Information on input/output to different database formats using Rosetta
* [[Features reporter overview]]: Home page for the Features Reporter, a tool for outputting information to databases using Rosetta
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Command line options for working with databases
* [[RosettaScripts database connection options]]
* [[The Rosetta database|database]]: Information about the main database included with Rosetta and specified by the -in:path:database flag (separate topic)