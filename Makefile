all: clean build

PKGFLAGS = $(shell pkg-config --cflags --libs 'libprotobuf-c >= 1.0.0')

clean:
	mkdir -p build
	rm -rf build/*
	rm -rf src/*.pb-c.*

build: build/amessage_serialize build/amessage_deserialize

build/amessage_serialize: src/amessage.pb-c.c
	gcc -g ./src/amessage_serialize.c $< -o $@ $(PKGFLAGS)

build/amessage_deserialize: src/amessage.pb-c.c
	gcc -g ./src/amessage_deserialize.c $< -o $@ $(PKGFLAGS)

src/amessage.pb-c.c:
	cd src && protoc-c --c_out=. amessage.proto
