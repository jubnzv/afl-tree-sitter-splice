CFLAGS  ?= -O3 -funroll-loops -fPIC -Wall -Wextra
TSPREFIX ?= /usr

TSCFLAGS = $(shell pkg-config --cflags tree-sitter 2>/dev/null || echo "-I$(TSPREFIX)/include")
TSLIBS   = $(shell pkg-config --libs tree-sitter 2>/dev/null || echo "-L$(TSPREFIX)/lib -ltree-sitter")

all: libts.so

libts.so: ts.c
	$(CC) $(CFLAGS) -shared \
	  -I../../include $(TSCFLAGS) \
	  ts.c \
	  $(TSLIBS) -ldl \
	  -o $@

clean:
	rm -f libts.so *.o *~ core
