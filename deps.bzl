load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def k8_toolchain_deps():
    if not native.existing_rule("br_toolchain_k8"):
        http_archive(
            name = "br_toolchain_k8",
            urls = [
                "https://github.com/skykying/bazel-br-toolchain/releases/download/v0.0.1/bazel-buildroot-toolchain-d5ab572.tar.xz",
            ],
            sha256 = "0fb830b65d8669c5e15640e658b2070b020c20ab7a30eb5ed6a3b2eb084f0fdc",
            build_file = Label("//toolchain/x86_64:br_toolchain_k8.BUILD"),
            strip_prefix = "host",
        )

def aarch64_toolchain_deps():
    if not native.existing_rule("br_toolchain_aarch64"):
        http_archive(
            name = "br_toolchain_aarch64",
            urls = [
                "https://github.com/skykying/bazel-br-toolchain/releases/download/v1.0.1/aarch64-tulip-linux-gnu_sdk-buildroot.tar.gz",
            ],
            sha256 = "3889cf752158694e78bdceac33be412a6fa21b379b62ead0a0284f08edfad3d2",
            build_file = Label("//toolchain/aarch64:br_toolchain_aarch64.BUILD"),
        )
