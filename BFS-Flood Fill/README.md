# BFS Flood-Fill

We have to save Swtiris. Due to Covid-19 lockdown, Swtiris has meen n in University and we must help him to go home. Covid polutes the area very fast.

In a given map with NxM squares(2<=N,M<=1000) we must find if it is POSSIBLE ti save Swtiris.
Further down there are the symbols:

"S":Initial place of Swtiris
"T":Home(end)
"W":initial place of Covid
"A":airport
".":Blank(available)
"X":obstacle(sea)

Covid polute the area being moved with 1 square/2 time units, if there is not an obstacle(left,rigth,down,up). As soon as it pollutes an airport then the virus spreads to all the airports after 5 time units. Swtiris can move with 1 square/time unit(left,right,up,down)if there is not an obstacle and it is not poluted. If it is impossible to save Swtiris then print IMPOSSIBLE else if there is solution then if there more than one find the lexicographically smallest and print the number of moves and the path. For example
1)15
  DDRRRRRRRDRRRRDR
2)IMPOSSIBLE
