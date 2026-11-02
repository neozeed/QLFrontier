# Modified 2026: portable 64-bit host build (SROFF output).
CC = cc
CFLAGS = -O2 -std=gnu99
CPPFLAGS = -DXTC68 -DLABELDIFF -DUSE_LINE -DMINIX
OBJS = cbuf.o cpy.o gen.o hdr.o lex.o main.o ops.o opt.o parse.o pass.o scan.o sym.o cross.o
as68: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)
$(OBJS): jas.h proto.h
clean:
	rm -f $(OBJS) as68
.PHONY: clean
