.PHONY: all compile run

all: run

compile:
	monkeyc -w -d venusqm -f monkey.jungle -o test.prg -y ../developer_key.der

run: compile
	#pgrep simulator || simulator
	monkeydo test.prg venusqm
