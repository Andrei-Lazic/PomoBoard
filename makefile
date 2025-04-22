CC = gcc
CPPFLAGS = -I.
CFLAGS = -Wall -std=c99 -extra -pedantic -g

BUILD_DIR = build/$(shell uname -s)-$(shell uname -m)
BIN_DIR = bin/$(shell uname -s)-$(shell uname -m)
LIB_DIR = lib/$(shell uname -s)-$(shell uname -m)

LDFLAGS = -L./$(LIB_DIR)

.PHONY: all clean

all: pomoExec


clean:
	rm -rf pomoExec $(BUILD_DIR) $(LIB_DIR) $(BIN_DIR) ./lib ./bin ./build

$(BUILD_DIR) $(BIN_DIR) $(LIB_DIR): 
	mkdir -p $(BUILD_DIR) $(LIB_DIR) $(BIN_DIR)

$(BUILD_DIR)/pomoMain.o: pomoMain.c | $(BUILD_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c pomoMain.c -o $(BUILD_DIR)/pomoMain.o

$(BIN_DIR)/pomoExec: pomoMain.o | $(BIN_DIR)
	$(CC) $(CFLAGS) pomoMain.o -o pomoExec



#put in the pomoExec build rules...
#pomoTimer should be its own thing i think
#make cross compilation build rules and shit

