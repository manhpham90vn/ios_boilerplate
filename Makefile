.DEFAULT_GOAL := all

export MINT_PATH := Mints/lib
export MINT_LINK_PATH := Mints/bin

.PHONY: all
all: install generate open

# install
.PHONY: install
install: install-ruby installBrew installMint installBundle
install-ruby:
	cat .ruby-version | xargs rbenv install --skip-existing
installBrew:
	brew bundle install
installMint:
	mkdir -p Mints/{lib,bin}
	mint bootstrap -m Mintfile --link
installBundle: 
	bundle config path vendor/bundle
	bundle install --without=documentation --jobs 4 --retry 3

# generate project with xcodegen
.PHONY: generate
generate: swiftgen xcodegen installPods
swiftgen:
	mkdir -p Sources/Resources/Generated/SwiftGen
	mint run swiftgen
xcodegen: 
	mint run xcodegen generate --spec project.yml	
installPods: 
	bundle exec pod install

# update bundle and install pod
.PHONY: update
update: updateBundle updatePods
updateBundle: 
	bundle config path vendor/bundle
	bundle update --jobs 4 --retry 3
updatePods: 
	bundle exec pod update

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