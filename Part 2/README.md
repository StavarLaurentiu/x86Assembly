    Work time: ~8h

# Task 2

    -> In this task, I implemented the equivalent of the command "pwd",
    after calling a series of commands "cd"
    -> Example: -> Input Matrix:
                    home
                    folder1
                    .
                    folder2
                    ..
                    folder3
                -> Output: /home/folder1/folder3
    -> The output will be placed in a string which is given as an argument
    to the function
    -> During the implementation I took every word from the vector of strings, 
    I checked if it is ".." or ".", else it is a normal word. If the ".." case
    is selected I loop in revese order in the string and replace the first "\"
    with "\0". This way I remove the last word from the path. If the "." case
    is selected I jump to the next word in order to keep the path the same. If
    the normal word case is selected I use the strcat function two times.
    First time i add "/" to the path and second time the actual word.
    -> The C signature of the function is:
        void pwd(char **directories, int n, char *output)

# Task 3

    -> In this task I implemented three function:
                1. compare_func(void *A, void *B) -> used for qsort 
                2. sort(char **words, int number_of_words, int size) 
                    -> basically call qsort function
                3. get_words(char *s, char **words, int number_of_words)
                    -> place all the words from a text(s) in an array of
                    strings using strtok function
    -> For number_of_words I call strtok function and place the returned 
    string in words[count]
    -> Then call the qsort function, in order to sort the vector firstly by the 
    length of the words and in equality case sort by strcmp
    -> Example: 
            number_of_words: 9
            string: "Ana are 27 de mere, si 32 de pere"
            After get_words: ["Ana", "are", "27", "de", "mere", "si", "32", 
                                "de", "pere"]
            After sort: ["27", "32", "de", "de", "si", "Ana", "are", "mere", 
                                "pere"]
