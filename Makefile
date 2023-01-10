SHELL := /bin/bash

.DEFAULT_GOAL := all

.PHONY: all
all: init install generate

.PHONY: init
init:
	@sh scripts/common/init.sh

# install
.PHONY: install
install: installRuby installMint
installRuby:
	@sh scripts/ruby/ruby-install.sh
installMint:
	@sh scripts/mint/mint-run.sh

# generate
.PHONY: generate
generate: generate-swiftgen install-mockingbirdswift generate-xcodegen install-pod 
generate-swiftgen:
	@sh scripts/swiftgen/swiftgen-run.sh
generate-xcodegen:
	@sh scripts/xcodegen/xcodegen-run.sh
install-pod:
	@sh scripts/pod/pod-run.sh
install-mockingbirdswift:
	@sh scripts/mockingbirdswift/mockingbirdswift-run.sh

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
testflight: setup_env upload
setup_env: export IS_PRODUCTION=1
setup_env: all
upload:
	@sh scripts/project/run-upload-testflight.sh

# open xcode
.PHONY: open
open:
	xed .
