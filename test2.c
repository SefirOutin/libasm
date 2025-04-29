#include <string.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct s_list
{
    void            *data;
    struct s_list   *next;
}                   t_list;

void printList(t_list *head)
{
	t_list *tmp = head;
	while (tmp)
	{
		printf("%s ", (char *)tmp->data);
		tmp = tmp->next;
	}
	printf("\n");
}


void ft_list_push_front(t_list **begin_list, void *data)
{
	t_list *new = malloc(sizeof(t_list));

	new->data = data;
	if (*begin_list)
		new->next = *begin_list;
	else
		new->next = NULL;
	*begin_list = new;
}

int ft_list_size(t_list *begin_list)
{
	int i = 0;
	while (begin_list)
	{
		begin_list = begin_list->next;
		i++;
	}
	return i;
}

void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
	t_list *current = *begin_list;
	t_list *previous = *begin_list;

	while (current)
	{
		if (!(*cmp)(current->data, data_ref))
		{
			(*free_fct)(current->data);
			if (current == *begin_list)
			{
				*begin_list = current->next;
				(*free_fct)(current);
				current = previous;
				continue;
			}
			else
			{
				previous->next = current->next;
				(*free_fct)(current);
				current = previous;
			}

		}
		previous = current;
		current = current->next;
	}
}

void ft_list_sort(t_list **begin_list, int (*cmp)())
{
	t_list	*tmpNode, *prevNode, *currNode;
	int		len = ft_list_size(*begin_list);

	while (len--)
	{
		currNode = prevNode = *begin_list;
		while (currNode->next)
		{
			tmpNode = currNode->next;
			if ((*cmp)(currNode->data, tmpNode->data) > 0)
			{
				currNode->next = tmpNode->next;
				tmpNode->next = currNode;
				if (currNode == *begin_list)
					*begin_list = tmpNode;
				else
					prevNode->next = tmpNode;
				prevNode = tmpNode;
				continue;
			}
			prevNode = currNode;
			currNode = currNode->next;
		}
	}
}

int main(int c, char **v)
{
	char *str;
	t_list *head = NULL;
	
	str = strdup("1");
	ft_list_push_front(&head, str);
	printf("size: %d\n", ft_list_size(head));
	str = strdup("9");
	ft_list_push_front(&head, str);
	str = strdup("3");
	ft_list_push_front(&head, str);
	str = strdup("7");
	ft_list_push_front(&head, str);
	str = strdup("9");
	ft_list_push_front(&head, str);
	str = strdup("5");
	ft_list_push_front(&head, str);
	str = strdup("2");
	ft_list_push_front(&head, str);
	str = strdup("1");
	ft_list_push_front(&head, str);
	str = strdup("9");
	ft_list_push_front(&head, str);
	printList(head);

	// ft_list_remove_if(&head, "hello", &strcmp, &free);
	ft_list_sort(&head, strcmp);
	printList(head);

}