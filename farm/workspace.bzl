load("@io_bazel_rules_docker//container:load.bzl", "container_load")

BUILD_BAZEL = """
java_import(
    name = "server",
    jars = ["buildfarm-server_deploy.jar"],
    visibility = ["//visibility:public"],
)
java_import(
    name = "worker",
    jars = ["buildfarm-worker_deploy.jar"],
    visibility = ["//visibility:public"],
)
"""

def modify(repository_ctx, filename, directive):
    args = ["sed", "-i", directive, filename]
    result = repository_ctx.execute(args)
    if result.return_code: 
        fail("%r failed: %s" % (args, result.stderr))

def _buildfarm_repository_impl(repository_ctx):
    commit = repository_ctx.attr.commit

    url = repository_ctx.attr.remote.format(
        commit = commit,
    )

    # Download and unarchive it!
    repository_ctx.download_and_extract(url, 
        stripPrefix = "-".join(["bazel-buildfarm", commit]),
    )

    # Apply mods if requested
    for filename, commands in repository_ctx.attr.modifications.items():
        for command in commands:
            modify(repository_ctx, filename, command)

    result = repository_ctx.execute(["bazel", "build", 
        "//src/main/java/build/buildfarm:buildfarm-server_deploy.jar",
        "//src/main/java/build/buildfarm:buildfarm-worker_deploy.jar",
    ], quiet = False)
    if result.return_code: 
        fail("bazel build failed: %s" % result.stderr)
    
    result = repository_ctx.execute(["cp", "bazel-bin/src/main/java/build/buildfarm/buildfarm-server_deploy.jar", "."])
    if result.return_code: 
        fail("copy failed: %s" % result.stderr)
    result = repository_ctx.execute(["cp", "bazel-bin/src/main/java/build/buildfarm/buildfarm-worker_deploy.jar", "."])
    if result.return_code: 
        fail("copy failed: %s" % result.stderr)

    repository_ctx.file("BUILD.bazel", BUILD_BAZEL)

buildfarm_repository = repository_rule(
    attrs = {
        "remote": attr.string(
            default = "https://github.com/bazelbuild/bazel-buildfarm/archive/{commit}.tar.gz",
        ),
        "commit": attr.string(
            mandatory = True,
        ),
        "modifications": attr.string_list_dict(
            doc = "Optional sed modifications to apply",
        ),
    },
    implementation = _buildfarm_repository_impl,
)
