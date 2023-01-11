#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/xcodegen-config.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

rm -rf $XCODE_GEN_FILE

cat <<EOF >>$XCODE_GEN_FILE
name: $PROJECT_NAME
configs:
  $CONFIGURATION: $CONFIGURATION_LOWER
options:
  createIntermediateGroups: true
  groupSortPosition: top
  generateEmptyDirectories: true
  indentWidth: 4
  tabWidth: 4
settings:
  PRODUCT_BUNDLE_IDENTIFIER: \$(PRODUCT_BUNDLE_IDENTIFIER)
targets:
  $PRODUCT_NAME:
    type: application
    platform: iOS
    deploymentTarget: $DEPLOYMENT_TARGET
    sources: $SOURCE_DIRECTORY
    configFiles:
      $CONFIGURATION: $SOURCE_DIRECTORY/Configs/BuildConfigurations/$CONFIGURATION.xcconfig
    settings:
      INFOPLIST_FILE: $SOURCE_DIRECTORY/Resources/Info.plist
      SWIFT_VERSION: "5.0"
      SWIFT_OBJC_BRIDGING_HEADER: $SOURCE_DIRECTORY/Resources/MyApp-Bridging-Header.h
      CODE_SIGN_STYLE: "Manual"
      UISupportedInterfaceOrientations: UIInterfaceOrientationPortrait
      UILaunchStoryboardName: LaunchScreen
      VALIDATE_WORKSPACE: YES
      CODE_SIGN_ENTITLEMENTS: $SOURCE_DIRECTORY/Resources/MyApp.entitlements
    preBuildScripts:
      - name: Generate
        script: scripts/swiftgen/swiftgen-run.sh
    postCompileScripts:
      - name: Swiftlint
        script: scripts/project/run-linter.sh
      - name: GoogleServiceInfo
        script: scripts/project/run-firebase.sh
    postBuildScripts:
      - name: Crashlytics
        script: |
          "\${PODS_ROOT}/FirebaseCrashlytics/run"
        inputFiles:
          - \$(BUILT_PRODUCTS_DIR)/\$(INFOPLIST_PATH)
          - \$(DWARF_DSYM_FOLDER_PATH)/\$(DWARF_DSYM_FILE_NAME)/Contents/Resources/DWARF/\$(TARGET_NAME)
  ${PRODUCT_NAME}Tests:
    type: bundle.unit-test
    platform: iOS
    settings:
      TEST_HOST: \$(BUILT_PRODUCTS_DIR)/$PRODUCT_NAME.app/$PRODUCT_NAME
      LD_RUNPATH_SEARCH_PATHS: \$(inherited) '@executable_path/Frameworks' '@loader_path/Frameworks' \$(FRAMEWORK_SEARCH_PATHS)
      IPHONEOS_DEPLOYMENT_TARGET: $DEPLOYMENT_TARGET
    sources: SourcesTests
    dependencies:
      - target: ${PRODUCT_NAME}
schemes:
  $SCHEME:
    build:
      targets:
        $PRODUCT_NAME: all
    run:
      config: $CONFIGURATION
    test:
      config: $CONFIGURATION
      gatherCoverageData: true
      targets:
        - name: ${PRODUCT_NAME}Tests
          parallelizable: false
          randomExecutionOrder: true
    profile:
      config: $CONFIGURATION
    analyze:
      config: $CONFIGURATION
    archive:
      config: $CONFIGURATION
  ${SCHEME}Tests:
    build:
      targets:
        ${PRODUCT_NAME}Tests: [test]
    run:
      config: $CONFIGURATION
      environmentVariables:
        SKIP_ANIMATIONS:
    test:
      config: $CONFIGURATION
      gatherCoverageData: true
      targets:
        - name: ${PRODUCT_NAME}Tests
          parallelizable: false
          randomExecutionOrder: true
    profile:
      config: $CONFIGURATION
    analyze:
      config: $CONFIGURATION
    archive:
      config: $CONFIGURATION
      customArchiveName: ${PRODUCT_NAME}Tests
      revealArchiveInOrganizer: true    
EOF