# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: midrissi <midrissi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/02/03 09:24:41 by midrissi          #+#    #+#              #
#    Updated: 2019/06/16 12:22:22 by midrissi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: all, $(NAME), clean, fclean, re

_END			=	\x1b[0m
_BOLD			=	\x1b[1m
_UNDER			=	\x1b[4m
_REV			=	\x1b[7m
_GREY			=	\x1b[30m
_RED			=	\x1b[31m
_GREEN			=	\x1b[32m
_YELLOW			=	\x1b[33m
_BLUE			=	\x1b[34m
_PURPLE			=	\x1b[35m
_CYAN			=	\x1b[36m
_WHITE			=	\x1b[37m
_IGREY			=	\x1b[40m
_IRED			=	\x1b[41m
_IGREEN			=	\x1b[42m
_IYELLOW		=	\x1b[43m
_IBLUE			=	\x1b[44m
_IPURPLE		=	\x1b[45m
_ICYAN			=	\x1b[46m
_IWHITE			=	\x1b[47m
_MAGENTA		=	\x1b[35m

MSG				= $(_BOLD)$(_BLUE)Compiling push_swap and checker and visu$(_END)
PUSH_SWAP		= push_swap
CHECKER			= checker
VISU			= visu
CC				= gcc
C_FLAGS			= -Wall -Wextra -Werror -O3
OBJ_PATH		= ./obj/
LIBFT_PATH		= libft/
LIBFT_NAME		= libft.a
LIBFT 			= $(addprefix $(LIBFT_PATH),$(LIBFT_NAME))
INC_PATH		= ./includes/
INC_NAME		= push_swap.h visu.h
INC_FPATH		= $(addprefix $(INC_PATH),$(INC_NAME))
INC				= $(addprefix -I,$(INC_PATH))
COMMON_DIR		= common/
PUSH_SWAP_DIR	= push_swap/
VISU_DIR		= visu/
CHECKER_DIR		= checker/

#MINILIBX
MLX_PATH		= ./minilibx/
MLX_NAME		= libmlx.a
MLX				= $(addprefix $(MLX_PATH),$(MLX_NAME))
MLX_LINK		= -L $(MLX_PATH) -lmlx -framework OpenGL -framework AppKit
MLX_INC			= -I $(MLX_PATH)

#SRCS
SRC_NAME		= $(COMMON_DIR)ft_arg_checker.c \
				  $(COMMON_DIR)ft_execute_instructions.c \
				  $(COMMON_DIR)ft_parse_args.c  \
				  $(COMMON_DIR)ft_read_from_file.c \
				  $(COMMON_DIR)ft_read_instructions.c \
				  $(COMMON_DIR)ft_utils.c \
				  $(COMMON_DIR)ft_utils2.c \
				  $(COMMON_DIR)ft_print_state.c \
				  							\
				  $(PUSH_SWAP_DIR)ft_find_median.c \
				  $(PUSH_SWAP_DIR)ft_launch_sort.c \
				  $(PUSH_SWAP_DIR)ft_sort_2.c \
				  $(PUSH_SWAP_DIR)ft_sort_3.c \
				  $(PUSH_SWAP_DIR)ft_sort_4.c \
				  $(PUSH_SWAP_DIR)ft_sort_5.c \
				  $(PUSH_SWAP_DIR)ft_sort_b.c \
				  $(PUSH_SWAP_DIR)ft_sort_small.c \
				  $(PUSH_SWAP_DIR)ft_sort.c \
				  $(PUSH_SWAP_DIR)ft_utils.c \
				  $(PUSH_SWAP_DIR)ft_utils2.c \
				  							\
				  $(VISU_DIR)ft_close_event.c \
				  $(VISU_DIR)ft_draw.c \
				  $(VISU_DIR)ft_generate_numbers.c \
				  $(VISU_DIR)ft_image.c \
				  $(VISU_DIR)ft_init_colors.c \
				  $(VISU_DIR)ft_init_visu.c \
				  $(VISU_DIR)ft_key_event.c \
				  $(VISU_DIR)ft_mouse_event.c \
				  $(VISU_DIR)ft_put_infos.c \
				  $(VISU_DIR)ft_refresh.c \
				  $(VISU_DIR)ft_utils.c \

SRC_PATH		= ./srcs/
SRC				= $(addprefix $(SRC_PATH),$(SRC_NAME))
OBJ_NAME		= $(SRC_NAME:.c=.o)
OBJ				= $(addprefix $(OBJ_PATH),$(OBJ_NAME))

#PUSH_SWAP
PUSH_SWAP_NAME	= $(PUSH_SWAP_DIR)push_swap.c
PUSH_SWAP_FPATH	= $(addprefix $(SRC_PATH),$(PUSH_SWAP_NAME))
PSOBJ			= $(addprefix $(OBJ_PATH)/, $(PUSH_SWAP_NAME:.c=.o))

#CHECKER
CHECKER_NAME	= $(CHECKER_DIR)checker.c
CHECKER_FPATH	= $(addprefix $(SRC_PATH),$(CHECKER_NAME))
CHECKEROBJ		= $(addprefix $(OBJ_PATH)/, $(CHECKER_NAME:.c=.o))

#VISU
VISU_NAME		= $(VISU_DIR)visu.c
VISU_FPATH		= $(addprefix $(SRC_PATH),$(VISU_NAME))
VISUOBJ			= $(addprefix $(OBJ_PATH)/, $(VISU_NAME:.c=.o))


LONGEST			?= $(shell echo $(notdir $(SRC)) | tr " " "\n" | awk ' { if (\
				length > x ) { x = length; y = $$0 } }END{ print y }' | wc -c)

all: $(MLX) $(LIBFT) $(PUSH_SWAP)

$(MLX):
	@$(MAKE) -C $(MLX_PATH)
$(LIBFT):
	@$(MAKE) -C $(LIBFT_PATH)

$(PUSH_SWAP): $(OBJ) $(PSOBJ) $(CHECKEROBJ) $(VISUOBJ)
		@$(CC) $(C_FLAGS) $(MLX_LINK) $(OBJ) $(PSOBJ) $(LIBFT) -o $@
		@printf "\r\033[K$(_BOLD)$(_RED)./$(PUSH_SWAP) is ready for use\n$(_END)"
		@$(CC) $(C_FLAGS) $(MLX_LINK) $(OBJ) $(CHECKEROBJ) $(LIBFT) -o $(CHECKER)
		@printf "$(_BOLD)$(_RED)./$(CHECKER) is ready for use\n$(_END)"
		@$(CC) $(C_FLAGS) $(LIBFT) $(MLX_LINK) $(OBJ) $(VISUOBJ)  -o $(VISU)
		@printf "$(_BOLD)$(_RED)./$(VISU) is ready for use\n$(_END)"

#PUSH_SWAP
$(PSOBJ) : $(PUSH_SWAP_FPATH) $(INC_FPATH)
		@$(CC) $(C_FLAGS) $(INC) -o $@ -c $<
		@printf "\r\033[K$(MSG) $(_BOLD)$(_CYAN)%-$(LONGEST)s\$(_END)" $(notdir $<)

#CHECKER
$(CHECKEROBJ) : $(CHECKER_FPATH) $(INC_FPATH)
		@$(CC) $(C_FLAGS) $(INC) -o $@ -c $<
		@printf "\r\033[K$(MSG) $(_BOLD)$(_CYAN)%-$(LONGEST)s\$(_END)" $(notdir $<)

#VISU
$(VISUOBJ) : $(VISU_FPATH) $(INC_FPATH)
		@$(CC) $(C_FLAGS) $(INC) $(MLX_INC) -o $@ -c $<
		@printf "\r\033[K$(MSG) $(_BOLD)$(_CYAN)%-$(LONGEST)s\$(_END)" $(notdir $<)

#SRCS
$(OBJ_PATH)%.o: $(SRC_PATH)%.c $(INC_FPATH)
		@mkdir -p $(OBJ_PATH)
		@mkdir -p $(OBJ_PATH)$(VISU_DIR)
		@mkdir -p $(OBJ_PATH)$(CHECKER_DIR)
		@mkdir -p $(OBJ_PATH)$(COMMON_DIR)
		@mkdir -p $(OBJ_PATH)$(PUSH_SWAP_DIR)
		@$(CC) $(C_FLAGS) $(INC) $(MLX_INC) -o $@ -c $<
		@printf "\r\033[K$(MSG) $(_BOLD)$(_CYAN)%-$(LONGEST)s\$(_END)" $(notdir $<)

clean: clean_obj
		@make -C $(LIBFT_PATH) clean
		@make -C $(MLX_PATH) clean

clean_obj:
		@rm -rf $(OBJ_PATH)
		@echo "$(_BOLD)$(_RED)Successfully removed all objects from ${PUSH_SWAP}\
		$(_END)"

fclean: clean_obj
		@rm -f $(PUSH_SWAP)
		@rm -f $(CHECKER)
		@rm -f $(VISU)
		@rm -f .values
		@rm -f .instructions
		@echo "$(_BOLD)$(_RED)Successfully removed ${PUSH_SWAP}, ${CHECKER} and\
 ${VISU} from ${PUSH_SWAP}$(_END)"
		@make -C $(LIBFT_PATH) fclean
		@make -C $(MLX_PATH) clean

re: fclean all
