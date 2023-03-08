### Problem 2: Vaccine (Java Implementation)

Given a stack of RNA nitrogenous bases ("A", "U", "G", "C"), we consider the following possible moves that we can do, in order to create another stack in which all the nitrogenous bases of the given stack are in groups (all "A"s together, all "T"s together and so on). The moves are:

- "p" (push): removes the top base from the given stack and puts it on top of the new stack
- "c" (comlement): replaces all the bases from the given stack with their complementary ones ("A" ↔️ "U", "C" ↔️ "G")
- "r" (reverse): turns the new stack's content upside-down

The program should print the shortest (on a tie, the lexicographicaly smallest) sequence of moves that need to be done, in order the create the above mentioned stack.
