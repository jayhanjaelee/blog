all: run

run:
	cmake . -B build && make -C build
	./build/src/app
