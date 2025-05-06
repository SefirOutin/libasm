#include <stdio.h>
// #include <string.h>
#include <stdlib.h>
// #include <unistd.h>
// #include <errno.h>

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

extern int indexInBase(char *str, char c);
extern int ft_iswspace(char c);
extern int checkBase(char *base);


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
/*

*/
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

int main(int c, char **v)
{
	char *str;
	t_list *head = NULL;
	

	printf("strcmp: %d\n", ft_strcmp("1", "2"));
	str = ft_strdup("1");
	ft_list_push_front(&head, str);
	str = ft_strdup("9");
	ft_list_push_front(&head, str);
	str = ft_strdup("3");
	ft_list_push_front(&head, str);
	str = ft_strdup("7");
	ft_list_push_front(&head, str);
	str = ft_strdup("9");
	ft_list_push_front(&head, str);
	str = ft_strdup("5");
	ft_list_push_front(&head, str);
	str = ft_strdup("2");
	ft_list_push_front(&head, str);
	str = ft_strdup("1");
	ft_list_push_front(&head, str);
	str = ft_strdup("9");
	ft_list_push_front(&head, str);
	printf("size: %d\n", ft_list_size(head));
	printf("head: %p\n", &head);
	printList(head);
	
	ft_list_remove_if(&head, "9", ft_strcmp, free);
	// t_list *t = (t_list *)ft_list_sort(&head, ft_strcmp);
	// ft_list_sort(&head, ft_strcmp);
	// printf("aaaaaaaaaaa->%s\n", (char *)t->data);
	printList(head);
	freeList(&head);
    return 0;
}


// #include <stdio.h>
// int main() {
//     char dest[100], src[] = "f", readBuf[100];

//     printf("ft_strlen\nlen \"\": %ld\n", ft_strlen(""));
//     printf("len \"0123456789\": %ld\n\n", ft_strlen("0123456789"));
    

//     printf("ft_strcpy\nstring to cpy: \"%s\": %ld\n", src, ft_strlen(src));
//     printf("dest before: %s\n", dest);
//     ft_strcpy(dest, src);
//     printf("dest after: %s (len %ld)\n\n", dest, ft_strlen(dest));
    

//     printf("ft_strcmp\n");
//     printf("ft_strcmp \"abc\" \"abc\": %d\n", ft_strcmp("abc", "abc"));
//     printf("ft_strcmp \"abc\" \"ab\": %d\n", ft_strcmp("abc", "ab"));
//     printf("ft_strcmp \"aba\" \"abz\": %d\n", ft_strcmp("aba", "abz"));
//     printf("ft_strcmp \"abj\" \"abc\": %d\n", ft_strcmp("abj", "abc"));
//     printf("ft_strcmp \"abc\" \"abcd\": %d\n", ft_strcmp("abc", "abcd"));
//     printf("ft_strcmp \"\" \"ab\": %d\n", ft_strcmp("", "ab"));

//     printf("strcmp \"abc\" \"abc\": %d\n", strcmp("abc", "abc"));
//     printf("strcmp \"abc\" \"ab\": %d\n", strcmp("abc", "ab"));
//     printf("strcmp \"aba\" \"abz\": %d\n", strcmp("aba", "abz"));
//     printf("strcmp \"abj\" \"abc\": %d\n", strcmp("abj", "abc"));
//     printf("strcmp \"abc\" \"abcd\": %d\n", strcmp("abc", "abcd"));
//     printf("strcmp \"\" \"ab\": %d\n\n", strcmp("", "ab"));
    

//     ft_write(1, "ft_write\n", 9);
//     printf(" (return: %ld) <- arg len = -6\n", ft_write(1, "write", -6));
//     printf("\"\" (return: %ld)\n", ft_write(1, "", 1));
//     printf(" (return: %ld)\n", ft_write(1, "Hello World", 11));
//     printf(" (return: %ld)\n", ft_write(1, "hmmmmmmmmmmmmmmmmmmmmmmmmmmm", 29));
    

//     printf("\nft_read\n");
//     ft_write(1, "Enter your age: ", 17);
//     errno = 0;
//     printf("(return ft: %ld) %s", ft_read(1, readBuf, 100), readBuf);
//     printf("errno: %s\n", strerror(errno));
//     errno = 0;
//     ft_write(1, "\nEnter your age: ", 17);
//     printf("(return: %ld) %s", read(1, readBuf, 100), readBuf);
//     printf("errno: %s\n", strerror(errno));


//     printf("\nft_strdup\n");
//     char *dup = ft_strdup("Hello World");
//     printf("dup: %s\n", dup);
//     printf("dup len: %ld\n", ft_strlen(dup));
//     free(dup);

//     dup = ft_strdup("");
//     printf("\ndup: %s\n", dup);
//     printf("dup len: %ld\n", ft_strlen(dup));
//     free(dup);

//     dup = ft_strdup("0123456789");
//     printf("\ndup: %s\n", dup);
//     printf("dup len: %ld\n", ft_strlen(dup));
//     free(dup);

//     dup = ft_strdup(NULL);
//     printf("\nft_strdup(NULL) -> %s\n", dup);

    // printf("ft_atoi_base\n");
    // printf("base: %s, str: %s \t| output: %d\n", "0123456789", "42424242", ft_atoi_base("42424242", "0123456789"));
    // printf("base: %s, str: %s \t| output: %d\n", "0123456789abcdef", "42a", ft_atoi_base("42a", "0123456789abcdef"));
    // printf("base: %s, str: %s \t\t| output: %d\n", "01", "10010110", ft_atoi_base("10010110", "01"));
    // printf("base: %s, str: %s \t\t| output: %d\n", "poneyvif ", "epn", ft_atoi_base("epn", "poneyvif"));
    // printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "\'   \'42", ft_atoi_base("     42", "0123456789"));
    // printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "-42", ft_atoi_base("-42", "0123456789"));
    // printf("base: %s, str: %s \t| output: %d\n", "0123456789", "\'   \'-+42", ft_atoi_base("     -+42", "0123456789"));
    // printf("base: %s, str: %s \t| output: %d\n", "0123456789", "\'   \'------42", ft_atoi_base("     ------42", "0123456789"));
    // printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "42f5", ft_atoi_base("42f5", "0123456789"));
    // printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "-42-8", ft_atoi_base("-42-8", "0123456789"));
    // printf("base: %s, str: %s \t\t| output: %d\n", "0123456789", "f42", ft_atoi_base("f42", "0123456789"));
    // printf("base: NULL, str: NULL \t\t| output: %d\n", ft_atoi_base(NULL, NULL));
    

//     return 0;
// }

