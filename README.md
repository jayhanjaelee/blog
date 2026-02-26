# Blog

This is My Blog written in c language using ecewo framework.

## build and run

1. clone this repository.
2. create build directory.

```sh
mkdir build
```

```shell
make
```

## PUBLIC_DIR 변수

애플리케이션은 정적 파일(HTML, CSS, JS 등)을 `public/` 디렉토리에서 제공합니다.

### 동작 방식

`PUBLIC_DIR` 변수는 **CMake 빌드 시점에 절대경로로 자동 설정**됩니다:

```cmake
# src/controller/CMakeLists.txt
target_compile_definitions(controller PRIVATE
    PUBLIC_DIR="${CMAKE_SOURCE_DIR}/public"
)
```

이를 통해:
- **절대경로 사용**: 어디서 실행하든 `/Users/jay/Desktop/blog/public` 같은 절대경로로 변환됨
- **빌드타임 설정**: 코드 수정 없이 CMake 설정만으로 경로 변경 가능
- **환경 독립성**: 개발/프로덕션 환경에 따라 다른 경로 설정 가능

### 사용 예시

```c
// src/controller/controller.c
void index_controller(Req *req, Res *res) {
    char filename[1024];
    snprintf(filename, sizeof(filename), "%s/%s", PUBLIC_DIR, "index.html");
    // PUBLIC_DIR은 CMake가 "/Users/jay/Desktop/blog/public"으로 치환
}
```

### 경로 확인

빌드 후 생성되는 `build/compile_commands.json`에서 실제 정의된 값을 확인할 수 있습니다.

## build docker image

```shell
./build_docker_image.sh
```
