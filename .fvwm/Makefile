CC := gcc
CFLAGS :=   -Wall -O0 -fomit-frame-pointer \
	`imlib2-config --cflags`
#CPPFLAGS :=
CXXFLAGS := $(CFLAGS)
TARGET_ARCH := -march=native
LDFLAGS := -Wl,-O1 \
	`imlib2-config --libs` \
	-lX11

PRODUCTS := thumb

.PHONY: clean

all: $(PRODUCTS)

clean:
	find *.o -exec rm {} \; && echo || echo

mrproper: clean
	for product in $(PRODUCTS); \
	do [ -f $$product ] && rm $$product; \
	done && echo || echo

rebuild: mrproper all

thumb: thumb.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
	strip $@
