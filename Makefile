.DEFAULT_GOAL := all

.PHONY: all
all: install generate

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
	@sh scripts/project/generate-project.sh
installPod:
	@sh scripts/pod/pod-run.sh

# delete
.PHONY: delete
delete: 
	rm -rf *.xcodeproj *.xcworkspace Pods/ Carthage/ Build/ Mints/ vendor/ .bundle Mintfile

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
