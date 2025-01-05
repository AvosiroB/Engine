# shellcheck disable=SC2164
mkdir "build"

./shaders/compile.sh


cd "build"
cmake ..
cmake --build .