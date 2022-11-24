# Base VIPER
[![Build and run unit test](https://github.com/manhpham90vn/iOS-VIPER-Architecture/actions/workflows/buildTests.yml/badge.svg)](https://github.com/manhpham90vn/iOS-VIPER-Architecture/actions/workflows/buildTests.yml)
[![Run SwiftLint](https://github.com/manhpham90vn/iOS-VIPER-Architecture/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/manhpham90vn/iOS-VIPER-Architecture/actions/workflows/swiftlint.yml)
[![codecov](https://codecov.io/gh/manhpham90vn/iOS-VIPER-Architecture/branch/master/graph/badge.svg?token=VABBKXP9O2)](https://codecov.io/gh/manhpham90vn/iOS-VIPER-Architecture)
[![Build Status](https://app.bitrise.io/app/bd94ba7e6efc667b/status.svg?token=bHwp_npyOFYUoI_xIwt-Wg&branch=master)](https://app.bitrise.io/app/bd94ba7e6efc667b)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=manhpham90vn_iOS-VIPER-Architecture&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=manhpham90vn_iOS-VIPER-Architecture)
[![CodeFactor](https://www.codefactor.io/repository/github/manhpham90vn/ios-viper-architecture/badge)](https://www.codefactor.io/repository/github/manhpham90vn/ios-viper-architecture)
## Install
```shell
make
```

## Features
- [x] VIPER Architecture
- [x] RxSwift
- [x] Dependency Injection with [MPInjector](https://github.com/manhpham90vn/MPInjector)
- [x] Automatic Detect Leak Memory
- [x] Has base pagination
- [x] Handle refresh token (When multiple requests hit 401 (HTTP_UNAUTHORIZED), only single Refresh token request will be executed)

## Screens
- [x] Login
- [x] Main
- [x] Detail

## Server
- https://github.com/manhpham90vn/refresh-Token-Demo

## Template
- https://github.com/manhpham90vn/XCTemplate
