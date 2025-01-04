#pragma once
#include <chrono>
#include <thread>
#include <vector>
#include <cstdio>

class Entity {
public:
    float x, y, z;
    virtual void update() = 0;
};

class Cube : public Entity {
public:
    void update() override {
        // Простое движение
        x += 0.1f;
    }
};

class GameEngine {
public:
    std::vector<Cube> cubes;

    void init() {
        cubes.resize(2);
    }

    void update() {
        for(auto& cube : cubes) {
            cube.update();
        }
    }

    void render() {
        // Заглушка рендера
        for(auto& cube : cubes) {
            printf("Cube pos: %.2f\n", cube.x);
        }
    }

    // В методе run():
    void run() {
        while(true) {
            update();
            render();

            // Задержка 100 миллисекунд
            std::this_thread::sleep_for(
                    std::chrono::milliseconds(100)
            );
        }
    }
};
