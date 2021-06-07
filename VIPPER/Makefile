.DEFAULT_GOAL := all

.PHONY: all
all: generate install open

# generate project with xcodegen
.PHONY: generate
generate: xcodegen
xcodegen: 
	xcodegen generate --spec project.yml

# install bundle and install pod
.PHONY: install
install: installBundle installPods
installBundle: 
	bundle install
installPods: 
	bundle exec pod install

# update bundle and install pod
.PHONY: update
update: updateBundle updatePods
updateBundle: 
	bundle update
updatePods: 
	bundle exec pod update

# delete
.PHONY: delete
delete: 
	rm -rf *.xcodeproj *.xcworkspace Pods/ Carthage/ Build/

# fastlane
.PHONY: exportIpa
exportIpa: 
	bundle exec fastlane export --env App

.PHONY: exportTestFlight
exportTestFlight:
	bundle exec fastlane gotestflight --env App

.PHONY: open
open:
	xed .

.PHONY: template
template: 
	scripts/install-xcode-template.sh