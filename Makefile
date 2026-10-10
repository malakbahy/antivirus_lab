all:malicious_dir
	@echo "Use 'make run-daemon' or 'make run-restore'"

malicious_dir:
	mkdir -p malicious_dir
run-daemon:malicious_dir
	./antivirusd.sh dir malicious_dir 5
run-restore:malicious_dir
	./restore.sh dir malicious_dir
