## A CMake helper to find GL libs on the system.

include(FindPackageHandleStandardArgs)

if(NOT SWITCH)
    message(FATAL_ERROR "This helper can only be used when cross-compiling for the Switch.")
endif()

find_path(LIBSSH2_INCLUDE_DIR
        NAMES libssh2.h
        PATHS ${DEVKITPRO}/portlibs/switch/include
        NO_DEFAULT_PATH)

find_library(LIBSSH2_LIBRARY
        NAMES ssh2
        PATHS ${DEVKITPRO}/portlibs/switch/lib
        NO_DEFAULT_PATH)

find_package_handle_standard_args(Libssh2
        REQUIRED_VARS LIBSSH2_LIBRARY LIBSSH2_INCLUDE_DIR)

if(LIBSSH2_FOUND)
    set(LIBSSH2_INCLUDE_DIRS ${LIBSSH2_INCLUDE_DIR})
    set(LIBSSH2_LIBRARIES ${LIBSSH2_LIBRARY})

    add_library(libssh2::libssh2 STATIC IMPORTED GLOBAL)
    set_target_properties(libssh2::libssh2 PROPERTIES
            IMPORTED_LOCATION "${LIBSSH2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBSSH2_INCLUDE_DIR}")
endif()

mark_as_advanced(LIBSSH2_INCLUDE_DIR LIBSSH2_LIBRARY)
