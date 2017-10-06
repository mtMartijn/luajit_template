CXX := clang++

PRG_NAME := mt
BIN_DIR := .
SRC_DIR := .
OBJ_DIR := deps

CXXFLAGS := -Wall -g -std=c++14#-fdiagnostics-color
LIBS := `pkg-config --static --libs glfw3 luajit` -lvulkan
LDFLAGS := -Wl,-rpath=lib,-Llib $(LIBS)

PRG_SRCS := $(wildcard $(SRC_DIR)/*.cpp)
PRG_HEADERS := $(wildcard $(SRC_DIR)/*.h)
PRG_OBJS := $(PRG_SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
DEPS := $(PRG_OBJS:.o=.d)

RM := rm -rf

PRG_PATH := $(BIN_DIR)/$(PRG_NAME)

.PHONY: all clean run

all: $(PRG_PATH)
	
-include $(DEPS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -MMD -o $@ 

$(PRG_PATH): $(PRG_OBJS)
	$(CXX) $^ $(LDFLAGS) -o $@
	@echo "==== Success! ===="

run:
	@cd $(BIN_DIR) && ./$(PRG_NAME)

clean:
	-$(RM) $(PRG_PATH) 
	-$(RM) $(OBJ_DIR)

