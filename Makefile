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

test:
	nasm -g -f elf64 srcs/ft_strlen.s -o ft_strlen.o
	nasm -g -f elf64 srcs/ft_strcpy.s -o ft_strcpy.o
	nasm -g -f elf64 srcs/ft_strcmp.s -o ft_strcmp.o
	nasm -g -f elf64 srcs/ft_write.s -o ft_write.o
	nasm -g -f elf64 srcs/ft_read.s -o ft_read.o
	nasm -g -f elf64 srcs/ft_strdup.s -o ft_strdup.o
	
	nasm -g -f elf64 srcs/ft_atoi_base.s -o ft_atoi_base.o

	nasm -g -f elf64 srcs/ft_list_push_front.s -o ft_list_push_front.o
	nasm -g -f elf64 srcs/ft_list_size.s -o ft_list_size.o
	nasm -g -f elf64 srcs/ft_list_remove_if.s -o ft_list_remove_if.o
	nasm -g -f elf64 srcs/ft_list_sort.s -o ft_list_sort.o

	gcc -g -c srcs/main.c -o main.o

	gcc -no-pie -g -F dwarf main.o ft_strdup.o ft_read.o ft_strlen.o ft_write.o ft_strcmp.o ft_strcpy.o ft_atoi_base.o ft_list_push_front.o ft_list_size.o ft_list_sort.o ft_list_remove_if.o -o program
	rm *.o

.PHONY: all clean fclean re
