cmake_minimum_required(VERSION 3.10)
project(Engine)

# Установка путей к Vulkan SDK
set(Vulkan_INCLUDE_DIR $ENV{VULKAN_SDK}/include)
set(Vulkan_LIBRARY $ENV{VULKAN_SDK}/lib/libvulkan.so)

# Указываем, где искать Vulkan
find_package(Vulkan REQUIRED)

# Добавляем исполняемый файл
add_executable(${PROJECT_NAME} main.cpp)

# Линковка с Vulkan
target_include_directories(${PROJECT_NAME} PRIVATE ${Vulkan_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} ${Vulkan_LIBRARY})