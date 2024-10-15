# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "ATM_PROJECT_autogen"
  "CMakeFiles\\ATM_PROJECT_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\ATM_PROJECT_autogen.dir\\ParseCache.txt"
  )
endif()
