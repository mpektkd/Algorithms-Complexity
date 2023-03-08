createGraph(N):- functor(Graph,array,N), b_setval(x,Graph).
createVisited(N):- functor(Visited,array,N), b_setval(y,Visited).
createDeg(N):- functor(Deg,array,N), b_setval(z,Deg).
createOutputList:-
  functor(OutputList,array,1),
  setarg(1,OutputList,[]),
  b_setval(n,OutputList).
createCounter:-
  functor(Counter,array,1),
  setarg(1,Counter,0),
  b_setval(w,Counter).

createCounter2:-
  functor(Counter2,array,1),
  setarg(1,Counter2,0),
  b_setval(m,Counter2).

createCyclesCounter:-
  functor(Cycles,array,1),
  setarg(1,Cycles,0),
  b_setval(r,Cycles).

createFinal:-
  functor(Final,array,1),
  setarg(1,Final,[]),
  b_setval(f,Final).

initiateGraph(0):- !.
initiateGraph(N):-
  N > 0,
  b_getval(x,Graph),
  b_getval(y,Visited),
  b_getval(z,Deg),
  setarg(N,Graph,[]),
  setarg(N,Visited,0),
  setarg(N,Deg,0),
  Y is N-1,
  initiateGraph(Y).

addEdge(X,Y):-
  b_getval(x,Graph),
  b_getval(z,Deg),
  arg(X,Graph,List1),
  arg(X,Deg,Deg1),
  arg(Y,Deg,Deg2),
  NewDeg1 is Deg1 + 1,
  NewDeg2 is Deg2 + 1,
  setarg(X,Deg,NewDeg1),
  setarg(Y,Deg,NewDeg2),
  append([Y],List1,NewList1),
  setarg(X,Graph,NewList1),
  arg(Y,Graph,List2),
  append([X],List2,NewList2),
  setarg(Y,Graph,NewList2).

isVisited(N):-
  b_getval(y,Visited),
  arg(N,Visited,X),
  X = 1.

countNodes:-
  b_getval(w,Counter),
  arg(1,Counter,X),
  Y is X + 1,
  setarg(1,Counter,Y).

degIsOne(N):-
  b_getval(z,Deg),
  arg(N,Deg,X),
  X = 1.

changeDeg(N):-
  b_getval(z,Deg),
  arg(N,Deg,X),
  NewDeg is X - 1,
  setarg(N,Deg,NewDeg),
  b_getval(x,Graph),
  arg(N,Graph,AdjList),
  changeDeg_help(AdjList).

changeDeg_help([]).
changeDeg_help([H|T]):-
  b_getval(z,Deg),
  arg(H,Deg,X),
  NewDeg is X - 1,
  NewDeg = 1 ->
    setarg(H,Deg,NewDeg),
    changeDeg(H),
    changeDeg_help(T)
;b_getval(z,Deg),
arg(H,Deg,X),
NewDeg is X - 1,
NewDeg < 0 ->
  changeDeg_help(T)
;b_getval(z,Deg),
arg(H,Deg,X),
NewDeg is X - 1,
  setarg(H,Deg,NewDeg),
  changeDeg_help(T).

dfs(N):-
  (isVisited(N) -> !
  ;degIsOne(N) ->
  changeDeg(N),
  countNodes,
  b_getval(x,Graph),
  b_getval(y,Visited),
  setarg(N,Visited,1),
  arg(N, Graph, AdjList),
  dfs_help(AdjList)
  ;countNodes,
  b_getval(x,Graph),
  b_getval(y,Visited),
  setarg(N,Visited,1),
  arg(N, Graph, AdjList),
  dfs_help(AdjList)
  ).


dfs_help([]).
dfs_help([H|T]):-
  dfs(H),
  dfs_help(T).

isVisited2(N):-
  b_getval(y,Visited),
  arg(N,Visited,X),
  X = 0.

isInCycle(N):-
  b_getval(z,Deg),
  arg(N,Deg,Y),
  Y = 2.

countTreeNodes:-
  b_getval(m,Counter2),
  arg(1,Counter2,X),
  Y is X + 1,
  setarg(1,Counter2,Y).

countTrees(N):-
  (isVisited2(N)-> !
  ;
   countTreeNodes,
   b_getval(x,Graph),
   b_getval(y,Visited),
   setarg(N,Visited,0),
   arg(N,Graph,AdjList),
   countTrees_help(AdjList)
  ).

countTrees_help([]).
countTrees_help([H|T]):-
  (isInCycle(H) -> countTrees_help(T)
  ;countTrees(H),
  countTrees_help(T)
  ).

foundCycle(N):-
  (b_getval(z,Deg),
  arg(N,Deg,Y),
  Y = 2 ->
    b_getval(m,Counter2),
    b_getval(n,OutputList),
    setarg(1,Counter2,0),
    countTrees(N),
    arg(1,OutputList,List),
    arg(1,Counter2,Tree_Nodes),
    append([Tree_Nodes],List,NewList),
    setarg(1,OutputList,NewList),
    b_getval(r,Cycles),
    arg(1,Cycles,X),
    Z is X + 1,
    setarg(1,Cycles,Z)
  ;!
  ).

countCycles(0):-!.
countCycles(N):-
  foundCycle(N),
  Y is N-1,
  countCycles(Y).

printList([]).
printList([H|T]):-
  (T = [] -> writeln(H),printList(T)
  ;write(H),write(" "),printList(T)
  ).

getGraph :-
 b_getval(x,Graph),
 writeln(Graph).
getVisited:-
  b_getval(y,Visited),
  writeln(Visited).
getDeg:-
  b_getval(z,Deg),
  writeln(Deg).
getCounter(N):-
  b_getval(w,Counter),
  arg(1,Counter,N).

getCycles(NCycles):-
  b_getval(r,Cycles),
  arg(1,Cycles,NCycles).

getCounter2:-
  b_getval(m,Counter2),
  writeln(Counter2).

getOutputList(FinalList):-
  b_getval(n,OutputList),
  arg(1,OutputList,List),
  msort(List,FinalList).

addtoFinal(List):-
  b_getval(f,Final),
  arg(1,Final,FUCKINGLIST),
  append([List],FUCKINGLIST,NEWFUCKINGLIST),
  setarg(1,Final,NEWFUCKINGLIST).

getFinal(FUCKINGLIST):-
  b_getval(f,Final),
  arg(1,Final,FUCKINGLIST).

read_coronas(_,0):- !.
read_coronas(Stream, L):-
  (read_line(Stream, [N,M]),
  createGraph(N),createVisited(N),createDeg(N),createCounter,createCyclesCounter,createCounter2,createOutputList,initiateGraph(N),
  Z is L-1,
  read_edges(Stream,M),
  N = M,
  dfs(1),
  getCounter(ConnectedNodes),
  ConnectedNodes = N ->
  countCycles(N),
  getCycles(Cycles),
  getOutputList(List),
  addtoFinal([Cycles,List]),
  read_coronas(Stream,Z)
  ;addtoFinal("'NO CORONA'"),
  Z is L-1,
  read_coronas(Stream,Z)
  ).

read_edges(_,0):- !.
read_edges(Stream, Count):-
  read_line(Stream,[Edge1,Edge2]),
  addEdge(Edge1,Edge2),
  Z is Count-1,
  read_edges(Stream,Z).

coronograph(File, Answers) :-
     open(File, read, Stream),
     read_line(Stream, Number_of_Coronas),
     createFinal,
     read_coronas(Stream,Number_of_Coronas),
     getFinal(RevAnswers),
     reverse(RevAnswers,Answers).

read_line(Stream, L) :-
     read_line_to_codes(Stream, Line),
     atom_codes(Atom, Line),
     atomic_list_concat(Atoms, ' ', Atom),
     maplist(atom_number, Atoms, L).
