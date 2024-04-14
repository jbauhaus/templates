# Config
CC := clang
CXX := clang++
CFLAGS := -Wall -O3
DBGFLAGS := -g

BIN_PATH := bin
OBJ_PATH := obj
SRC_PATH := src
DBG_PATH := debug

TARGET_NAME := 
TARGET := $(BIN_PATH)/$(TARGET_NAME)
TARGET_DBG := $(DBG_PATH)/$(TARGET_NAME)

SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.c*)))
OBJ := $(addprefix $(OBJ_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))
OBJ_DBG := $(addprefix $(DBG_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))

# Rules
default: makedir all

$(TARGET): $(OBJ)
	$(CC) -o $@ $(OBJ) $(CFLAGS)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c*
	$(CC) -c $(CFLAGS) -o $@ $<

$(DBG_PATH)/%.o: $(SRC_PATH)/%.c*
	$(CC) -c $(CFLAGS) $(DBGFLAGS) -o $@ $<

$(TARGET_DBG): $(OBJ_DBG)
	$(CC) $(CFLAGS) $(DBGFLAGS) $(OBJ_DBG) -o $@

makedir:
	@mkdir -p $(BIN_PATH) $(OBJ_PATH) $(DBG_PATH)

all: $(TARGET)

debug: $(TARGET_DBG)

run: 
	$(TARGET)

clean:
	rm -f $(TARGET) $(TARGET_DBG) $(OBJ) $(OBJ_DBG)

.PHONY: all makedir debug run clean
