cmake_minimum_required(VERSION 3.10)
project(Engine)

# Проверка и настройка Vulkan SDK
if (NOT DEFINED ENV{VULKAN_SDK})
    message(STATUS "Vulkan SDK не найден. Устанавливаем Vulkan SDK...")
    execute_process(
            COMMAND bash -c "
        if ! command -v vulkaninfo &> /dev/null; then
            echo 'Скачиваем и устанавливаем Vulkan SDK...'
            wget https://sdk.lunarg.com/sdk/download/1.3.296.0/linux/vulkan-sdk.tar.gz -O vulkan-sdk.tar.gz
            sudo tar -xJf vulkan-sdk.tar.gz -C /opt/
            echo 'export VULKAN_SDK=/opt/1.3.296.0/x86_64' >> ~/.bashrc
            echo 'export PATH=$VULKAN_SDK/bin:$PATH' >> ~/.bashrc
            echo 'export LD_LIBRARY_PATH=$VULKAN_SDK/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
            echo 'export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json' >> ~/.bashrc  # Исправленный путь
            echo 'export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d' >> ~/.bashrc
            source ~/.bashrc

        else
            echo 'Vulkan SDK уже установлен.'
        fi"
            RESULT_VARIABLE INSTALL_RESULT
    )
    if (NOT INSTALL_RESULT EQUAL 0)
        message(FATAL_ERROR "Не удалось установить Vulkan SDK.")
    endif()
endif()

# Установка путей к Vulkan SDK
set(Vulkan_INCLUDE_DIR $ENV{VULKAN_SDK}/include)
set(Vulkan_LIBRARY $ENV{VULKAN_SDK}/lib/libvulkan.so)

# Указываем, где искать Vulkan
find_package(Vulkan REQUIRED)

# Добавляем исполняемый файл
add_executable(${PROJECT_NAME} main.cpp)

# Линковка с Vulkan
target_include_directories(${PROJECT_NAME} PRIVATE ${Vulkan_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} Vulkan::Vulkan)
