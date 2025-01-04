#!/bin/bash
set -e

sudo -v

# vulkan
sudo apt install vulkan-tools

sudo apt install libvulkan-dev

sudo apt install vulkan-validationlayers-dev spirv-tools

# glfw
sudo apt install libglfw3-dev

# glm
sudo apt install libglm-dev

#libxx86
sudo apt install libxxf86vm-dev libxi-dev

# shader compiler
if command -v glslc &> /dev/null; then
  echo "glslc is already installed at $(command -v glslc). Skipping shader compiler installation."
else
  echo "glslc not found. Installation..."

  TEMP_DIR=$(mktemp -d)

  curl -o "$TEMP_DIR/install.html" https://storage.googleapis.com/shaderc/badges/build_link_linux_clang_release.html

  ARCHIVE_URL=$(grep -oP 'https://storage.googleapis.com/shaderc/[^"]+install\.tgz' "$TEMP_DIR/install.html")

  if [ -z "$ARCHIVE_URL" ]; then
      echo "Error: Unable to find the archive URL in the HTML file."
      exit 1
  fi

  curl -o "$TEMP_DIR/install.tgz" "$ARCHIVE_URL"

  tar -xzf "$TEMP_DIR/install.tgz" -C "$TEMP_DIR"

  GLSLC_PATH=$(find "$TEMP_DIR" -type f -name glslc | head -n 1)

  if [ -z "$GLSLC_PATH" ]; then
      echo "Error: glslc not found in the extracted files."
      exit 1
  fi

  sudo cp "$GLSLC_PATH" /usr/local/bin/
  sudo chmod +x /usr/local/bin/glslc

  rm -r "$TEMP_DIR"

  echo "glslc successfully installed"
fi

echo "Setup completed successfully."
