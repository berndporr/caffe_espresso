# Finds Google Protocol Buffers library and compilers and extends
# the standard cmake script with version and python generation support

find_package( Protobuf REQUIRED )
list(APPEND Caffe_INCLUDE_DIRS PUBLIC ${PROTOBUF_INCLUDE_DIR})
list(APPEND Caffe_LINKER_LIBS PUBLIC ${PROTOBUF_LIBRARIES})

# As of Ubuntu 14.04 protoc is no longer a part of libprotobuf-dev package
# and should be installed separately as in: sudo apt-get install protobuf-compiler
if(EXISTS ${PROTOBUF_PROTOC_EXECUTABLE})
  message(STATUS "Found PROTOBUF Compiler: ${PROTOBUF_PROTOC_EXECUTABLE}")
else()
  message(FATAL_ERROR "Could not find PROTOBUF Compiler")
endif()

if(PROTOBUF_FOUND)
  # fetches protobuf version
  caffe_parse_header(${PROTOBUF_INCLUDE_DIR}/google/protobuf/stubs/common.h VERION_LINE GOOGLE_PROTOBUF_VERSION)
  string(REGEX MATCH "([0-9])00([0-9])00([0-9])" PROTOBUF_VERSION ${GOOGLE_PROTOBUF_VERSION})
  set(PROTOBUF_VERSION "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}.${CMAKE_MATCH_3}")
  unset(GOOGLE_PROTOBUF_VERSION)
endif()

# place where to generate protobuf sources
set(proto_gen_folder "${PROJECT_BINARY_DIR}/include/caffe/proto")
include_directories("${PROJECT_BINARY_DIR}/include")

set(PROTOBUF_GENERATE_CPP_APPEND_PATH TRUE)
