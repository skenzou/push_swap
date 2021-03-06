/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_read_instructions.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: Mohamed <Mohamed@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/05/31 12:20:59 by Mohamed           #+#    #+#             */
/*   Updated: 2019/06/15 13:20:35 by midrissi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static const t_instruction		*get_existing_instructions(void)
{
	static const t_instruction	tab[NB_INSTRUCTIONS] = {
		{"rra", STACK_A, &ft_reverse_rotate},
		{"rrb", STACK_B, &ft_reverse_rotate},
		{"rrr", BOTH, &ft_reverse_rotate},
		{"sa", STACK_A, &ft_swap},
		{"sb", STACK_B, &ft_swap},
		{"ss", BOTH, &ft_swap},
		{"pa", STACK_A, &ft_push},
		{"pb", STACK_B, &ft_push},
		{"ra", STACK_A, &ft_rotate},
		{"rb", STACK_B, &ft_rotate},
		{"rr", BOTH, &ft_rotate},
	};

	return (tab);
}

void							ft_write_instructions(
	void (*function)(t_list **stack_a, t_list **unused, char write), char dest)
{
	int						i;
	const t_instruction		*instructions;

	i = -1;
	instructions = get_existing_instructions();
	while (++i < NB_INSTRUCTIONS)
		if (instructions[i].function == function
												&& instructions[i].dest == dest)
		{
			ft_putendl(instructions[i].op);
			return ;
		}
}

static int						add_instruction(char *input, t_list **head)
{
	int						i;
	const t_instruction		*instructions;

	i = -1;
	instructions = get_existing_instructions();
	while (++i < NB_INSTRUCTIONS)
	{
		if (ft_strequ(input, instructions[i].op))
			return (ft_add_to_list(head, (void *)&instructions[i],
			sizeof(t_instruction)));
	}
	return (0);
}

int								ft_read_instructions(t_list **head, char *file)
{
	char	*input;
	int		ret;
	int		fd;

	*head = NULL;
	ret = 1;
	input = NULL;
	fd = 0;
	if (file && (fd = open(file, O_RDONLY)) == -1)
		return (-1);
	while (ret == 1)
	{
		if ((ret = get_next_line(fd, &input, '\n')) > 0)
		{
			if ((ret = add_instruction(input, head)) == 0)
			{
				ft_putendl_fd("Error", 2);
				ret = -1;
			}
		}
		ft_strdel(&input);
	}
	ft_lstrev(head);
	fd > 0 ? close(fd) : 0;
	return (ret);
}
