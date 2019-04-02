load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def local_buildfarm_repository(path):

    native.local_repository(
        name = "build_buildfarm",
        path = path,
    )

    http_archive(
        name = "googleapis",
        sha256 = "70d7be6ad49b4424313aad118c8622aab1c5fdd5a529d4215d3884ff89264a71",
        url = "https://github.com/googleapis/googleapis/archive/6c48ab5aef47dc14e02e2dc718d232a28067129d.tar.gz",
        strip_prefix = "googleapis-6c48ab5aef47dc14e02e2dc718d232a28067129d",
        build_file = "@build_buildfarm//:BUILD.googleapis",
    )

    # The API that we implement.
    http_archive(
        name = "remote_apis",
        sha256 = "00eb6f54c6206960f556e448b0d87ca48945fa6bd5b6ae4ce500fd06c02728e1",
        url = "https://github.com/bazelbuild/remote-apis/archive/6a5a17b77bca5e70417746fd0616db3849731619.tar.gz",
        strip_prefix = "remote-apis-6a5a17b77bca5e70417746fd0616db3849731619",
        build_file = "@build_buildfarm//:BUILD.remote_apis",
    )

    http_archive(
        name = "grpc_java",
        sha256 = "81d1e12bf0f8bd1560eed7c75f24d8bb8e7368dcf07802586e439c85cf89b005",
        strip_prefix = "grpc-java-1.19.0",
        urls = ["https://github.com/grpc/grpc-java/archive/v1.19.0.tar.gz"],
    )
