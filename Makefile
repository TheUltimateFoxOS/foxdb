OBJDIR = ./lib
BUILDDIR = ./bin
OUTPUT = foxdb.elf

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

CSRC = $(call rwildcard,./,*.c)

OBJS = $(patsubst %.c, $(OBJDIR)/%_$(OUTPUT).o, $(CSRC))


CFLAGS = -Iinclude -Ilibfoxdb/include -g
LDFLAGS = 

# CFLAGS += $(USER_CFLAGS)
# LDFLAGS += $(USER_LDFLAGS)

CC = gcc
LD = gcc

$(OUTPUT): $(OBJS)
	@mkdir -p $(BUILDDIR)
	@echo LD $^
	@$(LD) $(LDFLAGS) -o $(BUILDDIR)/$@ $^
	@echo Succesfully build program $(OUTPUT)

$(OBJDIR)/%_$(OUTPUT).o: %.c
	@echo "CC $^ -> $@"
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -c -o $@ $^

clean:
	rm -rfv $(BUILDDIR) $(OBJDIR)

.PHONY: build
