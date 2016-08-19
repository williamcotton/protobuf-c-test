all: clean build

PKGFLAGS = $(shell pkg-config --cflags --libs 'libprotobuf-c >= 1.0.0' 'librabbitmq >= 0.7.0')

clean:
	mkdir -p build
	rm -rf build/*
	rm -rf src/*.pb-c.*

build: build/amessage_serialize build/amessage_deserialize build/amqp_sendstring build/amqp_producer

build/amessage_serialize: src/amessage.pb-c.c
	gcc -g ./src/amessage_serialize.c $< -o $@ $(PKGFLAGS)

build/amessage_deserialize: src/amessage.pb-c.c
	gcc -g ./src/amessage_deserialize.c $< -o $@ $(PKGFLAGS)

build/amqp_sendstring:
	gcc -g ./src/amqp_sendstring.c ./src/utils.c -o $@ $(PKGFLAGS)

build/amqp_producer:
	gcc -g ./src/amqp_producer.c ./src/utils.c -o $@ $(PKGFLAGS)	

src/amessage.pb-c.c:
	cd src && protoc-c --c_out=. amessage.proto
