#!/bin/python3

"""
This script prints out tabular information about how many interrupts
each CPU received for a particular irq descriptor.

Note we are only doing a substring match for the irq descriptor name.

Example usage:
    ./interrupt_mapping.py eth0
    ./interrupt_mapping.py eth
    ./interrupt_mapping.py virtio
"""

from collections import defaultdict
import os
import sys

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} device_name")
    sys.exit(1)

# Gather which interrupt numbers the interface is registered with.
device_name = sys.argv[1]
msi_irqs_dir = f"/sys/class/net/{device_name}/device/msi_irqs"
irqs = {irq for irq in os.listdir(msi_irqs_dir)}  # NB: set of strings

# Slurp lines
with open("/proc/interrupts", "r") as f:
    lines = f.readlines()

# Build column to CPU mapping
cpus = [cpu.strip() for cpu in lines[0].strip().split()]

# Parse each irq row
cpu_to_irqs = defaultdict(int)
for row in lines[1:]:
    parts = [val.strip() for val in row.strip().split()]
    irq = parts[0][:-1]
    if irq not in irqs:
        continue

    for idx, val in enumerate(parts[1:]):
        # Handle trailing irq info
        if idx >= len(cpus):
            break

        interrupts = int(val)
        if interrupts == 0:
            continue

        cpu_to_irqs[cpus[idx]] += interrupts

# Dump table, sorting by CPU number
for cpu, count in sorted(cpu_to_irqs.items(), key=lambda x: int(x[0][3:])):
    print(f"{cpu:10} {count:10} interrupts")
