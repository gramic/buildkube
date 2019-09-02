workspace(name = "com_github_stackb_buildkube")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

#####################################################################
# rules_go and bazel_gazelle
#####################################################################

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "313f2c7a23fecc33023563f082f381a32b9b7254f727a7dd2d6380ccc6dfe09b",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/0.19.3/rules_go-0.19.3.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/0.19.3/rules_go-0.19.3.tar.gz",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "7fc87f4170011201b1690326e8c16c5d802836e3a0d617d8f75c3af2b23180c4",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/bazel-gazelle/releases/download/0.18.2/bazel-gazelle-0.18.2.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/0.18.2/bazel-gazelle-0.18.2.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()

go_register_toolchains()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

#####################################################################
# bazel_skylib
#####################################################################

maybe(
    http_archive,
    name = "bazel_skylib",
    sha256 = "1dde365491125a3db70731e25658dfdd3bc5dbdfd11b840b3e987ecf043c7ca0",
    url = "https://github.com/bazelbuild/bazel-skylib/releases/download/0.9.0/bazel_skylib-0.9.0.tar.gz",
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

#####################################################################
# rules_docker
#####################################################################

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "e513c0ac6534810eb7a14bf025a0f159726753f97f74ab7863c650d26e01d677",
    strip_prefix = "rules_docker-0.9.0",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/v0.9.0.tar.gz"],
)

# OPTIONAL: Call this to override the default docker toolchain configuration.
# This call should be placed BEFORE the call to "container_repositories" below
# to actually override the default toolchain configuration.
# Note this is only required if you actually want to call
# docker_toolchain_configure with a custom attr; please read the toolchains
# docs in /toolchains/docker/ before blindly adding this to your WORKSPACE.

load(
    "@io_bazel_rules_docker//toolchains/docker:toolchain.bzl",
    docker_toolchain_configure = "toolchain_configure",
)

docker_toolchain_configure(
    name = "docker_config",
    # OPTIONAL: Path to a directory which has a custom docker client config.json.
    # See https://docs.docker.com/engine/reference/commandline/cli/#configuration-files
    # for more details.
    client_config = "/path/to/docker/client/config",
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

#############################################################
# worker execution container
#############################################################

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)

RBE_UBUNTU_REGISTRY = "gcr.io"

RBE_UBUNTU_REPOSITORY = "cloud-marketplace/google/rbe-ubuntu16-04"

RBE_UBUNTU_DIGEST = "sha256:2c925275fb30478602cd53651eeaaf015f964ad1b84d3947ed710802f054035b"

RBE_UBUNTU_TAG = "%s/%s@%s" % (RBE_UBUNTU_REGISTRY, RBE_UBUNTU_REPOSITORY, RBE_UBUNTU_DIGEST)

container_pull(
    name = "rbe_ubuntu",
    digest = RBE_UBUNTU_DIGEST,
    registry = RBE_UBUNTU_REGISTRY,
    repository = RBE_UBUNTU_REPOSITORY,
)

#############################################################
# KUBERNETES
#############################################################

http_archive(
    name = "io_bazel_rules_k8s",
    sha256 = "a6fb8354d1dea6fb992de792735a35d2e7fee5c4efc3cb439d3fea09f2d1ab35",
    strip_prefix = "rules_k8s-b799dd0cd7140ed7b58f1fd4c9a14fc924239b0b",
    url = "https://github.com/bazelbuild/rules_k8s/archive/b799dd0cd7140ed7b58f1fd4c9a14fc924239b0b.zip",
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_defaults")

k8s_defaults(
    name = "k8s_deploy",
    cluster = "takcuguot7",
    kind = "deployment",
)

#####################################################################
# BUILDFARM
#####################################################################

load(
    "@io_bazel_rules_docker//java:image.bzl",
    java_image_repositories = "repositories",
)

java_image_repositories()

load("//farm:workspace.bzl", "buildfarm_repository")

BUILDFARM_VERSION = "0379454d93ee745fa991b04aee3bf2ff02a74ac5"

buildfarm_repository(
    name = "build_buildfarm",
    commit = BUILDFARM_VERSION,
)
