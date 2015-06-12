#How to Set Up R for the Features Scientific Benchmark
=====================================================

The Features Scientific Benchmark requires R version 2.11 or higher.

 It's easy to install packages from within R:

        > install.packages("package_name")

 Alternatively to install everything from source see below. For more information see the [R Installation and Administration](http://cran.r-project.org/doc/manuals/R-admin.html) page or the [Comprehensive R Archive Network](http://cran.fhcrc.org/) .

        cd /tmp
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/base/R-2/R-2.12.1.tar.gz

        tar -xzvf R-2.12.1.tar.gz
        rm R-2.12.1.tar.gz
        cd R-2.12.1

        ./configure --prefix=<path_to_install_dir>
        make
        make check
        make install
        cd ..

        #make sure the newly installed R works and is on the path:
        R --version | grep "R version"


        #useful plotting and analysis packages:
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/Hmisc_3.8-3.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/boot_1.2-43.tar.gz

        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/iterators_1.0.3.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/itertools_0.1-1.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/plyr_1.4.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/reshape_0.8.3.tar.gz

        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/proto_0.3-8.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/RColorBrewer_1.0-2.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/colorspace_1.0-1.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/digest_0.4.2.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/ggplot2_0.8.9.tar.gz

        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/DBI_0.2-5.tar.gz
        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/RSQLite_0.9-4.tar.gz

        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/Design_2.3-0.tar.gz

        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/KernSmooth_2.23-4.tar.gz

        wget http://mirrors.ibiblio.org/pub/mirrors/CRAN/src/contrib/logspline_2.1.3.tar.gz

        #installing in the following order should take care of dependencies
        R CMD INSTALL Hmisc_3.8-3.tar.gz
        R CMD INSTALL boot_1.2-43.tar.gz
        R CMD INSTALL iterators_1.0.3.tar.gz
        R CMD INSTALL itertools_0.1-1.tar.gz
        R CMD INSTALL plyr_1.4.tar.gz
        R CMD INSTALL reshape_0.8.3.tar.gz
        R CMD INSTALL proto_0.3-8.tar.gz
        R CMD INSTALL RColorBrewer_1.0-2.tar.gz
        R CMD INSTALL colorspace_1.0-1.tar.gz
        R CMD INSTALL digest_0.4.2.tar.gz
        R CMD INSTALL ggplot2_0.8.9.tar.gz
        R CMD INSTALL DBI_0.2-5.tar.gz
        R CMD INSTALL RSQLite_0.9-4.tar.gz
        R CMD INSTALL Design_2.3-0.tar.gz
        R CMD INSTALL KernSmooth_2.23-4.tar.gz
        R CMD INSTALL logspline_2.1.3.tar.gz

**Integrated Development Environment**
--------------------------------------

I have been enjoying using [RStudio](http://www.rstudio.org/) to do data analysis with R.


##See Also

* [[FeaturesRScripts]]: Home page for R scripts to use with the FeaturesReporter
* [[Features reporter overview]]: The FeaturesReporter home page
* R tutorials for FeaturesReporters
  * [[FeaturesTutorialRBasics]]
  * [[FeaturesTutorialGGplots2Basics]]
  * [[FeaturesTutorialPlotScript]]
  * [[FeaturesTutorialPlotTuning]]
* [[FeaturesTutorials]]: Tutorials for using FeaturesReporters
* [[FeatureReporters]]: List of implemented FeatureReporters
* [[RosettaScripts home page|RosettaScripts]]
* [[RosettaScripts database connection options]]
* [[Database IO]]: Input/output to databases using Rosetta
* [[Rosetta Database Output Tutorial]]
* [[SQLite3 Interface]]: Specific information on using SQLite3 with Rosetta
* [[Database support]]: Advanced details on Rosetta's interface with databases
* [[Database options]]: Database-related command line options