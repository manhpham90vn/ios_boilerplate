.DEFAULT_GOAL := all

.PHONY: all
all: install generate installPods open

# generate project with xcodegen
.PHONY: generate
generate: swiftgen xcodegen
xcodegen: 
	mint run xcodegen generate --spec project.yml
swiftgen:
	mint run swiftgen

# install
.PHONY: install
install: installBrew installMint installBundle
installBrew:
	brew bundle
installMint:
	mint bootstrap
installBundle: 
	bundle install

# and install pod
.PHONY: installPods
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