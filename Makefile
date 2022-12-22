.DEFAULT_GOAL := all

XCODEGEN_VERSION := 2.33.0
SWIFTGEN_VERSION := 6.5.1

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
	mkdir -p Mints/{lib,bin}
	MINT_PATH=Mints/lib MINT_LINK_PATH=Mints/bin mint bootstrap -m Mintfile --link
# generate
.PHONY: generate
generate: generateSwiftgen generateXcodegen installPod
generateSwiftgen:
	rm -rf Sources/Common/Resources/Generated/*
	mkdir -p Sources/Common/Resources/Generated/SwiftGen
	mint run SwiftGen/SwiftGen@${SWIFTGEN_VERSION} swiftgen
generateXcodegen:
	mint run yonaskolb/xcodegen@${XCODEGEN_VERSION} xcodegen generate --spec project.yml
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
setupCertificate:
	bundle exec fastlane setup

.PHONY: runUnitTest
runUnitTest:
	bundle exec fastlane unittest --env debug

.PHONY: exportTestFlight
exportTestFlight:
	bundle exec fastlane export --env staging

.PHONY: open
open:
	xed .
