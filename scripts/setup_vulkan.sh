sudo -v

wget https://sdk.lunarg.com/sdk/download/1.3.296.0/linux/vulkan-sdk.tar.gz -O vulkan-sdk.tar.gz
sudo tar -xJf vulkan-sdk.tar.gz -C /opt/

# shellcheck disable=SC2129
echo 'export VULKAN_SDK=/opt/1.3.296.0/x86_64' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'export PATH=$VULKAN_SDK/bin:$PATH' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'export LD_LIBRARY_PATH=$VULKAN_SDK/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'export VK_LAYER_PATH=$VULKAN_SDK/share/vulkan/explicit_layer.d' >> ~/.bashrc

rm vulkan-sdk.tar.gz

# shellcheck disable=SC1090
source ~/.bashrc
exec bash