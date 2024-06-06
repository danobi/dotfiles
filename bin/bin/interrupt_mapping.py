#!/bin/python3

"""
This script prints out tabular information about how many interrupts
each CPU received for a particular device.

Example usage:
    ./interrupt_mapping.py eth0
"""

from collections import defaultdict
import sys

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} device_name")
    sys.exit(1)

device_name = sys.argv[1]

# Slurp lines
with open("/proc/interrupts", "r") as f:
    lines = f.readlines()

# Build column to CPU mapping
cpus = [cpu.strip() for cpu in lines[0].strip().split()]

# Parse each irq row
cpu_to_irqs = defaultdict(int)
for row in lines[1:]:
    parts = [val.strip() for val in row.strip().split()]
    if parts[-1] != device_name:
        continue

    for idx, val in enumerate(parts[1:]):
        # Handle trailing irq info
        if idx >= len(cpus):
            break
        cpu_to_irqs[cpus[idx]] += int(val)

# Dump table
for cpu, count in cpu_to_irqs.items():
    print(f"{cpu:10} {count:10} interrupts")
