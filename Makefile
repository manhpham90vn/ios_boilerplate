SHELL := /bin/bash

.DEFAULT_GOAL := all

.PHONY: all
all: install generate
install:
	@sh scripts/common/install.sh
generate:
	@sh scripts/common/generate.sh

# delete
.PHONY: delete
delete: 
	@sh scripts/project/run-delete.sh

# run unit test
.PHONY: test
test:
	@sh scripts/project/run-unit-test.sh

# run slather
.PHONY: slather
slather:
	@sh scripts/slather/slather-run.sh

# export to testflight
.PHONY: testflight
testflight:
	@sh scripts/project/run-upload-testflight.sh

# open xcode
.PHONY: open
open:
	xed .
