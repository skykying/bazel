load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def bazel_br_toolchain_deps():
    if not native.existing_rule("bazel_br_toolchain_files"):
        http_archive(
            name = "bazel_br_toolchain_files",
            urls = [
                "https://github.com/skykying/bazel-br-toolchain/releases/download/v0.0.1/bazel-buildroot-toolchain-d5ab572.tar.xz",
            ],
            sha256 = "0fb830b65d8669c5e15640e658b2070b020c20ab7a30eb5ed6a3b2eb084f0fdc",
            build_file = Label("//toolchain:bazel_br_toolchain_files.BUILD"),
            strip_prefix = "host",
        )
