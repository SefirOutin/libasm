NAME = libasm.a

# Compilateur assembleur
ASM = nasm

# Drapeaux pour le compilateur
ASMFLAGS = -f elf64

# Archiveur pour créer la bibliothèque
AR = ar
ARFLAGS = rcs

# Dossier des sources
SRC_DIR = srcs

# Fichiers source en assembleur
SRCS = $(wildcard $(SRC_DIR)/*.s)

# Fichiers objets correspondants
OBJS = $(SRCS:$(SRC_DIR)/%.s=%.o)

all: $(NAME)

# Règle pour créer la bibliothèque
$(NAME): $(OBJS)
	nasm -f elf64 -g3 $(SRCS)
	ld -shared -o $(NAME) $(OBJS)
	# $(AR) $(ARFLAGS) $@ $^

# Règle pour créer les fichiers objets
$(SRC_DIR)/%.o: $(SRC_DIR)/%.s
	$(ASM) $(ASMFLAGS) -o $@ $<

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
