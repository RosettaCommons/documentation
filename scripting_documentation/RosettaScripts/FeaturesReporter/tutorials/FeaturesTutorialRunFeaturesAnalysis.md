#Features Tutorial: Run features analysis

Comparing sample sources takes one or more databases of features and a set of analysis scripts and generated plots and statistics.

Compare Sample Sources
==============================

The `compare_sample_sources.R` script (located in `rosetta/main/tests/features/`) runs feature analysis scripts on feature databases. It takes as input:

-   Paths to one or more feature databases as *sample\_sources*
-   One or more analysis scripts
-   An output directory and output formats
-   Other options

It then passes this configuration information to each analysis script. Usually the analysis script will generate the plots and statistics in

        path_to_output_dir/<sample_source1>[_<sample_source2>[_...]]/<output_format>/

There are several ways to run `compare_sample_sources.R` , which are described below. If you forget later, try

       compare_sample_sources.R --help


Run One Script at a Time
------------------------

To run a single analysis script on one or more database,

       cd project/features
       path/to/rosetta/main/tests/features/compare_sample_sources.R [OPTIONS] --script <analysis_script.R> path/to/features_<ss_id1>.db3 [path/to/features_<ss_id2>.db3 [...]]

Note:

-   The search path for `--script` is `[".", "path/to/rosetta/main/tests/features"]` .
-   This will generate the results in `project/features/build/`
-   This will generate `project/features/compare_sample_sources_iscript.R` . In an interactive R session,

<!-- -->

        >source("compare_sample_sources_iscript.R")

will return the script and leave you to do further interactive analysis.

Run a Configuration File
------------------------

To run one or more features analysis with a JSON configuration file:

       cd project/features
       path/to/rosetta/main/tests/features/compare_sample_sources.R --config analysis_configurations/<features_analysis>.json

The advantage of running `compare_sample_source.R` from a configuration script include:

-   the command line to run a features analysis can get long and complicated, while it has a cleaner layout in the configuration .json file, making it easier to share/re-run.
-   It's possible to run multiple feature analyses at once.
-   You can give more descriptive names to the sample\_sources than the names of the database. This is important because they end up in the legends of the plots etc.
-   You can pass in additional parameters into the analysis scripts to make more structured plots, etc.

The format for the analysis configuration uses the [`.json`](http://www.json.org/) format, which is basically nested python dictionaries and lists with numbers and strings as leaves. Many text readers and programming languages can unerstand JSON files (ex python, subl, PyCharm). Here is an example script that was to generate figure 3 in the [Rosetta Scientific Benchmarking](http://contador.med.unc.edu/features/paper/features_optE_methenz_120710.pdf) paper:

    {  
        "output_dir" : "build/general_analysis",  
        "sample_source_comparisons" : [  
            {  
                "sample_sources" : [  
                    {  
                        "database_path" : "/home/momeara/scr2/data/sp2_8b/top8000_sp2_r47244_120205/features_top8000_sp2_r47244_120205.db3",  
                        "id" : "Native",  
                        "reference" : true  
                    },  
                    {  
                        "database_path" : "/home/momeara/scr2/dun10_vs_bicubic/top8000_relax_r46440_111213/features_top8000_relax_r46440_111213.db3",  
                        "id" : "Relaxed Native Score12",  
                        "reference" : false,  
                        "model" : "Score12"  
                    },  
                    {  
                        "database_path" : "/home/momeara/scr2/data/sp2_no_lj_correction/top8000_relax_sp2_no_lj_correction_r48561_120518/features_top8000_relax_sp2_no_lj_correction_r48561_120518.db3",  
                        "id" : "Relaxed Native NewHB",  
                        "reference" : false,  
                        "model" : "NewHB"  
                    },  
                    {  
                        "database_path" : "/home/momeara/scr2/data/sp2_8b/top8000_relax_sp2_r47244_120205/features_top8000_relax_sp2_r47244_120205.db3",  
                        "id" : "Relaxed Native NewHB LJcorr",  
                        "reference" : false,  
                        "model" : "NewHB"  
                    }  
                ],  
                "analysis_scripts" : [  
                    "scripts/analysis/plots/hbonds/hydroxyl_sites/OHdonor_AHdist.R"  
                ],  
                "output_formats" : [  
                    "output_small_eps"  
                ]  
            }  
        ]  
    }  

Notes:
 
-   In the `sample_sources` block, the `database_path` and `id` are the only required tags. Additional tags are passed into the analysis script as columns in the `sample_sources` parameter to the `run` function.
-   The `analysis scripts` , `output_dir` , `output_formats` are parsed in the same way as if they are on the command line.
-   This also generates a `compare_sample_sources_iscript.R`


Suggested Directory Layout
--------------------------

When using sqlite3 feature database, I like to setup the following directory structure. (Note: I generate the sample\_source directories as a result of a cluster run using `rosetta/main/tests/features/features.py` and templates in `rosetta/main/tests/features/sample_sources/`. This is described in detail [[here|FeaturesTutorialRunSciBench]].)

        project/
           sample_source_id1_r#######_YYMMDD/                   #e.g. Top8000
               features_sample_source_id1_r#######_YYMMDD.db3   #experimental, X-ray 
               features.xml
               flags
               <log_files>
           sample_source_id2_r#######_YYMMDD/                   #e.g. Top8000_relax
               features_sample_source_id2_r#######_YYMMDD.db3   #relaxed natives
               features.xml
               flags
               <log_files>
           sample_source_id3_r#######_YYMMDD/                   #e.g. Top8000_relax_new
               features_sample_source_id3_r#######_YYMMDD.db3   #relaxed_natives with
               features.xml                                     #alternative score function
               flags
               <log_files>
           features/                                            #run compare_sample_sources.R from here
               compare_sample_sources_iscript.R                 #autogenerated to re-run interactively
               analysis_configurations/
                    feature_analysis1.json                      #These are passed in
                    feature_analysis2.json                      #with the --config flag
                    feature_analysis3.json
               build/
                     sample_source_id1_sample_source_id2_sample_source_id3/
                           analysis_script_id1/
                                output_pdf_huge/
                                    <plots.pdf>
                                output_pdf_print/
                                    <plots.pdf>
                                ...
                           analysis_script_id2/
                                ...

Notes and thoughts on the directory layout:

-   Keeping the databases and data analysis in a `    project   ` directory helps maintain separation when doing different projects or major iterations of the project and keeps it separate from the `rosetta` code base. It is much easier to stage commits and update revisions if your workspace isn't mixed in! And when you get it in a good state, it is easier to wrap it up and share it with collaborators, publish, etc.
-   Keeping the `flags` , `features.xml` and log files with the features database makes it is easy to remember how it was generated and re-run it in case it needs to be updated.
-   Having the SVN/GIT revision number and the execution date in the database name helps in not misplacing or using the wrong features database. The date code format is a trick I learned from Jack Snoeyink to make sorting files lexicographically also sorting it by date.
-   Keeping the `analysis_configurations` together makes it easy to share and re-run the analysis scripts.
-   The build output directory structure is generated by compare\_sample\_sources.R. I wish rather than having each plot or bit of statistical data in a directory structure, it could be tagged with various meta information. I played with putting the plots into a SQLite3 database, and auto-generating navigable webpages, but browsing files and Preview are hard to beat. Part of the challenge is that vector versions of the plots are so much crisper when there is lots data on a page, but the files get can get large--especially for scatter plots. If anyone has ideas about how to solve the plot navigation problem I (Matt O'Meara) would be interested to hear.

