.DEFAULT_GOAL := all

.PHONY: all
all: install generate

# install
.PHONY: install
install: installDependencies installBundle installMint
installDependencies:
	scripts/installDependencies.sh
installBundle:
	bundle config path vendor/bundle
	bundle install --without=documentation --jobs 4 --retry 3
installMint:
	mint bootstrap --link

# generate
.PHONY: generate
generate: generateSwiftgen generateXcodegen installPod
generateSwiftgen:
	rm -rf Sources/Common/Resources/Generated/*
	mkdir -p Sources/Common/Resources/Generated/SwiftGen
	mint run SwiftGen/SwiftGen@6.5.1 swiftgen
generateXcodegen:
	mint run yonaskolb/xcodegen@2.32.0 xcodegen generate --spec project.yml
installPod:
	bundle exec pod install

# test
.PHONY: xcodetest
xcodetest:
	xcodebuild \
	-workspace "My Project.xcworkspace" \
	-scheme "My Project" \
	-destination 'platform=iOS Simulator,name=iPhone 13 Pro Max' \
	-derivedDataPath "build" \
	-enableCodeCoverage YES \
	test \
	| bundle exec xcpretty -s -c

.PHONY: generateCoverage
generateCoverage: 
	bundle exec slather coverage

# delete
.PHONY: delete
delete: 
	rm -rf *.xcodeproj *.xcworkspace Pods/ Carthage/ Build/ Mints/ vendor/

# fastlane
.PHONY: setupCertificate
exportIpa:
	bundle exec fastlane setup

.PHONY: runUnitTest
exportIpa:
	bundle exec fastlane unittest --env debug

.PHONY: exportTestFlight
exportTestFlight:
	bundle exec fastlane export --env staging

.PHONY: open
open:
	xed .
