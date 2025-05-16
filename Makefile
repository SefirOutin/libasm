NAME = libasm.a

# Assembler compiler
ASM = nasm
ASMFLAGS = -f elf64 -g

# Archiver to create the library
AR = ar
ARFLAGS = rcs

# Source & objects directories
SRC_DIR = srcs
OBJ_DIR = objs

# Automatic source file discovery
SRC_FILES = $(wildcard $(SRC_DIR)/*.s)
OBJS = $(patsubst $(SRC_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRC_FILES))

# Rule to create objects directory
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Rule to create the library
$(NAME): $(OBJ_DIR) $(OBJS)
	$(AR) $(ARFLAGS) $@ $(OBJS)

# Rule to create object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	$(ASM) $(ASMFLAGS) -o $@ $<

all: $(NAME)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all

test: all
	gcc -W -Wall -Wextra -g3 -o main main.c -L. -lasm

.PHONY: all clean fclean re test
