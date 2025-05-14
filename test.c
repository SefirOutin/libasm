#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <limits.h>

/*
Node addr: 0x602000000290 data addr: 0x602000000270 data: 9
Node addr: 0x602000000250 data addr: 0x602000000230 data: 1
Node addr: 0x602000000210 data addr: 0x6020000001f0 data: 2
Node addr: 0x6020000001d0 data addr: 0x6020000001b0 data: 5
Node addr: 0x602000000190 data addr: 0x602000000170 data: 9
Node addr: 0x602000000150 data addr: 0x602000000130 data: 7
Node addr: 0x602000000110 data addr: 0x6020000000f0 data: 3
Node addr: 0x6020000000d0 data addr: 0x6020000000b0 data: 9
Node addr: 0x602000000090 data addr: 0x602000000070 data: 1
*/

// bool iswspace(char c)
// {
// 	if ((c > 8 && c < 14) || c == 32)
// 		return (1);
// 	return (0);
// }

// int iofb(char *base, char c)
// {
// 	int i = 0;

// 	while (base[i])
// 		if (base[i++] == c)
// 			return (i - 1);
// 	return (-1);
// }
// // abcdef
// int checkBase(char *base)
// {
// 	int i = 0, j;

// 	while (base[i])
// 	{
// 		if (base[i] == '+' || base[i] == '-' || iswspace(base[i]))
// 			return (1);
		
// 		j = i + 1;
// 		while (base[j])
// 			if (base[i] == base[j])
// 				return (1);
// 			j++;
// 		i++;
// 	}
// 	if (i < 2)
// 		return (1);
// 	return (0);
// }
// // 0000 0000 | 0000 0000
// int atoiBase(char *str, char *base)
// {
// 	int nb = 0, i = 0, sign = 1;
// 	int baseLen = strlen(base);	

// 	if (checkBase(base))
// 		return (0);
	
// 	while (str[i] && iswspace(str[i]))
// 		i++;
// 	while (str[i] && (str[i] == '-' || str[i] == '+'))
// 		if (str[i++] == '-')
// 			sign *= -1;
// 	while (str[i] && iofb(base, str[i]) >= 0)
// 		nb = nb * baseLen + iofb(base, str[i++]);
// 	return (nb * sign);
// }

int main(int c, char **v)
{
	char str[2];
	printf("%s\n", strcpy(NULL, ""));

	// printf("res: %d\n", atoiBase(v[1], v[2]));


	return (0);
}