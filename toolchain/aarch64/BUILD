package(default_visibility = ["//visibility:public"])

load(":cc_toolchain_config.bzl", "cc_aarch64_toolchain_config")

cc_toolchain_suite(
    name = "aarch64-br",
    toolchains = {
        "k8": ":aarch64-toolchain",
    },
)

filegroup(name = "empty")

filegroup(
    name = "all",
    srcs = [
        "@br_toolchain_aarch64//:all",
        "wrappers/aarch64-buildroot-linux-musl-ar",
        "wrappers/aarch64-linux-cpp.br_real",
        "wrappers/aarch64-linux-gcc-9.1.0.br_real",
        "wrappers/aarch64-linux-ld",
        "wrappers/aarch64-linux-nm",
        "wrappers/aarch64-linux-objdump",
    ],
)

cc_toolchain(
    name = "aarch64-toolchain",
    toolchain_identifier = "aarch64-toolchain",
    toolchain_config = ":aarch64-toolchain-config",
    all_files = ":all",
    compiler_files = ":all",
    dwp_files = ":empty",
    linker_files = ":all",
    objcopy_files = ":all",
    ar_files = ":all",
    strip_files = ":all",
    supports_param_files = False,
)

cc_aarch64_toolchain_config(
    name = "aarch64-toolchain-config",
)

