load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
     "feature",
     "flag_set",
     "flag_group",
     "tool_path",
)

all_compile_actions = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.c_compile,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.lto_backend,
    ACTION_NAMES.preprocess_assemble,
]

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _toolchain_config_impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "wrappers/aarch64-linux-gcc-9.1.0.br_real",
        ),
        tool_path(
            name = "ld",
            path = "wrappers/aarch64-linux-ld",
        ),
        tool_path(
            name = "ar",
            path = "wrappers/aarch64-buildroot-linux-musl-ar",
        ),
        tool_path(
            name = "cpp",
            path = "wrappers/aarch64-linux-cpp.br_real",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "wrappers/aarch64-linux-nm",
        ),
        tool_path(
            name = "objdump",
            path = "wrappers/aarch64-linux-objdump",
        ),
        tool_path(
            name = "strip",
            path = "/usr/bin/strip",
        ),
    ]

    unfiltered_compile_flags_feature = feature(
        name = "unfiltered_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            # These make sure that paths included in .d dependency files are relative to the execroot
                            # (e.g. start with "external/").
                            "-no-canonical-prefixes",
                            "-fno-canonical-system-headers",
                        ],
                    ),
                ],
            ),
        ],
    )

    dbg_feature = feature(name = "dbg")
    opt_feature = feature(name = "opt")

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-Wl,-no-as-needed",
                            "-Wl,-z,relro,-z,now",
                            "-lstdc++",
                            "-lm",
                            "-pass-exit-codes",
                        ],
                    ),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "aarch64-toolchain",
        host_system_name = "aarch64-unknown-linux-gnu",
        target_system_name = "aarch64-buildroot-linux-musl",
        target_cpu = "aarch64",
        target_libc = "musl",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        features = [
            default_link_flags_feature,
            unfiltered_compile_flags_feature,
        ],
    )

cc_aarch64_toolchain_config = rule(
    implementation = _toolchain_config_impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
