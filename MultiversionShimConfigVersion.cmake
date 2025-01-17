# This is part of the multi-version shim config, to support multiple versions installed in the same location.
#
# This is the version part of the setup.
# CMake loads this in a scope with some variables set (notably PACKAGE_FIND_VERSION).
# We must check if the requested version is installed, and respond accordingly by setting some variables.

# Defaults, if no match is found
set (PACKAGE_VERSION "[TdShim]")
set (PACKAGE_VERSION_EXACT FALSE)
set (PACKAGE_VERSION_COMPATIBLE FALSE)
set (PACKAGE_VERSION_UNSUITABLE TRUE)

if (NOT DEFINED PACKAGE_FIND_VERSION OR PACKAGE_FIND_VERSION STREQUAL "")
  set (PACKAGE_VERSION_EXACT TRUE)
  set (PACKAGE_VERSION_COMPATIBLE TRUE)
  set (PACKAGE_VERSION_UNSUITABLE FALSE)
else()
  file (GLOB TDSHIM_INSTALLED_VERSIONS
    LIST_DIRECTORIES TRUE
    RELATIVE ${CMAKE_CURRENT_LIST_DIR}
    "${CMAKE_CURRENT_LIST_DIR}/*/TdConfigVersion.cmake"
  )

  list (FIND TDSHIM_INSTALLED_VERSIONS
    "${PACKAGE_FIND_VERSION}/TdConfigVersion.cmake"
    TDSHIM_REQUESTED_VERSION_INDEX
  )

  if (NOT TDSHIM_REQUESTED_VERSION_INDEX EQUAL -1)
    # Exact match for requested version, pass it on to that module
    include ("${CMAKE_CURRENT_LIST_DIR}/${PACKAGE_FIND_VERSION}/TdConfigVersion.cmake")
  elseif ()
    # We don't handle ranges or lax matches based on just major/minor version, so give up here and pass along defaults
  endif()
endif()
