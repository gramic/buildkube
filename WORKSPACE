workspace(name = "com_github_stackb_buildkube")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

#####################################################################
# rules_go
#####################################################################

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "77dfd303492f2634de7a660445ee2d3de2960cbd52f97d8c0dffa9362d3ddef9",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.18.1/rules_go-0.18.1.tar.gz"],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

#####################################################################
# bazel_skylib
#####################################################################

git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.8.0",
)

#####################################################################
# rules_docker
#####################################################################

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "aed1c249d4ec8f703edddf35cbe9dfaca0b5f5ea6e4cd9e83e99f3b0d1136c3d",
    strip_prefix = "rules_docker-0.7.0",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/v0.7.0.tar.gz"],
)


load("@io_bazel_rules_docker//toolchains/docker:toolchain.bzl",
    docker_toolchain_configure="toolchain_configure"
)
docker_toolchain_configure(
  name = "docker_config",
)

load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)

_java_image_repos()

#############################################################
# worker execution container
#############################################################
load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
container_repositories()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)

RBE_UBUNTU_REGISTRY = "gcr.io"

RBE_UBUNTU_REPOSITORY = "cloud-marketplace/google/rbe-ubuntu16-04"

RBE_UBUNTU_DIGEST = "sha256:da0f21c71abce3bbb92c3a0c44c3737f007a82b60f8bd2930abc55fe64fc2729"

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

# This requires rules_docker to be fully instantiated before
# it is pulled in.
git_repository(
    name = "io_bazel_rules_k8s",
    commit = "8b2d62aef3f495cc7d8c14184b8ccc954dd915a8",
    remote = "https://github.com/bazelbuild/rules_k8s.git",
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_defaults")

k8s_defaults(
    name = "k8s_deploy",
    cluster = "gigatron",
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

BUILDFARM_VERSION = "8b6a7a4d4591ac87d23e623ca7113cb96e30c9f8"

buildfarm_repository(
    name = "build_buildfarm",
    commit = BUILDFARM_VERSION,
)

# Switch to the following for local buildfarm development
#
# load("//farm:local_repository.bzl", "local_buildfarm_repository")
# local_buildfarm_repository(
#     path = "../../bazelbuild/bazel-buildfarm",
# )
# load("@build_buildfarm//3rdparty:workspace.bzl", "maven_dependencies", "declare_maven")
# maven_dependencies(declare_maven)


# local_repository(
#     name = "buildbarn",
#     path = "../../EdShouten/bazel-buildbarn",
# )

load(
    "@io_bazel_rules_docker//go:image.bzl",
    go_image_repositories = "repositories",
)

go_image_repositories()
