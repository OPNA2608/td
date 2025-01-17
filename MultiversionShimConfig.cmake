# This is part of the multi-version shim config, to support multiple versions installed in the same location.
#
# This is the config part of the setup.
# The version part signaled to CMake whether the requested version is available on the system (if a specific version was requested).
# We can now take the requested version (Td_VERSION, if specified), and include its config.

if (DEFINED Td_VERSION AND NOT Td_VERSION STREQUAL "[TdShim]")
  # Exact version was requested & found, load it
  include ("${CMAKE_CURRENT_LIST_DIR}/${Td_VERSION}/TdConfig.cmake")
else()
  # No version specified, find & load latest available
  # Using an arbitrary version is definitely not supported by upstream, but
  # they don't error out when not specifying a version either. *shrug*
  file (GLOB TDSHIM_INSTALLED_VERSIONS
    LIST_DIRECTORIES TRUE
    RELATIVE ${CMAKE_CURRENT_LIST_DIR}
    "${CMAKE_CURRENT_LIST_DIR}/*/TdConfig.cmake"
  )

  list (LENGTH TDSHIM_INSTALLED_VERSIONS TDSHIM_INSTALLED_VERSIONS_LENGTH)
  if (TDSHIM_INSTALLED_VERSIONS_LENGTH EQUAL 0)
    message (FATAL_ERROR "No Td versions installed!")
  endif()

  if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
    list (SORT TDSHIM_INSTALLED_VERSIONS
      COMPARE NATURAL
    )
  else()
    # Sort manually? For now, roll with the default lexicographical order
    # only a problem once versions go 1.9.1 or 1.8.100
  endif()

  set (TDSHIM_INSTALLED_VERSIONS_LATEST "")
  if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
    list (POP_BACK TDSHIM_INSTALLED_VERSIONS TDSHIM_INSTALLED_VERSIONS_LATEST)
  else()
    list (REVERSE TDSHIM_INSTALLED_VERSIONS)
    list (GET TDSHIM_INSTALLED_VERSIONS 0 TDSHIM_INSTALLED_VERSIONS_LATEST)
  endif()

  include ("${CMAKE_CURRENT_LIST_DIR}/${TDSHIM_INSTALLED_VERSIONS_LATEST}")
endif()
