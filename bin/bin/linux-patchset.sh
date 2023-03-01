#!/bin/bash
#
# Script generate a linux patchset. Note this is closely coupled
# with `linux-format-patch.py`.

set -eu

if (( $# < 1 )); then
    echo "Usage: ${0} REF [GIT_FORMAT_PATCH_ARGS..]" 1>&2
    exit 1
fi

ROOT=$(git rev-parse --show-toplevel)
OUTDIR="${ROOT}/outgoing/$(git rev-parse --abbrev-ref HEAD)"

# Note we generate empty To: and Cc: headers so `linux-format-patch.py`
# does not have to figure out the insertion point.
git format-patch -o "$OUTDIR" -s --to "" --cc "" "$@"

# Add To: and Cc: based on `get_maintainer.pl`
LINUX_ROOT="$ROOT" linux-address-patchset.py "$OUTDIR"
