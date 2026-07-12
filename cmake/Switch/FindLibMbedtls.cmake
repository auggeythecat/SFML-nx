## A CMake helper to find GL libs on the system.

include(FindPackageHandleStandardArgs)

if(NOT SWITCH)
    message(FATAL_ERROR "This helper can only be used when cross-compiling for the Switch.")
endif()

find_path(LibMbedtls_INCLUDE_DIR
        NAMES libssh2.h
        PATHS ${DEVKITPRO}/portlibs/switch/include
        NO_DEFAULT_PATH)

find_library(LibMbedtls_LIBRARY
        NAMES ssh2
        PATHS ${DEVKITPRO}/portlibs/switch/lib
        NO_DEFAULT_PATH)

find_package_handle_standard_args(Libssh2
        REQUIRED_VARS LibMbedtls_LIBRARY LibMbedtls_INCLUDE_DIR)

if(LibMbedtls_FOUND)
    set(LibMbedtls_INCLUDE_DIRS ${LibMbedtls_INCLUDE_DIR})
    set(LibMbedtls_LIBRARIES ${LibMbedtls_LIBRARY})

    add_library(libssh2::libssh2 STATIC IMPORTED GLOBAL)
    set_target_properties(libssh2::libssh2 PROPERTIES
            IMPORTED_LOCATION "${LibMbedtls_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LibMbedtls_INCLUDE_DIR}")
endif()

mark_as_advanced(LibMbedtls_INCLUDE_DIR LibMbedtls_LIBRARY)
