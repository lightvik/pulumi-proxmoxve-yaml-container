export PULUMI_VERSION='3.115.2'
export PROXMOXVE_PLUGIN_VERSION='6.5.1'
export PULUMI_PROXMOXVE_YAML_DOCKER_IMAGE="${PULUMI_PROXMOXVE_YAML_DOCKER_IMAGE:-pulumi-proxmoxve-yaml}"
export PULUMI_PROXMOXVE_YAML_DOCKER_TAG="${PULUMI_PROXMOXVE_YAML_DOCKER_TAG:-$PULUMI_VERSION-$PROXMOXVE_PLUGIN_VERSION}"
export PULUMI_ARGS="${PULUMI_ARGS:-}"