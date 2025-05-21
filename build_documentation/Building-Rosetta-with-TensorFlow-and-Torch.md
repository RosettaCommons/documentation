# Building Rosetta with machine learning support

For having both TensorFlow and Torch support, follow the download and setup instructions below and then compile with `extras=tensorflow,torch` (e.g. `./scons.py -j 24 mode=release extras=tensorflow,torch`).



## To compile with Tensorflow support:

1. Download the Tensorflow 1.15 precompiled libraries for your operating system from one of the following:   
[Linux/CPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-1.15.0.tar.gz) | [Linux/GPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-linux-x86_64-1.15.0.tar.gz) | [Windows/CPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-windows-x86_64-1.15.0.zip) | [Windows/GPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-windows-x86_64-1.15.0.zip) | 
[MacOS/IntelCPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-darwin-x86_64-1.15.0.tar.gz)  
(Note that GPU versions require CUDA drivers; see the [TensorFlow documentation](https://www.tensorflow.org/install/lang_c) for more information.)    
    e.g. for Linux CPU:
    ```
    wget https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-1.15.0.tar.gz
    ```

2. Unzip/untar the archive into a suitable directory (`~/usr/local/lib/` is used here as an example), and add the following environment variables:

    e.g. untar in system directory (or any other directory you choose)
    ```
    sudo tar -C /usr/local -xzf libtensorflow-cpu-linux-x86_64-1.15.0.tar.gz
    ```
3. Add following environment variables to point to the new `lib` directory that was created when you extracted the file:

    Linux, Windows: 
    ```
    LIBRARY_PATH=$LIBRARY_PATH:~/usr/local/lib/ 
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/usr/local/lib/
    ```
    MacOS:
    ``` 
    LIBRARY_PATH=$LIBRARY_PATH:~/usr/local/lib/
    DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:~/usr/local/lib/
    ```

    If you have unpacked to a system directory (e.g. /usr/local/lib/) you can also link it instead of using the     environment variables with e.g.
    ```
    sudo ldconfig /usr/local/lib

    ```

3. Edit your user.settings file (`Rosetta/main/source/tools/build/user.settings`), and uncomment (i.e. remove the octothorp from the start of) the following lines: 
    ```
    import os  
    'program_path' : os.environ['PATH'].split(':')
    'ENV' : os.environ,
    ```  

4. Compile Rosetta, appending extras=tensorflow (for CPU-only) or extras=tensorflow_gpu (for GPU) to your scons command. For example: 
    ```
    ./scons.py -j 8 mode=release extras=tensorflow bin
    ```

Note: You can use both `extras=tensorflow` and `extras=tensorflow_gpu` with any of the downloaded versions, there is no check whether its connected to the respective library. However, it enables you to have binaries for both. If you have trouble combining the right GPU version with CUDA, take a look at [this table here](https://www.tensorflow.org/install/source#gpu).

## To compile with Torch support:

NOTE 1: Rosetta uses the C++ level libTorch library, *not* PyTorch. Command line Rosetta cannot use a version of PyTorch installed with Conda, pip or similar.

NOTE 2: While current versions use `extras=torch`, prior versions (including Rosetta 3.14) used `extras=pytorch` instead. Installation should be similar, except for the change of extras designation and the corresponding executable name.

1. Download Libtorch from https://pytorch.org/get-started/locally/.
    e.g. for the cpu version:
    ```
    wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip -O libtorch.zip
    ```
   For the moment the LibTorch CPU version should not be higher than 2.0.1, as later versions require C++17 
   which is currently not set in the scons torch build. This will change soon.
2. unzip to `rosetta/main/source/external`
    ```
    cd Rosetta/main/source
    unzip libtorch.zip -d external/ && rm libtorch.zip
    ```
3. compile with extras=torch
    ```
    ./scons.py -j 8 mode=release extras=torch
    ```