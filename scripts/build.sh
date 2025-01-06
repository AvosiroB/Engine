# shellcheck disable=SC2164
mkdir "build"

SKIP_SHADERS=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --skip-shaders) SKIP_SHADERS=true ;;
        *) echo "Неизвестный параметр: $1" ;;
    esac
    shift
done

if [ "$SKIP_SHADERS" = false ]; then
    ./shaders/compile.sh
else
    echo "Компиляция шейдеров пропущена по флагу --skip-shaders."
fi


cd "build"
cmake ..
cmake --build .