if ((CMAKE_MAJOR_VERSION LESS 3) OR (CMAKE_VERSION VERSION_LESS "3.0.2"))
  message(FATAL_ERROR "CMake >= 3.0.2 is required")
endif()

if (NOT OPENSSL_FOUND)
  find_package(OpenSSL REQUIRED)
  find_package(ZLIB REQUIRED)
endif()

# TODO: all benchmarks in one file
add_executable(bench_crypto bench_crypto.cpp $<TARGET_OBJECTS:tdutils>)
target_link_libraries(bench_crypto PRIVATE ${OPENSSL_CRYPTO_LIBRARY} ${CMAKE_DL_LIBS} ${ZLIB_LIBRARIES} $<TARGET_PROPERTY:tdutils,LINK_LIBRARIES>)
if (WIN32)
  if (MINGW)
    target_link_libraries(bench_crypto PRIVATE ws2_32 mswsock crypt32)
  else()
    target_link_libraries(bench_crypto PRIVATE ws2_32 Mswsock Crypt32)
  endif()
endif()
target_include_directories(bench_crypto SYSTEM PRIVATE ${OPENSSL_INCLUDE_DIR} PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)

add_executable(bench_actor bench_actor.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_actor PRIVATE $<TARGET_PROPERTY:tdactor,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)

add_executable(bench_http bench_http.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdnet> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_http PRIVATE $<TARGET_PROPERTY:tdactor,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdnet,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_http PRIVATE $<TARGET_PROPERTY:tdnet,LINK_LIBRARIES>)

add_executable(bench_http_server bench_http_server.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdnet> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_http_server PRIVATE $<TARGET_PROPERTY:tdactor,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdnet,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_http_server PRIVATE $<TARGET_PROPERTY:tdnet,LINK_LIBRARIES>)

add_executable(bench_http_server_cheat bench_http_server_cheat.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdnet> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_http_server_cheat PRIVATE $<TARGET_PROPERTY:tdactor,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdnet,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_http_server_cheat PRIVATE $<TARGET_PROPERTY:tdnet,LINK_LIBRARIES>)

add_executable(bench_http_server_fast bench_http_server_fast.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdnet> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_http_server_fast PRIVATE $<TARGET_PROPERTY:tdactor,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdnet,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_http_server_fast PRIVATE $<TARGET_PROPERTY:tdnet,LINK_LIBRARIES>)

add_executable(bench_http_reader bench_http_reader.cpp $<TARGET_OBJECTS:tdnet> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_http_reader PRIVATE $<TARGET_PROPERTY:tdnet,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_http_reader PRIVATE $<TARGET_PROPERTY:tdnet,LINK_LIBRARIES>)

add_executable(bench_handshake bench_handshake.cpp $<TARGET_OBJECTS:tdmtproto> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_handshake PRIVATE $<TARGET_PROPERTY:tdmtproto,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_handshake PRIVATE $<TARGET_PROPERTY:tdmtproto,LINK_LIBRARIES>)

add_executable(bench_db bench_db.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdsqlite> $<TARGET_OBJECTS:tddb> $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_db PRIVATE $<TARGET_PROPERTY:tdactor,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tddb,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_db PRIVATE $<TARGET_PROPERTY:tdnet,LINK_LIBRARIES>)

add_executable(bench_tddb bench_tddb.cpp $<TARGET_OBJECTS:tdcore> $<TARGET_OBJECTS:tdcore> $<TARGET_OBJECTS:tddb> $<TARGET_OBJECTS:tdutils> $<TARGET_OBJECTS:tdsqlite>)
target_include_directories(bench_tddb PRIVATE $<TARGET_PROPERTY:tdcore,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tddb,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)

add_executable(bench_misc bench_misc.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdcore> $<TARGET_OBJECTS:tdutils> $<TARGET_OBJECTS:tddb>)
target_include_directories(bench_misc PRIVATE $<TARGET_PROPERTY:tdcore,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(bench_misc PRIVATE tdapi $<TARGET_PROPERTY:tdutils,LINK_LIBRARIES> $<TARGET_PROPERTY:tddb,LINK_LIBRARIES>)

add_executable(check_proxy check_proxy.cpp $<TARGET_OBJECTS:tdutils>)
target_include_directories(check_proxy PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(check_proxy PRIVATE tdclient)

add_executable(check_tls check_tls.cpp $<TARGET_OBJECTS:tdutils>)
target_include_directories(check_tls PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(check_tls PRIVATE $<TARGET_PROPERTY:tdutils,LINK_LIBRARIES>)

add_executable(rmdir rmdir.cpp $<TARGET_OBJECTS:tdutils>)
target_include_directories(rmdir PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)

add_executable(wget wget.cpp $<TARGET_OBJECTS:tdactor> $<TARGET_OBJECTS:tdnet> $<TARGET_OBJECTS:tdutils>)
target_include_directories(wget PRIVATE $<TARGET_PROPERTY:tdactor,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdnet,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
target_link_libraries(wget PRIVATE $<TARGET_PROPERTY:tdnet,LINK_LIBRARIES>)

add_executable(bench_empty bench_empty.cpp $<TARGET_OBJECTS:tdutils>)
target_include_directories(bench_empty PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)

if (NOT WIN32 AND NOT CYGWIN)
  add_executable(bench_log bench_log.cpp $<TARGET_OBJECTS:tdutils>)
  target_include_directories(bench_log PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)

  set_source_files_properties(bench_queue.cpp PROPERTIES COMPILE_FLAGS -Wno-deprecated-declarations)
  add_executable(bench_queue bench_queue.cpp $<TARGET_OBJECTS:tdutils>)
  target_include_directories(bench_queue PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
endif()

if (TD_TEST_FOLLY AND TD_WITH_ABSEIL)
  find_package(ABSL QUIET)
  find_package(folly QUIET)
  find_package(gflags QUIET)

  if (ABSL_FOUND AND folly_FOUND)
    add_executable(memory-hashset-memprof EXCLUDE_FROM_ALL hashset_memory.cpp $<TARGET_OBJECTS:tdutils> $<TARGET_OBJECTS:memprof_stat>)
    target_include_directories(memory-hashset-memprof PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES> $<TARGET_PROPERTY:memprof_stat,INCLUDE_DIRECTORIES>)
    target_compile_definitions(memory-hashset-memprof PRIVATE USE_MEMPROF=1)
    target_link_libraries(memory-hashset-memprof PRIVATE Folly::folly absl::flat_hash_map absl::hash)

    add_executable(memory-hashset-os hashset_memory.cpp $<TARGET_OBJECTS:tdutils>)
    target_include_directories(memory-hashset-os PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
    target_compile_definitions(memory-hashset-os PRIVATE USE_MEMPROF=0)
    target_link_libraries(memory-hashset-os PRIVATE Folly::folly absl::flat_hash_map absl::hash)

    add_executable(hashmap-build hashmap_build.cpp $<TARGET_OBJECTS:tdutils>)
    target_include_directories(hashmap-build PRIVATE $<TARGET_PROPERTY:tdutils,INCLUDE_DIRECTORIES>)
    target_link_libraries(hashmap-build PRIVATE Folly::folly absl::flat_hash_map absl::hash)
  endif()
endif()
