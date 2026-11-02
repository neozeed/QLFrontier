# Shared native services and original game source; two display configurations.
AS = vendor/as68/as68
LD = vendor/ld/ld
all: build/frontier0 build/frontier8
frontier0: build/frontier0
frontier8: build/frontier8
$(AS):
	$(MAKE) -C vendor/as68
$(LD):
	$(MAKE) -C vendor/ld
build:
	mkdir -p build
build/generated.stamp: $(wildcard tools/*.py) $(wildcard src/*.s) reference/fe2.s reference/fe2.c reference/hostcall.c | build
	python3 tools/platform.py
	python3 tools/variants.py
	python3 tools/port.py 0
	python3 tools/port.py 8
	touch $@
build/frontier0.s build/frontier8.s: build/generated.stamp
build/frontier0.o: build/frontier0.s build/generated.stamp $(AS)
	$(AS) -N $< -o $@
build/frontier8.o: build/frontier8.s build/generated.stamp $(AS)
	$(AS) -N $< -o $@
build/empty.o: $(AS) | build
	printf ' .text\n' > build/empty.s
	$(AS) build/empty.s -o $@
build/frontier0: build/frontier0.o build/empty.o $(LD)
	QLLIB=vendor/lib $(LD) -Sbuild/frontier0.o build/empty.o -o $@ -ms
build/frontier8: build/frontier8.o build/empty.o $(LD)
	QLLIB=vendor/lib $(LD) -Sbuild/frontier8.o build/empty.o -o $@ -ms
check: all
	python3 tests/check_dual.py
clean:
	rm -rf build
.PHONY: all frontier0 frontier8 check clean
