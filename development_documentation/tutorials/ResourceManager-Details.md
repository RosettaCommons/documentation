ResourceManager Details
========================

ResourceManager Documentation
-----------------------------

The **doxygen** code documentation page for the ResourceManager 
describes the architecture and design. The [[ResourceManager]] page
describes the implementated of the components.

### Developers

-   Matthew O'Meara
-   Andrew Leaver-Fay
-   Brian Weitzner

### Motivation

Right now it is difficult to get resource data into a Rosetta protocol.
A motivating example is using electron density maps while designing
multiple scaffolds. Each scaffold requires its density map to be loaded
from disk and be made accessible. Often there are multiple hits per
scaffold that require separate design runs. Because of the cost of
loading an electron density map from disk, and the large memory
footprint it consumes once loaded, it is desirable to load the resource
when needed and then unloaded when it is not. The resource manager is a
protocol-independent system for managing static data and making it
available to protocols. Additional candidate static data to be managed
by the resource manager include native poses, experimental constraints,
chemical shift data, fragments, and configuration files such as loop
definitions, resfiles, and symmetry definitions.

Current protocols address this resource management problem with the
following inadequate solutions:

-   Option system: The option system represents options coming from
    things like the command line. It is designed to be a static
    structure once it has been initialized and many places have taken
    advantage of that by--say--only reading during an initialization
    stage. Being static does not allow multiple values to be specified
    for a field, making it awkward to specify multiple instances of a
    resource.
-   JD2 Batching: The batching system allows the option system to be
    modified between different input structures. This allows multiple
    resources to be specified at the expense of breaking the property
    that the option system is static.
-   Database reader: A resource is looked up on a database table by the
    input tag. This still requires the protocol to keep track of the
    structure once it has been loaded.
-   DataCache: Data can be associated with a pose and then looked up
    later. This but it is can be tricky to transfer just the information
    that is needed say between different hits for the same target.
-   JD2::JobInputter Custom JobInputters can be made to handle different
    types of input data, however, JD2 is designed to partition runs on
    the input-type, so it makes it convoluted to use it to load multiple
    types of data.

### Design Objectives

-   Allow users to specify external data resources and options to be
    used with specific jobs
-   Allow protocol developers to easily request resources and get fully
    initialized resources
-   Decouple the option system from protocols to allow different
    protocol configuration options to be used for different jobs
-   Control the lifecycle of shared resources to conserve memory

### Software Tasks

TODO:

-   Finish doxygen page
-   Add ResourceLocators
    -   SerializationLocator
    -   SilentFileLocator

-   Add ResourceLoaders
    -   ResfileLoader (hm, tricky because resfile parsing isn't
        separated from applying it to a pose)
    -   FragFile
    -   Constraints
    -   SilentFile (all the different versions)

Resource Definitions Syntax
===========================

"Skeleton" XML Format
---------------------

       <JD2ResourceManagerJobInputter>
           <ResourceLocators>
                Describe data stores where resources are located
           </ResourceLocators>
           <ResourceOptions>
                 Describe options needed to initialize and configure resources
           </ResourceOptions>
           <Resources>
                 Define how resource should be loaded
           </Resources>
           <Jobs>
                 Define jobs by indicating resources and options.
           </Jobs>
       </JD2ResourceManagerJobInputter>

Once the resource definition file has been prepared it may be specified
on the command line for a particular protocol using the option
-resource\_definition\_files. An example is below.

    loopmodel.macosclangrelease @flags -resource_definition_files test.xml

An Annotated Example
--------------------

A job is the single execution of a protocol, for example a
RosettaScripts protocol or a Mover distributed through the JD2 job
distributor. This example sets up a single job named `1xu1FH_D` that
uses as a starting structure the pdb file `1xu1FH_D.pdb` in the
directory `/path/to/input/pdbs` and uses the symmetry definitions file
`1xu1FH_d.symm`.

    <JD2ResourceManagerJobInputter>

           <ResourceLocators>
                   Each ResourceLocator provides a locator_id -> istreams map to initialize a resource

                   <FileSystemResourceLocator tag="startstruct_locator" base_path="/path/to/input/pdbs"/>
                   The "startstruct_locator" takes path relative to /path/to/input/pdbs
                   and returns the contents of the file. This is referenced below in the
                   Resources block to initialize the starting structure.

                   <FileSystemResourceLocator tag="symmetry_definition_locator" base_path="/path/to/input/symmetry_definitions"/>
                   The "symmetry_definitions_locator" takes a path relative to
                  /path/to/input/symmetry_definitions and returns the contents of the file.
                   This is referenced below in the Resources block to initialize the starting structure.

           </ResourceLocators>

           <ResourceOptions>
                   Each ResourceOptions defines non-default options for how a resource
                   should be constructed from the istream input provided by the ResourceLocator

                   <PoseFromPDBOptions tag="pdb_options" ignore_unrecognized_res=1/>
                    The "pdb_options" is a PoseFromPDBOptions and is used when loading
                    a pose from data in the protein databank PDB format. Here, residues that
                    are not recognized are ignored. Alternatively, the non-standard residue types
                    can be loaded on a per-job basis in the jobs section.

           </ResourceOptions>

           <Resources>
                   A Resource is a fully constructed object whose lifetime and availability
                   is managed by the ResourcManager.

                   <PoseFromPDB tag="1xu1FH_D_startstruct" locator_tag="startstruct_locator" locatorID="1xu1FH_D.pdb" resource_options=pdb_options/>
                   The "1xu1FH_D_startstruct" resource is a Pose object that is Rosetta's
                   central representation of a structure and stores the conformation and
                   energy information. In this case, the Pose is constructed from the pdb file
                   provided by the "startstruct_locator" using "1xu1FH_D.pdb" as the relative path.
                   It uses the "pdb_options" as configuration options for how the pose should
                   be constructed from the pdb file.

                   <SymmData tag="1xu1FH_D_symmetry_definition" locator_tag=symmetry_definition_locator locatorID="1xu1FH_D.symm"/>
                   The "1xu1FH_D_symmetry_definition" resource is a SymmData object that
                   is used to convert an asymmetric unit into a symmetric conformation.
                   The symmetry definition file is created using the perl script in
                   main/source/src/apps/public/symmetry/make_symmdef_file.pl.  

           </Resources>

           <Jobs>
            A job is a unit of work that is processed by the JD2 Job distributor. In this block,
            resources defined in the Resources block are mapped to resource descriptions
            that can be referenced from within the protocol. All jobs must provide the same
            resource descriptions, but can refer to different resources.   All jobs must also contain 
            one field specifying the starting pdb with a data description "startstruct" 

                   <Job name="1xu1FH_D">
                   This job has name "1xu1FH_D". If it produces pdb output, it will have
                   the filename 1xu1FH_D_0001.pdb.
                   
                           <Data desc="startstruct" resource_tag=1xu1FH_D_startstruct/>
                           This tag maps the Pose resource with tag "1xu1FH_D_startstruct"
                           defined in the Resources block to the resource description "startstruct".
                           The "startstruct" resource description is referenced by the JD2 resource
                           manager to be the input Pose for the protocol.

                           <Data desc="symmdata" resource_tag=1xu1FH_D_symmetry_definition/>
                           This tag maps the SymmData resource with tag 
                           "1xu1FH_D_symmetry_definition" defined in the Resources block to the
                           resource description "symmedata". This can be referenced, for example in
                           RosettaScripts with the mover tag <SetupForSymmetry name=(&string)
                           resource_description=symmdata/>.

                   </Job>

           </Jobs>

    </JD2ResourceManagerJobInputter>

ResourceLocators
----------------

A *ResourceLocator* is used to interface with a data store and provide
map from *LocatorID* to *istream*. Resource locators can be defined in
the *ResourceLocators'* tag block

       <ResourceLocators>
          <(resource_locator_type) locator_tag=(&string)  (other options to be processed by the resource_locator_type)/>
          ....
       </ResourceLocators>

For example to define a resource locator that looks up file in the file
system,

       <FileSystemResourceLocator locator_tag="filesys"/>

By default, a FileSystemResourceLocator is created with locator tag "".

### NullResourceLocator

For resources that can be initialized from scratch, the
**NullResourceLocator** is a placeholder. For example the
DatabaseSessionResource does not read from the a datastore, so it can
use the NullResourceLocator

       <NullResourceLocator tag=(&string)/>

### FileSystemResourceLocator

The filesystem resource locator acts as a map: **file name** --\> **file
contents**.

       <FileSystemResourceLocator tag=(&string)/>

A locator\_id uses the the following search path first looks in the
current working directory then in the values specified on with the
`-in:path` option. If the filename ends in `.gz` it will try to open the
file as if it is a gzipped file with the `izstream` library.

### DatabaseResourceLocator

The database resource locator acts as a map: **key column** --\> **value
column** in a SQL result table.

       <DatabaseResourceLocator tag=(&string) database_session_tag=(&string) sql_command="SELECT ... ;"/>

-   The `database_session_tag` should reference a previously defined
    *resource\_tag* in a \<Resources/\> block.
-   The `sql_command` should have a single *?* that is substituted with
    the locator\_id.

As an example, let the rosetta\_inputs.db3 have a single table

       CREATE TABLE  pdb_file (pdb_code TEXT, pdb_file TEXT, PRIMARY KEY(pdb_code));

Then the following resource definitions file, loads the *pdb\_file*
contents for the row with *pdb\_code* '1xu1FH\_D' into the resource
description 'startstruct'. A full working version of this example is in
the *resource\_database\_locator* integration test.

        <JD2ResourceManagerJobInputter>                                                                                                                                        
            <ResourceOptions>
                <DatabaseSessionOptions tag="input_db_options" database_mode="sqlite3" database_name="rosetta_inputs.db3"/>
            </ResourceOptions>
            <Resources>
                <DatabaseSession tag="rosetta_inputs_db" options="input_db_options" locator=NULL/>
            </Resources>                                                                                                                                                   
                                                                                                                                     
            <ResourceLocators>
                 <DatabaseResourceLocator tag="starting_structures" database_session_tag="rosetta_inputs_db" sql_command="SELECT pdb_file FROM starting_structures WHERE pdb_code = ?;"/>
            </ResourceLocators>

            <Resources>
                <PoseFromPDB tag="1xu1FH_D_starting_struct" locator=starting_structures locatorID="1xu1FH_D"/>
            </Resources>

            <Jobs>
                 <Job name=1xu1FH_D>
                      <Data desc=startstruct resource_tag=1xu1FH_D_starting_struct/>
                  </Job>
            </Jobs>
        </JD2ResourceManagerJobInputter>

### FileListResourceLocator

The FileListResourceLocator accepts as a locator string a list of paths
to files, separated by spaces (not tabs). These files are then
concatenated into a single file. This is particularly useful in docking
studies, as a list of PDBs can be concatenated into a single pose. A
working example of this can be found in the file\_list\_locator
integration test. A syntax example is below:

    <JD2ResourceManagerJobInputter>
      <ResourceLocators>
        <FileListResourceLocator tag="file_list"/>
      </ResourceLocators>
      <Jobs>
        <Job name="example" nstruct="1">
          <Data desc="startstruct" pdb="partner_1.pdb partner_2.pdb" locator="file_list"/>
        </Job>
      </Jobs>
    </JD2ResourceManagerJobInputter>

ResourceLoaders
---------------

A *ResourceLoader* is responsible constructing and initializing a object
from a istream provided by the ResourceLocator and a *ResourceOptions*
specific for the *ResourceLoader*.

       <Resources>
           General Form:
           <(resource_loader_type) resource_tag=(value of locator_id &string) locator_tag=("" &string) locator_id=(&string) options=(default options &string)/>

           File Resource Shortcut:
           <(resource_loader_type) resource_tag=(value of locator_id &string) file=(&string) options=(default options &string)/>
       </Resources>

The **resource\_tag** is referenced in the **Jobs** block. If the value
of the *resource\_tag* is not specified, the value of the locator\_id is
used.

### DatabaseSessionLoader

Create a **utility::sql\_database::sessionOP** object.

       <DatabaseSession [standard ResourceLoader items]/>

Note this resource can use the `NullResourceLocator`.

       <DatabaseSessionOptions tag=(&string) database_connection_options/>

### ElectronDensityLoader

Create a **core::scoring::electron\_density::ElectronDensityOP** object
from a MRC or CCP4 electron density map.

       <ElectronDensity [standard ResourceLoader items]/>

       <ElectronDensityOptions tag=(&string) mapreso=(3.0 &real) grid_spacing=(0.0 &real)/>

Documentation for electron density map scoring is available at the
[[Scoring Structures with Electron Density|density-map-scoring]] page. 

**NOTE:** The *electron\_density* score term looks for an
ElectronDensity resource with description `electron_density` and it
won't find it otherwise.

### LoopsFileLoader

Create a **protocols::loops::LoopsFileDataOP** object from a loops file.

       <LoopsFile [standard ResourceLoader items/>

       <LoopsFileOptions tag=(&string) prohibit_single_residue_loops=(1 &bool)/>

### PoseFromPDBLoader

Create a **core::pose::PoseOP** object from a pdb file.

       <PoseFromPDB [standard ResourceLoader items]/>

       <PoseFromPDBOptions tag=(&string) termini=(1 &bool) exit_if_missing_heavy_atoms=(0 &bool) ignore_unrecognized_res=(0 &bool) ignore_waters=(0 &bool) ignore_zero_occupancy=(0 &bool) keep_input_protonation_state=(0 &bool) preserve_header=(0 &bool) randomize_missing_coords=(0 &bool) remember_unrecognize_res=(0 &bool) remember_unrecognized_waters=(0 &bool) treat_residues_in_these_chains_as_separate_chemical_entities=(" " &string)/>

### SymmDataLoader

Create**core::conformation::symmetry::SymmDataOP** object from a
symmetry definitions file.

       <SymmData [standard ResourceLoader items]/>

      <SymmData tag=(&string)/>

### ResidueTypeLoader

A ResidueTypeLoader inserts a params file into the chemical manager when
a job requiring that params file is started. ResidueType resources are
associated with jobs through the use of the ResidueType subtag (see the
example below). When the params file is no longer needed by any pending
job, it is unloaded from the chemical manager. This lazy loading only
applies to ResidueTypes input through the ResidueTypeLoader. Default
residues specified in the database or through the normal command line
options are unaffected. A working example of this code is in the
residue\_data\_resource integration test. A syntax example is below:

Note: At the present time, only a single ResidueType can be associated
with each job.


    <JD2ResourceManagerJobInputter>
        <Resources>
            <ResidueType file="new_residue.params"/>
        </Resources>
        <Jobs>
            <Job name="new_job">
                <Data desc="startstruct" pdb="input.pdb"/>
                <ResidueType resource_tag="new_residue.params"/>
            </Job>
        </Jobs>
    </JD2ResourceManagerJobInputter>

Resource Descriptions
=====================

Purpose
-------

In this section are gathered the list of all supported resource
descriptions, the Resource they map to, and their associated
FallbackConfiguration classes

core
----

protocols
---------

-   "LoopsFile" maps to a protocols::loops::LoopsFile object. It's
    fallback is protocols::loops::LoopsFileFallbackConfiguration

Writing Unit Tests
==================

(added by Rebecca Alford)

So you have written some resource loaders, but now you would like to
load these resources into a unit test. To do so, follow the steps below:

1. Add your resource definition XML to the test as a string (I found it
cleaner to put this in a function and return it)

       /// @brief Job String
       "<JD2ResourceManagerJobInputter>\n"
       "  <ResourceLocators>\n"
       "    <FileSystemResourceLocator tag=1afo base_path=\"core/membrane/io/\" />\n"
       "  </ResourceLocators>\n"
       "  <Resources>\n"
       "    <PoseFromPDB tag=1afo_startstruct locator=1afo locatorID=\"core/membrane/io/1afo_test.pdb\" />\n"
       "    <LipoFile tag=1afo_lips locator=1afo locatorID=\"core/membrane/io/1afo_test.lips\" />\n"
       "  </Resources>\n"
       "  <Jobs>\n"
       "    <Job name=membrane>\n"
       "      <Data desc=\"startstruct\" resource_tag=1afo_startstruct />\n"
       "      <Data desc=\"lipids\" resource_tag=1afo_lips />\n"
       "    </Job>\n"
       "  </Jobs>\n"
       "</JD2ResourceManagerJobInputter>\n";

2. Fill a job (see JD2JobDistributorSImilifiedInput.cxxtest.hh)

3. Using a lazy resource manager, load your resource by job tag
    (specify the **Data description** (not the resource tag) and job tag

4. Use the pattern:

      if (! lazy_resource_manager->has_resource_tag_by_job_tag("lipids", "membrane"))
              {
                  throw utility::excn::EXCN_Msg_Exception(" Either a resource definition file or the command line option "\
                                                          "-in:file:lipofile must be specified");
              }
      basic::resource_manager::ResourceOP lipids = lazy_resource_manager->get_resource_by_job_tag( "lipids", "membrane" );

5. Downcast to you resource type

       core::membrane::util::LipidAccInfoOP lips_exp = dynamic_cast< LipidAccInfo * >( lipids () );

(Note: this section references code in my branch -
rfalford12/membrane\_frmwk\_w\_db in
test/core/membrane/io/LoadAllResourcesTest.cxxtest.hh)

Possible FAQ
============

(added by Rebecca Alford)

To add locators, options, loaders, and fallback configurations,
remember to register your new classes in the appropriate init.ihh files
in protocols/init. I think you can also register them in core but this
didn't work for me. 2. Be careful when copying boilerplate resource
manager code. Some templates have a fixed RG seed and if you forget to
change it your entire unit testing suite will crash. Cannot have to
equivalent seeds.

##See Also

* [[ResourceManager Main Page|ResourceManager]]
* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Application Documentation]]: Information on existing Rosetta apps
* [[RosettaScripts]]: Instructions for writing RosettaScripts, the Rosetta XML interface
* [[Using the job distributor|jd2]]
* [[RosettaEncyclopedia]]: Detailed descriptions of concepts in Rosetta.
* [[Running Rosetta with options]]: Instructions for running Rosetta executables


<!--
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager-->