#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

extern size_t ft_strlen(const char *str);
extern char *ft_strcpy(char *dest, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);
extern size_t ft_write(unsigned int fd, const void *buf, size_t count);
extern size_t ft_read(int fd, void *buf, size_t count);
extern char *ft_strdup(const char *s);

int main() {
    char dest[100], src[] = "f", readBuf[100];

    printf("ft_strlen\nlen \"\": %ld\n", ft_strlen(""));
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
    printf("strcmp \"\" \"ab\": %d\n\n", strcmp("", "ab"));
    

    ft_write(1, "ft_write\n", 9);
    printf(" (return: %ld) <- arg len = -6\n", ft_write(1, "write", -6));
    printf("\"\" (return: %ld)\n", ft_write(1, "", 1));
    printf(" (return: %ld)\n", ft_write(1, "Hello World", 11));
    printf(" (return: %ld)\n", ft_write(1, "hmmmmmmmmmmmmmmmmmmmmmmmmmmm", 29));
    

    printf("\nft_read\n");
    ft_write(1, "Enter your age: ", 17);
    errno = 0;
    printf("(return ft: %ld) %s", ft_read(1, readBuf, 100), readBuf);
    printf("errno: %s\n", strerror(errno));
    errno = 0;
    ft_write(1, "\nEnter your age: ", 17);
    printf("(return: %ld) %s", read(1, readBuf, 100), readBuf);
    printf("errno: %s\n", strerror(errno));


    printf("\nft_strdup\n");
    char *dup = ft_strdup("Hello World");
    printf("dup: %s\n", dup);
    printf("dup len: %ld\n", ft_strlen(dup));
    free(dup);

    dup = ft_strdup("");
    printf("\ndup: %s\n", dup);
    printf("dup len: %ld\n", ft_strlen(dup));
    free(dup);

    dup = ft_strdup("0123456789");
    printf("\ndup: %s\n", dup);
    printf("dup len: %ld\n", ft_strlen(dup));
    free(dup);

    dup = ft_strdup(NULL);
    printf("\nft_strdup(NULL) -> %s\n", dup);
    return 0;
}