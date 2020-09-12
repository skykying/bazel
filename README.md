# bazel-buildroot-toolchain

This is a C++ toolchain for Bazel based on the [Buildroot project](https://buildroot.org/).
After setting it up in your Bazel project, you'll be able to use an up-to-date compiler
and C++ library (currently gcc 9.2) that are completely isolated from your host system.

The toolchain uses [musl](https://www.musl-libc.org/) as a C library so that Bazel
can build fully static executables that run on any Linux machine.


### `WORKSPACE`

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_br_toolchain",
    urls = [
        "https://github.com/skykying/bazel-br-toolchain/archive/v0.0.2.tar.gz",
    ],
    sha256 = "43b50ff1396c9c4522a01ac961bdac0922d03c40fbe2a21af9d232aa5b0a71d1",
    strip_prefix = "bazel-br-toolchain-0.0.2",
)

load("@bazel_br_toolchain//:deps.bzl", "bazel_br_toolchain_deps")

bazel_br_toolchain_deps()
```

### `.bazelrc`

```
# Define the toolchain
build:br-toolchain --crosstool_top=@bazel_br_toolchain//toolchain:br
build:br-toolchain --host_crosstool_top=@bazel_br_toolchain//toolchain:br
build:br-toolchain --cpu=x86_64

# Set the toolchain as default (optional, you can omit and use --config buildroot-toolchain instead)
build --config br-toolchain
```


## Getting started

```
cd example
bazel run //:hello
```
