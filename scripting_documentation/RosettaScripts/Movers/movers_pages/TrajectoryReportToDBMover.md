# TrajectoryReportToDB
*Back to [[Mover|Movers-RosettaScripts]] page.*
## TrajectoryReportToDB

The TrajectoryReportToDB mover is a subclass of [[ReportToDB|Movers-RosettaScripts#ReportToDB]] that can be used in Rosetta scripts to report features multiple times to a database for a single output, creating a "trajectory". Since this mover is a subclass of above, any tag or option described for ReportToDB can also be used here. See [[ReportToDB|Movers-RosettaScripts#ReportToDB]] for these options.

Structures are mapped to cycle step in the trajectory\_structures\_steps table. To select all trajectory output for a particular run, group struct\_ids by output tag (found in the structures table).

**ReportToDB Tag** :

-   Any tag used in [[ReportToDB|Movers-RosettaScripts#ReportToDB]] can also be used in TrajectoryReportToDB
-   **stride** *(&int)* : This one additional tag is unique to TrajectoryReportToDB. It controls the "stride", or how often trajectory features are reported in a simulation. Example: if stride is set to 10, then features will be reported every 10th iteration of the protocol.

**Feature Subtags** : Same as [[ReportToDB|Movers-RosettaScripts#ReportToDB]]

-   The following tables are created:
    -   **trajectory\_structures\_steps** : Maps struct\_id to trajectory step count.

<!-- -->

        CREATE TABLE trajectory_structures_steps(
             struct_id INTEGER NOT NULL,
             step INTEGER NOT NULL,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, step));


##See Also

* [[ReportToDBMover]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: information on database input/output in Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options
* [[I want to do x]]: Guide to choosing a mover
