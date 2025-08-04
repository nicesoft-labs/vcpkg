vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gost-engine/engine
    REF v3.0.3
    SHA512 3a66e95b743475f36372b51de852caa442ff423110668e7ba082f93f7c7d151a5d19db7f3ddbd4dae4af4578cdf0e50c099b71dcc6d7e8f049cbfb3fb28f567a
    SUBMODULES libprov
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS -DOPENSSL_ROOT_DIR=${CURRENT_INSTALLED_DIR}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
