/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   execute_instructions.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: midrissi <midrissi@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/05/31 13:34:56 by midrissi          #+#    #+#             */
/*   Updated: 2019/06/10 12:03:14 by midrissi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	ft_swap(t_list **stack, t_list **unused, char dest)
{
	t_list *second;

	if (dest >= 0)
		write_instructions(&ft_swap, dest);
	(void)unused;
	if (!*stack || !(*stack)->next)
		return ;
	second = (*stack)->next;
	(*stack)->next = second->next;
	second->next = *stack;
	*stack = second;
}

void	ft_push(t_list **first, t_list **second, char dest)
{
	t_list *tmp;

	if (dest >= 0)
		write_instructions(&ft_push, dest);
	if (!*second)
		return ;
	tmp = *second;
	*second = (*second)->next;
	ft_lstadd(first, tmp);
}

void	ft_reverse_rotate(t_list **stack, t_list **unused, char dest)
{
	t_list *list;

	if (dest >= 0)
		write_instructions(&ft_reverse_rotate, dest);
	(void)unused;
	if (!*stack || !(*stack)->next)
		return ;
	list = *stack;
	while (list->next && list->next->next)
	{
		list = list->next;
	}
	ft_lstadd(stack, list->next);
	list->next = NULL;
}

void	ft_rotate(t_list **stack, t_list **unused, char dest)
{
	t_list *tmp;

	if (dest >= 0)
		write_instructions(&ft_rotate, dest);
	(void)unused;
	if (!*stack || !(*stack)->next)
		return ;
	tmp = *stack;
	*stack = (*stack)->next;
	tmp->next = NULL;
	ft_lstpushback(stack, tmp);
}

void		execute_instructions(t_list **stack_a, t_list **stack_b,
														t_list *instructions)
{
	t_instruction *instruction;

	while (instructions)
	{
		instruction =  (t_instruction *)instructions->content;
		if (instruction->dest == STACK_A)
			instruction->function(stack_a, stack_b, NO_WRITE);
		else if (instruction->dest == STACK_B)
			instruction->function(stack_b, stack_a, NO_WRITE);
		else
		{
			instruction->function(stack_a, stack_b, NO_WRITE);
			instruction->function(stack_b, stack_a, NO_WRITE);
		}
		instructions = instructions->next;
	}
	if (is_sorted(*stack_a) && !(*stack_b))
		ft_printf(ANSI_GREEN"OK\n"ANSI_RESET);
	else
		ft_printf(ANSI_RED"KO\n"ANSI_RESET);
}
