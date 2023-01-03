#!/bin/sh

PATH_TO_GOOGLE_PLISTS="${PROJECT_DIR}/Sources/Configs/GoogleServices"
echo "warning: Copy file from $PATH_TO_GOOGLE_PLISTS in $CONFIGURATION to ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

case "${CONFIGURATION}" in
"Debug")
    cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Debug.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist";;
"Staging")
    cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Staging.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist";;
"Release")
    cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Release.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist";;
*)
;;
esac