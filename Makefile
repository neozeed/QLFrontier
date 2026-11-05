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
rastertest: build/frontier8 build/empty.o $(AS) $(LD)
	python3 tests/make_rastertest.py
	$(AS) -N build/rastertest.s -o build/rastertest.o
	QLLIB=vendor/lib $(LD) -Sbuild/rastertest.o build/empty.o -o build/rastertest -ms
check-raster: rastertest
	$(MAKE) -C profiling
	profiling/qlbox-profile --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run $(CURDIR)/build/rastertest --frames 10000
check-cache: all
	$(MAKE) -C profiling
	python3 tests/make_cachetest.py 0
	$(AS) -N build/cachetest0.s -o build/cachetest0.o
	QLLIB=vendor/lib $(LD) -Sbuild/cachetest0.o build/empty.o -o build/cachetest0 -ms
	profiling/qlbox-profile --no-config --rom minerva --ram 2m --no-qsound --speed 8 --run $(CURDIR)/build/cachetest0 --frames 10000
	python3 tests/make_cachetest.py 8
	$(AS) -N build/cachetest8.s -o build/cachetest8.o
	QLLIB=vendor/lib $(LD) -Sbuild/cachetest8.o build/empty.o -o build/cachetest8 -ms
	profiling/qlbox-profile --no-config --rom minerva --ram 2m --no-qsound --speed 8 --run $(CURDIR)/build/cachetest8 --frames 10000
clean:
	rm -rf build
check-text: all
	$(MAKE) -C profiling
	python3 tests/make_texttest.py 0
	$(AS) -N build/texttest0.s -o build/texttest0.o
	QLLIB=vendor/lib $(LD) -Sbuild/texttest0.o build/empty.o -o build/texttest0 -ms
	profiling/qlbox-profile --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run $(CURDIR)/build/texttest0 --frames 10000
	python3 tests/make_texttest.py 8
	$(AS) -N build/texttest8.s -o build/texttest8.o
	QLLIB=vendor/lib $(LD) -Sbuild/texttest8.o build/empty.o -o build/texttest8 -ms
	profiling/qlbox-profile --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run $(CURDIR)/build/texttest8 --frames 10000
.PHONY: all frontier0 frontier8 check clean rastertest check-raster check-cache check-text
