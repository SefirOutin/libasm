#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

typedef struct s_list
{
    void            *data;
    struct s_list   *next;
}                   t_list;

extern size_t ft_strlen(const char *str);
extern char *ft_strcpy(char *dest, const char *src);
extern char *ft_strdup(const char *s);
extern int ft_strcmp(const char *s1, const char *s2);
extern size_t ft_write(unsigned int fd, const void *buf, size_t count);
extern size_t ft_read(int fd, void *buf, size_t count);
extern int ft_atoi_base(char *str, char *base);
extern void ft_list_push_front(t_list **begin_list, void *data);
extern void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
extern void ft_list_sort(t_list **begin_list, int (*cmp)());
extern int ft_list_size(t_list *begin_list);

void printList(t_list *head)
{
	t_list *tmp = head;
	while (tmp)
	{
		printf("Node addr: %p data addr: %p data: %s\n", tmp, tmp->data, (char *)tmp->data);
		tmp = tmp->next;
	}
	printf("\n");
}

void freeList(t_list **head)
{
	t_list *tmp;
	while (*head)
	{
		tmp = *head;
		*head = (*head)->next;
		free(tmp->data);
		free(tmp);
	}
}

int main() {
	char dest[100], src[] = "fooooooob", readBuf[100];
	t_list *head = NULL;
    
    memset(dest, 0, sizeof(dest));
    memset(readBuf, 0, sizeof(readBuf));
    // write(1, NULL, 1);

    printf("ft_strlen\n");
	printf("len \"\": %ld\n", ft_strlen(""));
    printf("len \"0123456789\": %ld\n", ft_strlen("0123456789"));    

    printf("\nft_strcpy\n");
	printf("string to cpy: \"%s\" (len %ld)\n", src, ft_strlen(src));
    printf("dest before: %s\n", dest);
    ft_strcpy(dest, src);
    printf("dest after: %s (len %ld)\n", dest, ft_strlen(dest));
    

    printf("\nft_strcmp\n");
    printf("\"abc\" \"abc\"\tft_strcmp: %d | strcmp: %d\n", ft_strcmp("abc", "abc"), strcmp("abc", "abc"));
    printf("\"abc\" \"ab\"\tft_strcmp: %d | strcmp: %d\n", ft_strcmp("abc", "ab"), strcmp("abc", "ab"));
    printf("\"aba\" \"abz\"\tft_strcmp: %d | strcmp: %d\n", ft_strcmp("aba", "abz"), strcmp("aba", "abz"));
    printf("\"abj\" \"abc\"\tft_strcmp: %d | strcmp: %d\n", ft_strcmp("abj", "abc"), strcmp("abj", "abc"));
    printf("\"abc\" \"abcd\"\tft_strcmp: %d | strcmp: %d\n", ft_strcmp("abc", "abcd"), strcmp("abc", "abcd"));
    printf("\"\" \"ab\"\t\tft_strcmp: %d | strcmp: %d\n", ft_strcmp("", "ab"), strcmp("", "ab"));


    ft_write(1, "\nft_write\n", 10);
    printf("ft_write: \"\" (return: %ld) <- arg len = -6\n", ft_write(1, "write", -6));
    // printf("write: \"\" (return: %ld) <- arg len = -6\n", write(1, "", -6));
    printf("\"\" (return: %ld)\n", ft_write(1, "", 1));
    printf(" (return: %ld)\n", ft_write(1, "Hello World", 11));
    printf(" (return: %ld)\n", ft_write(1, "hmmmmmmmmmmmmmmmmmmmmmmmmmmm", 29));
    

    printf("\nft_read\n");
    ft_write(1, "Enter something (100 char max): ", 32);
    errno = 0;
    printf("(return ft: %ld) %s", ft_read(0, readBuf, 100), readBuf);
    printf("errno: %s\n", strerror(errno));
    printf("\nread\n");
    ft_write(1, "Enter something (100 char max): ", 32);
    errno = 0;
    printf("(return ft: %ld) %s", ft_read(0, readBuf, 100), readBuf);
    printf("errno: %s\n", strerror(errno));

    printf("\nft_strdup\n");
    char *dup;
	dup = ft_strdup("Hello World");
    printf("dup: %s (len %ld)\n", dup, ft_strlen(dup));
    free(dup);
    dup = ft_strdup("");
    printf("dup: %s (len %ld)\n", dup, ft_strlen(dup));
    free(dup);
    dup = ft_strdup("0123456789");
    printf("dup: %s (len %ld)\n", dup, ft_strlen(dup));
    free(dup);

    printf("\nft_atoi_base\n");
    printf("base: %s, str: %s \t| output: %d\n", "0123456789", "42424242", ft_atoi_base("42424242", "0123456789"));
    printf("base: %s, str: %s \t| output: %d\n", "0123456789abcdef", "42a", ft_atoi_base("42a", "0123456789abcdef"));
    printf("base: %s, str: %s \t\t| output: %d\n", "01", "10010110", ft_atoi_base("10010110", "01"));
    printf("base: %s, str: %s \t\t| output: %d\n", "poneyvif ", "epn", ft_atoi_base("epn", "poneyvif"));
    printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "\'   \'42", ft_atoi_base("     42", "0123456789"));
    printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "-42", ft_atoi_base("-42", "0123456789"));
    printf("base: %s, str: %s \t| output: %d\n", "0123456789", "\'   \'-+42", ft_atoi_base("     -+42", "0123456789"));
    printf("base: %s, str: %s \t| output: %d\n", "0123456789", "\'   \'------42", ft_atoi_base("     ------42", "0123456789"));
    printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "42f5", ft_atoi_base("42f5", "0123456789"));
    printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "-42-8", ft_atoi_base("-42-8", "0123456789"));
    printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "f42", ft_atoi_base("f42", "0123456789"));
    printf("base: NULL, str: NULL \t\t\t| output: %d\n", ft_atoi_base(NULL, NULL));
    
	printf("\nLIST FUNCTIONS\n");

	printf("ft_list_push_front\n");
	ft_list_push_front(&head, ft_strdup("1"));
	ft_list_push_front(&head, ft_strdup("9"));
	ft_list_push_front(&head, ft_strdup("3"));
	ft_list_push_front(&head, ft_strdup("7"));
	ft_list_push_front(&head, ft_strdup("9"));
	ft_list_push_front(&head, ft_strdup("5"));
	ft_list_push_front(&head, ft_strdup("2"));
	ft_list_push_front(&head, ft_strdup("1"));
	ft_list_push_front(&head, ft_strdup("9"));
	printList(head);
    
	printf("\nft_list_size\n");
	printf("size list: %d\n", ft_list_size(head));
	printf("size NULL: %d\n", ft_list_size(NULL));
    
	printf("\nft_list_sort\n");
	ft_list_sort(&head, ft_strcmp);
	printList(head);
    
	printf("\nft_list_remove_if (\"9\")\n");
    printf("head before: %p\n", head);
	ft_list_remove_if(&head, "9", ft_strcmp, free);
    printf("printing list after removing: head %p\n", head);
	printList(head);
    
    ft_list_remove_if(&head, "1", ft_strcmp, free);
	ft_list_remove_if(&head, "3", ft_strcmp, free);
	ft_list_remove_if(&head, "5", ft_strcmp, free);
    ft_list_remove_if(&head, "2", ft_strcmp, free);
	ft_list_remove_if(&head, "7", ft_strcmp, free);
	
    return 0;
}

