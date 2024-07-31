# Homework 2 - PCLP 2
# Stavar Laurentiu-Cristian - 312CC

    Work time: ~12h

    Local checker score: 95.0/120

# Task 1

    -> Implemented a simple cipher which increases every
    letter form a string by a number of steps
    -> The resulted letter will be kept in A-Z range
    ('Z' shifted 2 times is 'B')
    -> Example: ANABANANAZ -> step = 1 -> BOBCBOBOBA
    -> The C signature of the function is:
        void simple(int n, char *plain, char *enc_string, int step)
    -> This function will modify only enc_string

# Task 2

    -> Firstly, in this task we sort a vector of processes
    -> A processes is represented as a structure which contains:
                            - short pid
                            - char prio
                            - short time
    -> The sorting algorithm used has a complexity of N^2
    -> The program sorts the array by prio. In equality cases it
    will sort by time and at last by id
    -> The C signature of the function is:
        void sort_procs(struct proc *procs, int len)

    -> Secondly, the program will compute the average time for
    every process
    -> It is computed by adding the times of every process with a
    priority and then divide that sum by the number of processes
    with that priority
    -> The result will be placed in an array of avg structures
    -> This structure contains the following:
                        - short quo
                        - short remain
    -> The C signature of the function is:
        void run_procs(struct procs *procs, int len, struct avg *avg_out)

# Task 4

    -> In this task, for a given position (x,y) on a checkers 
    board, the program marks the posible moves of a piece on 
    this board
    -> The board is represented as a 8*8 matrix, x represent 
    the row and y the collum
    -> For example for x = 4; y = 4 we have the following board:
                
                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 
                0 0 0 0 1 0 0 0
                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 
                0 0 0 0 0 0 0 0

    -> After running the program, the board will be modified 
    such as only the posible moves of the piece are marked 
    with 1:

                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0
                0 0 0 1 0 1 0 0 
                0 0 0 0 0 0 0 0
                0 0 0 1 0 1 0 0
                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 
                0 0 0 0 0 0 0 0

    -> During the implementation we always check if the piece can 
    move in a certain direction, for example (0,0) can only move
    to top right position so we do not try to add a posible move
    in any other direction than that

    -> The C signature of the function is:
        void checkers(int x, int y, char table[8][8])

# Bonus

    -> In this task we do the same thing as in task 4, the only
    difference is that result is stored in an array of 2 integers
    -> The binary representation of this two integers store the
    content of the board
    -> For example if board[0] = 10240 and board[1] = 671088640,
    or in binary representation board[0] = 000000000000000000101
    00000000000 and board[1] = 00101000000000000000000000000000,
    the board will be:

                ---------------
                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0
                0 0 0 1 0 1 0 0 
                0 0 0 0 0 0 0 0
                ---------------
                0 0 0 1 0 1 0 0
                0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 
                0 0 0 0 0 0 0 0
                ---------------

    -> In the .asm file I compute how many left shifts I have to
    make, starting from 1, in order to reach the (x,y) position
    -> The formula used is num_shifts = 8 * x + y
    -> From there I compute the number of shifts for every of the
    four direction adding and subtracting 7 and 9 from the number
    of shifts
    -> Then for every direction I multiply eax with 2, using 'mul',
    for every shift I have to make
    -> If while shifting eax becomes 0 it means that the number of 
    shifts is bigger than the size of eax si I move 1 again in eax
    and put the result in board[0]
    -> If while shifting eax never becomes 0 it means that the number
    of shifts is smaller than the size of eax so i put the result in
    board[1]
    -> The C signature of the function is:
        void bonus(int x, int y, int board[2])