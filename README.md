```markdown
# Overview & Folder Hierarchy
This project implements a Simple Antivirus Daemon in Linux using Bash scripts. It periodically scans a target directory and quarantines malicious files.

## Folder Hierarchy
```text
lab2/
├── antivirusd.sh
├── restore.sh
├── Makefile
├── README.md
├── dir/
└── malicious_dir/

```

## Prerequisites & Installation

This project requires a Linux environment (Ubuntu) with Bash.

To install `make` and essential utilities on Ubuntu, run:

```bash
sudo apt update
sudo apt install build-essential

```

## Usage Instructions

### To run the Antivirus Daemon

You can write in the terminal:

```bash
make run-daemon

```

### To run the Restore Tool

You can write in the terminal:

```bash
make run-restore

```

## Detection Rules & Signatures

The malicious file detection rules (extensions and keywords) are defined in `antivirusd.sh` as follows:

```bash
FLAGGED_EXTENSIONS=("exe" "bat" "vbs" "scr" "ps1")
FLAGGED_KEYWORDS=("virus" "trojan" "malware" "worm" "ransomware")

```

```

```




