SHELL:=/bin/bash

CPPFLAGS:=-W -Wall -pedantic -Werror

.PHONY: all
all: expensereport

.PHONY: clean
clean::
	$(RM) *.[adios] *.ali expensereport

%: %.adb
	gnatmake $^
