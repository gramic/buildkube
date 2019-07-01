workspace(name = "com_github_stackb_buildkube")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

#####################################################################
# rules_go
#####################################################################

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "f04d2373bcaf8aa09bccb08a98a57e721306c8f6043a2a0ee610fd6853dcde3d",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/0.18.6/rules_go-0.18.6.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/0.18.6/rules_go-0.18.6.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

#####################################################################
# bazel_skylib
#####################################################################

# bazel-skylib 0.8.0 released 2019.03.20 (https://github.com/bazelbuild/bazel-skylib/releases/tag/0.8.0)
skylib_version = "0.8.0"

http_archive(
    name = "bazel_skylib",
    sha256 = "2ef429f5d7ce7111263289644d233707dba35e39696377ebab8b0bc701f7818e",
    type = "tar.gz",
    url = "https://github.com/bazelbuild/bazel-skylib/releases/download/{}/bazel-skylib.{}.tar.gz".format(skylib_version, skylib_version),
)

#####################################################################
# rules_docker
#####################################################################

# Download the rules_docker repository at release v0.8.0
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "3556d4972571f288f8c43378295d84ed64fef5b1a875211ee1046f9f6b4258fa",
    strip_prefix = "rules_docker-0.8.0",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/v0.8.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//toolchains/docker:toolchain.bzl",
    docker_toolchain_configure = "toolchain_configure",
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

RBE_UBUNTU_DIGEST = "sha256:94d7d8552902d228c32c8c148cc13f0effc2b4837757a6e95b73fdc5c5e4b07b"

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
    commit = "dda7ab9151cb95f944e59beabaa0d960825ee17c",
    remote = "https://github.com/bazelbuild/rules_k8s.git",
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_defaults")

k8s_defaults(
    name = "k8s_deploy",
    cluster = "office",
    kind = "deployment",
)

#####################################################################
# BUILDFARM
#####################################################################

load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)

_java_image_repos()

load("//farm:workspace.bzl", "buildfarm_repository")

BUILDFARM_VERSION = "eff718591098583e4a03da0877fdae2904e09815"

buildfarm_repository(
    name = "build_buildfarm",
    commit = BUILDFARM_VERSION,
)

load(
    "@io_bazel_rules_docker//go:image.bzl",
    go_image_repositories = "repositories",
)

go_image_repositories()

#####################################################################
# JSONNET
#####################################################################

http_archive(
    name = "io_bazel_rules_jsonnet",
    sha256 = "59bf1edb53bc6b5adb804fbfabd796a019200d4ef4dd5cc7bdee03acc7686806",
    strip_prefix = "rules_jsonnet-0.1.0",
    urls = ["https://github.com/bazelbuild/rules_jsonnet/archive/0.1.0.tar.gz"],
)

load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_repositories")

jsonnet_repositories()
