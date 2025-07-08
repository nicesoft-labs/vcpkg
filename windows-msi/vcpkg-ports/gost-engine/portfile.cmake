vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gost-engine/engine
    REF 806d9ee6f1075f715b6ce6e32fc2b3e88763448b
    SHA512 138b6cef10d1c59b086f4f6dbd86e3a78b2e266a1635a552e8351bd7570da8bcb37791b07fa430457243a65f3b26b05d5b8d8ac8ec8547c90eb97cdb153d14f0
    HEAD_REF master
)

vcpkg_execute_required_process(
    COMMAND git submodule update --init
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME update-submodules
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DOPENSSL_ROOT_DIR=${CURRENT_INSTALLED_DIR}
        -DOPENSSL_ENGINES_DIR=${CURRENT_PACKAGES_DIR}/lib/engines-3
        -DOPENSSL_MODULES_DIR=${CURRENT_PACKAGES_DIR}/lib/ossl-modules
)

vcpkg_cmake_install()

file(GLOB PROVIDER_DLL
    "${CURRENT_PACKAGES_DIR}/lib/ossl-modules/*gost*.dll"
    "${CURRENT_PACKAGES_DIR}/lib/ossl-modules/*gost*.so"
    "${CURRENT_PACKAGES_DIR}/lib/ossl-modules/*gost*.dylib"
)
if(PROVIDER_DLL)
    file(INSTALL DESTINATION "${CURRENT_PACKAGES_DIR}/lib/ossl-modules" TYPE FILE FILES ${PROVIDER_DLL})
endif()
