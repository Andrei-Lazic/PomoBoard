#Andrei
#Cross Compilation Makefile

#system
UNAME_S = $(shell uname -s)

#directories for compiling
BUILD_DIR = build/$(shell uname -s)-$(shell uname -m)
LIB_DIR = lib/$(shell uname -s)-$(shell uname -m)
BIN_DIR = bin/$(shell uname -s)-$(shell uname -m)

SRC = pomodoro.c pomoWindow.c pomoTimer.c
OBJ = $(SRC:%.c=$(BUILD_DIR)/%.o)
TARGET_NAME = pomodoro

#linux
ifeq ($(UNAME_S), Linux)
	CC = gcc
	CPPFLAGS = -I.
	CFLAGS = -Wall -extra -Werror -pedantic -std=c99
	LIBS = -lSDL2 -lSDL2_ttf
	#ext for linux exec is nothing
	EXT =  

#apple / mac
else ifeq ($(UNAME_S), Darwin) 
	CC = clang
	CPPFLAGS = -I.
	CFLAGS = -Wall -extra -Werror -pedantic -std=c99
	LIBS = -L/usr/local/lib -lSDL2 -lSDL2_ttf
	#ext for mac exec is nothing aswell (unix based i think)
	EXT = 

#windows 
else 
	CC = x86_64-w64-mingw32-gcc
	CPPFLAGS = -I.
	CFLAGS = -Wall -Wextra -Werror -pedantic -std=c99
	LIBS = -L/usr/x86_64-w64-mingw32/lib -lmingw32 -lSDL2main -lSDL2 -lSDL2_ttf
	#ext for windows exec is .exe 
	EXT = .exe 
endif

TARGET = $(BIN_DIR)/$(TARGET_NAME)$(EXT)

.PHONY: all clean buildDirs

all: buildDirs $(TARGET)

clean: 
	rm -rf $(LIB_DIR) $(BUILD_DIR) $(BIN_DIR) $(TARGET) lib/ bin/ build/

#build the directories
buildDirs: $(BUILD_DIR) $(LIB_DIR) $(BIN_DIR) 

$(BUILD_DIR) $(LIB_DIR) $(BIN_DIR):
	mkdir -p $(@)

#c to obj 
$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

#link obj to exec
$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $@ $(LIBS) 

