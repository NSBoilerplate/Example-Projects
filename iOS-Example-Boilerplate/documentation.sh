#env;
echo "Documentation output directory: ${BUILD_DIR}/Documentation";
/usr/local/bin/appledoc \
    --verbose 0 \
    --project-name "${PROJECT_NAME}" \
    --print-settings \
    --output "${BUILD_DIR}/Documentation" \
    "${PROJECT_DIR}";
