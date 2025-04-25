#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <limits.h>

bool iswspace(char c)
{
	if ((c > 8 && c < 14) || c == 32)
		return (1);
	return (0);
}

int iofb(char *base, char c)
{
	int i = 0;

	while (base[i])
		if (base[i++] == c)
			return (i - 1);
	return (-1);
}
// abcdef
int checkBase(char *base)
{
	int i = 0, j;

	while (base[i])
	{
		if (base[i] == '+' || base[i] == '-' || iswspace(base[i]))
			return (1);
		
		j = i + 1;
		while (base[j])
			if (base[i] == base[j])
				return (1);
			j++;
		i++;
	}
	if (i < 2)
		return (1);
	return (0);
}

int atoiBase(char *str, char *base)
{
	int nb = 0, i = 0, sign = 1;
	int baseLen = strlen(base);	

	if (checkBase(base))
		return (0);
	
	while (str[i] && iswspace(str[i]))
		i++;
	while (str[i] && (str[i] == '-' || str[i] == '+'))
		if (str[i++] == '-')
			sign *= -1;
	while (str[i] && iofb(base, str[i]) >= 0)
		nb = nb * baseLen + iofb(base, str[i++]);
	return (nb * sign);
}

int main(int c, char **v)
{
	printf("res: %d\n", atoiBase(v[1], v[2]));
	return (0);
}