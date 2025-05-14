NAME = libasm.a

# Compilateur assembleur
ASM = nasm
ASMFLAGS = -f elf64 -g

# Archiveur pour créer la bibliothèque
AR = ar
ARFLAGS = rcs

# Dossier des sources & objets
SRC_DIR = srcs
OBJ_DIR = objs
BONUS_OBJ_DIR = objs_bonus

# Fichiers source
SRC_FILES = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
SRCS = $(addprefix $(SRC_DIR)/,$(SRC_FILES))

# Fichiers bonus
BONUS_FILES = ft_atoi_base_bonus.s ft_list_push_front_bonus.s ft_list_size_bonus.s \
              ft_list_sort_bonus.s ft_list_remove_if_bonus.s
BONUS_SRCS = $(addprefix $(SRC_DIR)/,$(BONUS_FILES))

# Fichiers objets correspondants
OBJS = $(patsubst $(SRC_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS))
BONUS_OBJS = $(patsubst $(SRC_DIR)/%.s,$(BONUS_OBJ_DIR)/%.o,$(BONUS_SRCS))

# Fichier de marquage pour savoir si les bonus sont inclus
BONUS_MARKER = .bonus_done

all: $(NAME)

# Règle bonus qui met à jour la bibliothèque principale avec les fonctions bonus
bonus: $(BONUS_OBJ_DIR) $(BONUS_OBJS) $(NAME) $(BONUS_MARKER)

$(BONUS_MARKER): $(BONUS_OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(BONUS_OBJS)
	touch $(BONUS_MARKER)

# Règle pour créer le dossier des objets
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BONUS_OBJ_DIR):
	mkdir -p $(BONUS_OBJ_DIR)

# Règle pour créer la bibliothèque
$(NAME): $(OBJ_DIR) $(OBJS)
	$(AR) $(ARFLAGS) $@ $(OBJS)

# Règle pour créer les fichiers objets
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	$(ASM) $(ASMFLAGS) -o $@ $<

# Règle pour créer les fichiers objets bonus
$(BONUS_OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	$(ASM) $(ASMFLAGS) -o $@ $<

clean:
	rm -rf $(OBJ_DIR) $(BONUS_OBJ_DIR)
	rm -f $(BONUS_MARKER)

fclean: clean
	rm -f $(NAME)

re: fclean all

test: bonus
	gcc -W -W -W -no-pie -g -o main -fsanitize=address main.c -L. -lasm

.PHONY: all clean fclean re bonus
