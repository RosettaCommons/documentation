<!-- --- title: Database IO -->Database Support in Rosetta
===========================

Database Drivers
----------------

Rosetta has support for interacting with SQLite3, MySQL and PostgreSQL database backends. This page describes the backends, how to get started using them, and what has already been done. The SQLite3 backend is tested extensively in the *integration\_tests* with every commit, and the PostgreSQL and MySQL support is tested through the BuildBot framework ( [PostgreSQL](http://buildbot.graylab.jhu.edu:8010/builders/UNC.Mac.PostgreSQL.tests) , MySQL).

-   **SQLite3**
    -   [SQLite3](http://www.sqlite.org/) is a light-weight database engine that stores each database as a file in the filesystem, and is optimized for single connections to database stored on a local drive.
    -   It is built into Rosetta and compiled by default, so no special configuration is needed.

-   **MySQL**
    -   [MySQL](http://www.mysql.com/) is a client-server architecture.
    -   To build Rosetta with MySQL support:
        -   Download the MySQL Connector/C library ( [libmysqlclient](http://dev.mysql.com/downloads/connector/c/) ). As scons does not import environment variables, you will need to place the `        mysql/lib       ` directory containing `        libmysqlclient_r.so       ` into your path by creating a `        site.settings       ` file.
        -   You will also need to install `        libmysqlclient       ` in the `        LD_LIBRARY_PATH       ` environment variable (and at runtime).
            -   To create a `          site.settings         ` file:
            -   Copy `          source/tools/build/site.settings.template         ` into `          source/tools/build/site.settings         `
            -   In the `          library_path         ` dictionary, add a string containing the path to the directory containing the libmysql client libraries (e.g. `          "/home/jdoe/lib/mysql-connector-c-6.1.2-linux-glibc2.5-x86_64/lib"         ` )

        -   Symlink or place mysql.h (and other required headers) into `        external/dbio/mysql       `
        -   Compile with `        extras=mysql       `

    -   Ubuntu-specific (and maybe other Linux) instructions to build Rosetta with MySQL support:
        -   Install `        libmysqlclient       ` by installing the `        libmysqlclient-dev       ` client from your distro's package manager (e.g. `        apt-get install libmysqlclient-dev       ` )
            -   Note: this should ensure the libraries are included in your path, removing the need to mess with your library path

        -   Symlink header files into `        external/dbio/mysql       ` by running `        ln -s /usr/include/mysql/* .       `
        -   Compile with `        extras=mysql       ` as above

-   **PostgreSQL**
    -   [PostgreSQL](http://www.postgresql.org/) is a client-server architecture
    -   To build Rosetta with PostgreSQL support:
        -   Build `        libpq       ` and install it in the `        LD_LIBRARY_PATH       ` environment variable (note: make sure to use the same client library version as the database server).
        -   Symlink the `        postgreSQL       ` direcotry into `        Rosetta/main/source/external/dbio/       ` .
        -   Compile with `        extras=postgres       `

database connection information can be specified with these RosettaScripts and or command line [[options|RosettaScripts-database-connection-options]] .

FeaturesReporter Framework
--------------------------

For many applications, one would like to store and retrieve information about a set of structures, for example maybe its relevant to store the atomic coordinates, how similar each structure is to the native and the predicted binding energy (maybe the project is protein interface design, and the set consists of all the structures in various rounds of prediction). We have developed a **modular database schema** , where each `   FeaturesReporter  ` is responsible for a set of tables in the database. Using a particular schema, features for a set of structures is stored as a *batch* in the database.

-   Here are all of the [[features reporters|FeatureReporters]] have have been [[created|FeaturesScientificBenchmark]] so far.
-   See [here](http://contador.med.unc.edu/features/paper/features_optE_methenz_120710.pdf) for an example of using the features database for scientific benchmarking.
-   The primary way of reporting features to a features databas is through the [[ReportToDB|Movers-RosettaScripts#ReportToDB]] mover in RosettaScripts.

Job Distribution and Database IO
--------------------------------

Structures can be read from, and written to a relational database when using the JD2 job distributor. Advantages over pdb files or silent files include:

-   Specifying input through SQL queries and filtering data based what is currently stored in the database
-   Interface with other bioinformatic datasets once structures are in a relational database
-   Store additional information along with structures using FeaturesReporters (e.g. by using the ReportToDB mover for output)
-   Ensure consistency through database constraints such as foreign keys and atomic transactions with the database
-   More compressed than PDB files and almost as compressed as binary silent files.

Database IO is implemented simply as a fixed set of FeaturesReporters:

-   Meta Features:
    -   **ProtocolFeatures** : About the Rosetta application invocation
    -   **BatchFeatures** : About the set of structures
    -   **JobDataFeatures** : Generic protocol reporting information

-   Whole Structure Features:
    -   **StructureFeatures** : About each structure
    -   **PdbDataFeatures** : (If the PDBInfo exists) About the pdb numbering, temperature and occupancy
    -   **ScoreTypeFeatures** : The defined score types
    -   **StructureScoresFeatures** : The Rosetta score function broken down by score type
    -   **PoseConformationFeatures** : The topology of the conformation including foldtree, jumps, etc.
    -   **PoseCommentsFeatures** : Additional comments added to the pose.

-   Per Residue Features
    -   **ResidueFeatures** : About each residue
    -   **[Protein]ResidueConformationFeatures** : Residue coordinates, if the structure is ideal and canonical residues only, then only torsion angles are stored, otherwise the coordinates of each atom.

Possible issues for cluster based jobs:

-   SQLite3 database are hard on file systems so be careful when using it with a shared filesystem!
-   Databases can be merged because the features have composite primary keys that includes the structure primary key, **struct\_id** , that at least partially randomized. to merge sqlite3 database consider using the merge script in main/tests/features/sample\_sources/merge.sh.

-   -in:use\_database
-   -out:use\_database \<bool\> *output files to the database*
-   -out:database\_protocol\_id \<int\> *Manually specify a protocol ID. This option must be specified if multiple processes are writing to a single database (for example, when using MPI). Databases created with this option specified cannot be written to without this option, and vice versa*
-   -out:database\_filter \<string vector\> *specify a database filter and associated options, see the Database filters section below for details*

Pose IO
-------

Rosetta can input poses from a database, and output poses to a database. Support for this behavior is supported in any application which utilizes the JD2 job distributor. The DatabaseJobOutputter is compatible with both serial and parallel jobs, and automatically detects non-ideal poses and properly handles output.

Multiple executions of Rosetta can be stored in the same database. Each execution will have a separate protocol\_id. If -out:database\_protocol\_id is not specified, the protocol\_id field auto-increments. The Rosetta SVN version, command line, XML script (if available) and flags are stored in the database.

### Extracting Poses

Poses can be extracted from the database into PDB or Silent files using the application score\_jd2. MySQL and sqlite3 interfaces are also available for perl, python, R and other scripting languages, making it possible to directly parse and analyze data without extracting it. Poses can be extracted from a database in code using protocols::features::ProteinSilentReport::load\_pose() function.

### Database Filters

Database filters allow you to only output poses that meet some criteria based on the existing poses in the database. Database filters are invoked from the command line with the following syntax:

`   -out:database_filter <database filter name> <list of database filter options>  `

At present 4 database filters are implemented:

-   TopPercentOfEachInput \<scoring\_term\> \<percentile\> *Output only the top n percent of generated structures for each input structure based on the specified scoring term. A percentile value of 0.10 corresponds to 10%*
-   TopPercentOfAllInputs \<scoring\_term\> \<percentile\> *Output only the top n percent of generated structures over all input structures based on the specified scoring term. A percentile value of 0.10 corresponds to 10%*
-   TopCountOfEachInput \<scoring\_term\> \<count\> *Output only the top n generated structures for each input structure based on the specified scoring term.*
-   TopCountOfAllInputs \<scoring\_term\> \<count\> *Output only the top n generated structures for all input structures based on the specified scoring term.*

##See Also

* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[RosettaScripts database connection options]]
* [[Features reporter overview]]: Home page for the Features Reporter, a tool for outputting information to databases using Rosetta
* [[Database options]]: Database-related command line options
* [[The Rosetta database|database]]: Information about the main database included with Rosetta and specified by the -in:path:database flag (separate topic)
