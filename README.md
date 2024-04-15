# Life_Nexys4

Conway's Game of Life is a cellular automaton devised by mathematician John Horton Conway. It's a zero-player game, meaning its evolution is determined by its initial state, requiring no further input from human players. Our game takes place on a 16 by 16 grid of cells, which can be alive or dead. Cells evolve through generations based on simple rules regarding the number of live neighbors. This setup leads to complex behaviors and patterns. 

## Rules to Life:
Any live cell with two or three live neighbors lives on to the next generation.
Any live cell with fewer than two live neighbors dies, as if by underpopulation.
Any live cell with more than three live neighbors dies, as if by overpopulation.
Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

## When alive, this is what a cell in our game will look like:
![alt text](https://github.com/AsherHoltham/Life_Nexys4/tree/main/README.md_supplements/node.jpg?raw=true)

## State Machine:

![alt text](https://github.com/AsherHoltham/Life_Nexys4/tree/main/README.md_supplements/Game_of_Life_Nexys4_State_Diagram.jpg?raw=true)