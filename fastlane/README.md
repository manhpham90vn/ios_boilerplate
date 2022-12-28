fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios unittest

```sh
[bundle exec] fastlane ios unittest
```

Run unit test

### ios setup_certificate_and_provisioning

```sh
[bundle exec] fastlane ios setup_certificate_and_provisioning
```

Setup certificate and provisioning profile

### ios setup_api_key

```sh
[bundle exec] fastlane ios setup_api_key
```

Setup API Key

### ios get_app_info

```sh
[bundle exec] fastlane ios get_app_info
```

Get app info

### ios get_app_info_current_test_flight_version

```sh
[bundle exec] fastlane ios get_app_info_current_test_flight_version
```

Get current testflight version

### ios set_app_info

```sh
[bundle exec] fastlane ios set_app_info
```

Set app info

### ios export

```sh
[bundle exec] fastlane ios export
```

Export file ipa distribution

### ios upload_testflight_api_or_session

```sh
[bundle exec] fastlane ios upload_testflight_api_or_session
```

Upload testflight

### ios upload_testflight_altool

```sh
[bundle exec] fastlane ios upload_testflight_altool
```

Upload testflight use altool

### ios upload_testflight_method_1

```sh
[bundle exec] fastlane ios upload_testflight_method_1
```

Upload testflight method 1

### ios upload_testflight_method_2

```sh
[bundle exec] fastlane ios upload_testflight_method_2
```

Upload testflight method 2

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
