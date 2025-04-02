#include <stdio.h>
#include <string.h>
extern size_t ft_strlen(const char *str);
extern char *ft_strcpy(char *dest, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);


int main() {
    char dest[100], src[] = "f";

    printf("ft_strlen\nlen "": %ld\n", ft_strlen(""));
    printf("len \"0123456789\": %ld\n\n", ft_strlen("0123456789"));
    
    printf("ft_strcpy\nstring to cpy: \"%s\": %ld\n", src, ft_strlen(src));
    printf("dest before: %s\n", dest);
    ft_strcpy(dest, src);
    printf("dest after: %s (len %ld)\n\n", dest, ft_strlen(dest));
    
    printf("ft_strcmp\n");
    printf("ft_strcmp \"abc\" \"abc\": %d\n", ft_strcmp("abc", "abc"));
    printf("ft_strcmp \"abc\" \"ab\": %d\n", ft_strcmp("abc", "ab"));
    printf("ft_strcmp \"aba\" \"abz\": %d\n", ft_strcmp("aba", "abz"));
    printf("ft_strcmp \"abj\" \"abc\": %d\n", ft_strcmp("abj", "abc"));
    printf("ft_strcmp \"abc\" \"abcd\": %d\n", ft_strcmp("abc", "abcd"));
    printf("ft_strcmp \"\" \"ab\": %d\n", ft_strcmp("", "ab"));

    printf("strcmp \"abc\" \"abc\": %d\n", strcmp("abc", "abc"));
    printf("strcmp \"abc\" \"ab\": %d\n", strcmp("abc", "ab"));
    printf("strcmp \"aba\" \"abz\": %d\n", strcmp("aba", "abz"));
    printf("strcmp \"abj\" \"abc\": %d\n", strcmp("abj", "abc"));
    printf("strcmp \"abc\" \"abcd\": %d\n", strcmp("abc", "abcd"));
    printf("strcmp \"\" \"ab\": %d\n", strcmp("", "ab"));
    return 0;
}