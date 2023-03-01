#!/bin/python3
#
# Script to automatically generate To: and Cc: headers in git-format-patch
# .patch files based on MAINTAINERS file.

import os
from pathlib import Path
import subprocess
import sys

TO_HDR = "To: "
CC_HDR = "Cc: "
LINUX_ROOT = "LINUX_ROOT"
COVER_LETTER_PREFIX = "0000-"
GET_MAINTAINER_COMMON_ARGS = [
    "--no-git",
    "--no-git-fallback",
    "--no-rolestats",
]


def die(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)
    sys.exit(1)


def get_maintainer(args):
    p = subprocess.run(["./scripts/get_maintainer.pl", *args], capture_output=True)
    if p.returncode != 0:
        die(p.stderr.decode())

    return p.stdout.decode().splitlines()


def find_tos(patch_dir, patch):
    # If the patch file is a cover letter, we roll up all the relevant
    # lists for all the patches in the series and add them to the To:
    # line.
    #
    # Otherwise, we do the standard get_maintainer.pl thing.
    emails = set()
    if COVER_LETTER_PREFIX in patch.name:
        for other_file in patch_dir.glob("*.patch"):
            if COVER_LETTER_PREFIX in other_file.name:
                continue

            lists = get_maintainer(
                [*GET_MAINTAINER_COMMON_ARGS, "--no-n", "--no-m", "--no-r", other_file]
            )
            emails.update(lists)
    else:
        tos = get_maintainer(
            [
                *GET_MAINTAINER_COMMON_ARGS,
                "--no-n",
                "--no-r",
                "--no-l",
                "--no-git-fallback",
                patch,
            ]
        )
        emails.update(tos)

    return emails


def find_ccs(patch):
    return get_maintainer(
        [
            *GET_MAINTAINER_COMMON_ARGS,
            "--no-n",
            "--no-m",
            "--no-git-fallback",
            patch,
        ]
    )


def fixup_header(patch, header, value):
    # Careful: `orig_lines` still contains trailing newlines
    with open(patch, "r") as f:
        orig_lines = [line for line in f]

    with open(patch, "w") as f:
        for line in orig_lines:
            if line.startswith(header):
                f.write(f"{line.rstrip()} {value}\n")
            else:
                f.write(f"{line}")


def main(patch_dir):
    patch_dir_path = Path(patch_dir)
    for patch in patch_dir_path.glob("*.patch"):
        tos = find_tos(patch_dir_path, patch)
        ccs = find_ccs(patch)
        fixup_header(patch, TO_HDR, ",".join(tos))
        fixup_header(patch, CC_HDR, ",".join(ccs))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        die(f"Usage: {sys.argv[0]} PATCH_DIR")

    if LINUX_ROOT in os.environ:
        os.chdir(os.environ[LINUX_ROOT])

    main(sys.argv[1])
