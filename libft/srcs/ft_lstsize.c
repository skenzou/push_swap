/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_lstsize.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: midrissi <midrissi@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/06/11 13:06:37 by midrissi          #+#    #+#             */
/*   Updated: 2019/06/11 13:09:23 by midrissi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t				ft_lstsize(t_list *list)
{
	size_t i;

	i = 0;
	while (list)
	{
		i++;
		list = list->next;
	}
	return (i);
}
