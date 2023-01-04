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
generate: generate-swiftgen generate-xcodegen install-pod
generate-swiftgen:
	@sh scripts/swiftgen/swiftgen-run.sh
generate-xcodegen:
	@sh scripts/xcodegen/xcodegen-run.sh
install-pod:
	@sh scripts/pod/pod-run.sh

# delete
.PHONY: delete
delete: 
	@sh scripts/project/delete.sh

# run unit test
.PHONY: test
test:
	bundle exec fastlane unittest --env debug

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
	bundle exec fastlane upload_testflight_method_1 --env release

# open xcode
.PHONY: open
open:
	xed .
