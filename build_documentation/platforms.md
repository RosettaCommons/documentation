**NOTE: This information may be out of date**

Rosetta can be built and run on a number of platforms, described below. However, the level of support varies:

-   **Full support** means we have tested Rosetta on the platform both programmatically and scientifically and have the expertise to handle questions about it.
-   **Partial support** means we have built and run Rosetta on the given platform. We have not done extensive testing of the scientific results, so your mileage may vary. We will try to answer questions, and walk you through particular builds.
-   **No support** means that we have not been able to try Rosetta on that platform. It may work or it may not. If you run into trouble we will answer whatever we can, but be aware that we may not be able to help. If you can get it to work, please tell us.
-   **Doesn't work** means that we know (or have reason to believe) that you can't run Rosetta on the platform. If you successfully run it, let us know.

##Full Support
=======================

-   Darwin Kernel Version 9.6.0: root:xnu-1228.9.59\~1/RELEASE\_I386 i386

    ```
    Scons script: v1.2.0.r3842
    gcc-4.0.1
    ```

-   Darwin Kernel Version 9.5.2: root:xnu-1228.8.59\~2/RELEASE\_I386 i386

    ```
    Scons script: v1.0.1.r3363
    gcc-4.0.1 (GCC) 4.0.1
    ```

-   Linux 2.6.27-9-generic \#1 SMP x86\_64 GNU/Linux

    ```
    Scons script: v0.98.5.r3057
    gcc (GCC) 4.1.1, gcc (GCC) 4.2.4, gcc (GCC) 4.3.2
    Note: GCC with Ubuntu 4.3.2-1ubuntu12 and any version after it does not work
    ```

-   Linux 2.6.10-1.741\_FC3smp \#1 SMP i686 athlon i386 GNU/Linux

    ```
    Scons scripts v0.98.5.r3057
    gcc-4.1.1, gcc-3.4.4
    ```

-   Linux 2.6.9-78.0.8.ELsmp \#1 SMP Wed i686 i686 i386 GNU/Linux

    ```
    Scons scripts v1.2.0.r3842
    gcc (GCC) 3.4.6 20060404 (Red Hat 3.4.6-10)
    ```

##Partial Support
=============================================

-   Fedora Core Linux v3 or greater, x86, 32-bit, GCC 4.0 (\*)(\*\*)
-   RedHat Enterprise Linux v3 or greater, x86, 32-bit, Intel C++ 9.1 (\*)
-   RedHat Enterprise Linux v3 or greater, x86, 32-bit, GCC 4.0(\*\*)
-   MinGW on Microsoft Windows XP, 32-bit, GCC 3.4

Note: (\*) These should work because of the similarity between Fedora Core and RedHat Enterprise Linux but were not explicitly tested. (\*\*)For GCC version 4.0 and above, we recommend the latest versions of the 4.0 and 4.1. However, we do not have full support.

##No Support/Not Tested
======================================================================================================

-   Fedora Core Linux on IA64 (Itanium), any compiler (\*\*)
-   RedHat Enterprise Linux on IA64 (Itanium), any compiler (\*\*)
-   Mac OS X 10.4 on x86, 64-bit, GCC 4.0 Any other platform, including but not limited to: Solaris, Irix, Debian Linux, Ubuntu Linux.

Note: (\*\*) We expect to be able to support Itanium in future releases but we simply haven't been able to test it.
