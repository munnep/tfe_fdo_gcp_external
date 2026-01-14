#!/bin/bash

# This startup wrapper ensures cloud-init is installed and then forces a
# (re)run of the cloud-init stages.
#
# This is necessary because some base Red Hat images do not include cloud-init


# Install cloud-init if missing. Ignore errors so the rest can still run on
# images where cloud-init is already present or dnf metadata is temporarily
# unavailable.
dnf install -y cloud-init || true

# Remove prior cloud-init state and logs so the next steps run fresh.
cloud-init clean --logs

# Run the init stage: reads datasource + instance metadata.
cloud-init init

# Run the config stage: applies configuration modules.
cloud-init modules --mode=config

# Run the final stage: runs runcmd, scripts, and any final modules.
cloud-init modules --mode=final
