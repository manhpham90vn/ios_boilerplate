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
generate: generateResource installPod
generateResource:
	@sh scripts/project/generate-swiftgen.sh
	@sh scripts/xcodegen/xcodegen-run.sh
installPod:
	@sh scripts/pod/pod-run.sh

# delete
.PHONY: delete
delete: 
	rm -rf *.xcodeproj *.xcworkspace Pods/ Carthage/ Build/ Mints/ vendor/ .bundle Mintfile fastlane/build fastlane/test_output

# run unit test
.PHONY: unittest
unittest:
	bundle exec fastlane unittest --env sample

# run slather
.PHONY: slather
slather:
	@sh scripts/slather/slather-run.sh

# export to testflight
.PHONY: testflight
testflight:
	bundle exec fastlane upload_testflight_method_1 --env staging

.PHONY: open
open:
	xed .
