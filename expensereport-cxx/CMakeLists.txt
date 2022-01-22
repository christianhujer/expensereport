set(CMAKE_CXX_STANDARD 17)
add_executable(ExpenseReport ExpenseReport.cpp main.cpp)
target_include_directories(ExpenseReport PUBLIC .)
