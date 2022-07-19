.DEFAULT_GOAL := all

.PHONY: all
all: install generate

# install
.PHONY: install
install: installBrew installRuby installBundle
installBrew:
	scripts/installDependencies.sh
installRuby:
	cat .ruby-version | xargs rbenv install --skip-existing
installBundle:
	bundle config path vendor/bundle
	bundle install --without=documentation --jobs 4 --retry 3

# generate
.PHONY: generate
generate: generateSwiftgen generateXcodegen
generateSwiftgen:
	mkdir -p Sources/Common/Resources/Generated/SwiftGen
	swiftgen
generateXcodegen:
	xcodegen generate --spec project.yml
installCarthage:
	carthage bootstrap --use-xcframeworks --platform iOS --no-use-binaries --cache-builds
copyFrameworks:
	rm -rf Frameworks/*
	mkdir -p Frameworks
	cp -R Carthage/Build/*.xcframework Frameworks

# test
.PHONY: xcodetest
xcodetest:
	xcodebuild \
	-project "My Project.xcodeproj" \
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
.PHONY: exportIpa
exportIpa:
	bundle exec fastlane export --env App

.PHONY: exportTestFlight
exportTestFlight:
	bundle exec fastlane gotestflight --env App

.PHONY: open
open:
	xed .
