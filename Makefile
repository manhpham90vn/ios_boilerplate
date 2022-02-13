.DEFAULT_GOAL := all

export MINT_PATH := Mints/lib
export MINT_LINK_PATH := Mints/bin

.PHONY: all
all: install generate open

# install
.PHONY: install
install: installBrew install-ruby installMint installBundle
installBrew:
	brew bundle install
install-ruby:
	cat .ruby-version | xargs rbenv install --skip-existing	
installMint:
	mkdir -p Mints/{lib,bin}
	mint bootstrap -m Mintfile --link
installBundle: 
	bundle config path vendor/bundle
	bundle install --without=documentation --jobs 4 --retry 3

# generate
.PHONY: generate
generate: swiftgen xcodegen installPods
swiftgen:
	mkdir -p Sources/Resources/Generated/SwiftGen
	mint run swiftgen
xcodegen: 
	mint run xcodegen generate --spec project.yml	
installPods: 
	bundle exec pod install

# update
.PHONY: update
update: updateBundle updatePods
updateBundle: 
	bundle config path vendor/bundle
	bundle update --jobs 4 --retry 3
updatePods: 
	bundle exec pod update

.PHONY: xcodetest
xcodetest:
	xcodebuild test \
	-scheme "My Project" \
	-workspace "My Project.xcworkspace" \
	-destination 'platform=iOS Simulator,name=iPhone 13 Pro Max' \
	-derivedDataPath "build" \
	-enableCodeCoverage YES \
	| xcpretty -s -c

.PHONY: generateCoverage
generateCoverage: 
	bundle exec slather coverage

# delete
.PHONY: delete
delete: 
	rm -rf *.xcodeproj *.xcworkspace Pods/ Carthage/ Build/ Mints/ vendor/

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