# Building Rosetta with machine learning support

For having both TensorFlow and PyTorch support, follow the download and setup instructions below and then compile with `extras=tensorflow,pytorch` (e.g. `./scons.py -j 24 mode=release extras=tensorflow,pytorch`).

## To compile with Tensorflow support:

1. Download the Tensorflow 1.15 precompiled libraries for your operating system from one of the following:   
[Linux/CPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-1.15.0.tar.gz) | [Linux/GPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-linux-x86_64-1.15.0.tar.gz) | [Windows/CPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-windows-x86_64-1.15.0.zip) | [Windows/GPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-windows-x86_64-1.15.0.zip) | 
[MacOS/CPU](https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-darwin-x86_64-1.15.0.tar.gz)  
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
add following environment variables

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

If you have unpacked to a system directory (e.g. /usr/local/lib/) you can also link it instead of using the environment variables with e.g.
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

Note: You can use both `extras=tensorflow` and `extras=tensorflow_gpu` with any of the downloaded versions, there is no check whether its connected to the respective library. However, it enables you to have binaries for both.

## To compile with PyTorch support:
1. Download Libtorch from https://pytorch.org/get-started/locally/
2. unzip to `rosetta/source/external`
3. compile with extras=pytorch

for example:
```
cd rosetta/source/
wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip -O libtorch.zip
unzip libtorch.zip -d external/ && rm libtorch.zip
./scons.py -j 8 mode=release extras=pytorch
```