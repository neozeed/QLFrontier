CC = cc
CPPFLAGS = -DXTC68
CFLAGS = -O2 -std=c99 -D_DEFAULT_SOURCE -Wall -Wextra -Wformat=2
ld: ld.o
	$(CC) $(LDFLAGS) -o $@ ld.o $(LDLIBS)
ld.o: ldold.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
clean:
	rm -f ld.o ld
.PHONY: clean
