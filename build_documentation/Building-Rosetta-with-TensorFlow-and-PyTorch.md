As Rosetta just uses libtorch and not the Python wrapping, we've changed to just using `extras=torch`, and the relevant documentation page is [[Building Rosetta with TensorFlow and Torch]].

For earlier versions of Rosetta (e.g. Rosetta 3.14), you may still need to use `extras=pytorch`. Aside from that substitution, the documentation link above should still apply.