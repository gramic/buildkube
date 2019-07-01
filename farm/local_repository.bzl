load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def local_buildfarm_repository(path):

    local_repository(
        name = "build_buildfarm",
        path = path,
    )

    http_archive(
        name = "googleapis",
        sha256 = "7b6ea252f0b8fb5cd722f45feb83e115b689909bbb6a393a873b6cbad4ceae1d",
        url = "https://github.com/googleapis/googleapis/archive/143084a2624b6591ee1f9d23e7f5241856642f4d.tar.gz",
        strip_prefix = "googleapis-143084a2624b6591ee1f9d23e7f5241856642f4d",
        build_file = "@build_buildfarm//:BUILD.googleapis",
    )

    # The API that we implement.
    http_archive(
        name = "remote_apis",
        sha256 = "6f22ba09356f8dbecb87ba03cacf147939f77fef1c9cfaffb3826691f3686e9b",
        url = "https://github.com/bazelbuild/remote-apis/archive/cfe8e540cbb424e3ebc649ddcbc91190f70e23a6.tar.gz",
        strip_prefix = "remote-apis-cfe8e540cbb424e3ebc649ddcbc91190f70e23a6",
        build_file = "@build_buildfarm//:BUILD.remote_apis",
    )

    http_archive(
        name = "grpc_java",
        sha256 = "81d1e12bf0f8bd1560eed7c75f24d8bb8e7368dcf07802586e439c85cf89b005",
        strip_prefix = "grpc-java-1.19.0",
        urls = ["https://github.com/grpc/grpc-java/archive/v1.19.0.tar.gz"],
    )
