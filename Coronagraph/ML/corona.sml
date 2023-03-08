type vertice = int  (*define the types of data*)
type adjList = vertice list
type Graph =  ((adjList) array) ref
type node = (vertice) ref

val counter = ref 0;
val cycles2 = ref 0;
val visited = ref (Array.array(0, false));
val cycles = ref 0;
val stack = ref (nil:adjList);
val i_have_to_be_one = ref 0;
val graph = ref (Array.array(0, nil:adjList));
val cycle = ref (nil:adjList);    
val nodes = ref (Array.array(0,0));

fun erase () = 
if true then(
 counter:= 0;
 cycles2 := 0;
 
 cycles := 0;
 
 i_have_to_be_one := 0;
 
 cycle := nil;    
 nodes := Array.array(0,0)
)

else ()

fun addEdge ((a:vertice), (b:vertice), (g:Graph)) =
     if true then (Array.update(!g, a-1, (Array.sub(!g, (a-1)))@[b]); Array.update(!g, b-1, (Array.sub(!g, (b-1)))@[a]))
    else ();                   


fun push_back (data, list:(adjList)ref) = list:= data::(!list)
  
fun pop_back(list:(adjList)ref) = list:= tl(!list)

fun printList (list) = 
  let 
    val cnt2 = ref 0
    val cnt = ref list
  in
  if(list = nil) then ()
  else(
    while (!cnt2 < List.length(list)-1)do (
      print(Int.toString(hd(!cnt))^" ");
      cnt:= tl(!cnt);
      cnt2:= !cnt2+1
    );
    print(Int.toString(hd(!cnt))^"\n")
  )
  end

fun printNodes()= 
  let
     val cnt = ref 0;
  in
    
    while(!cnt < (Array.length(!nodes)-1)) do (
      print(Int.toString(Array.sub(!nodes, !cnt)) ^ " ");
      cnt := !cnt +1

    );
    print(Int.toString(Array.sub(!nodes, (Array.length(!nodes)-1))));
    print("\n")
  end;


fun find_cycle(x) = 
  let
    val list = ref (!stack);  
  in
    while(x <> hd(!list))do(
      push_back(hd(!list), cycle);
      list := tl(!list)
    );
    push_back(hd(!list), cycle);
    nodes := Array.array(List.length(!cycle), 0)  
    
  end
  
fun add_node(k:int) = if(k = ~1)then () 
  else Array.update(!nodes, k, ((Array.sub(!nodes, k))+1));
  

fun sum ()= 
  let
    val value = ref 0;
    val cnt = ref 0;
  in
    while(!cnt < Array.length(!nodes))do(
      value := !value + (Array.sub(!nodes, !cnt));
      cnt:= !cnt+1
    );
    (!value)
  end


fun exist_cycle(x, container:(adjList)ref) = 
  if (List.length(!container) = 1) then ()
  else if(hd(tl(!container)) <> x) then (if (!i_have_to_be_one <> 1) then (find_cycle(x);cycles:= !cycles+1) else cycles2:= !cycles2+1) else ()

fun initialize() = 
  let
    val cnt = ref 0;
  in
   while(!cnt < Array.length(!visited))do(
     Array.update(!visited, !cnt, false);
     cnt:= !cnt+1

   )
  end
fun set () = 
  let 
    val cnt = ref 0;
  in
    while (!cnt < List.length(!cycle))do(
      Array.update(!visited, (List.nth(!cycle, !cnt)-1), true);
      cnt := !cnt+1
    )    
 end

fun dfs2 ((graph:Graph), (current:vertice), (k:int)) = 
let
  val adj = Array.sub(!graph, current-1);
  fun dfshelp (adjlist) = 
    if(adjlist = nil) then ()
    else if(Array.sub(!visited, (hd(adjlist))-1) = false)
     then 
     (if(!cycles2 = 1) then ()
     else 
     (
       dfs2(graph, hd(adjlist), k); 
       dfshelp(tl(adjlist))
       )
     )
    else(
      
      if(!cycles2 = 1)then()
      else 
      exist_cycle(hd(adjlist), stack);
      dfshelp(tl(adjlist))
    )
in
  if true then 
  (
  
  add_node(k);
  Array.update(!visited, current-1, true); 
  push_back(current, stack);
  dfshelp(adj);
  if(!cycles2 = 1)then()
  else pop_back(stack)
  
  )
  else ()
end

fun dfs ((graph:Graph), (current:vertice), (k:int)) = 
let
  val adj = Array.sub(!graph, current-1);
  fun dfshelp (adjlist) = 
    if(adjlist = nil) then ()
    else if(Array.sub(!visited, (hd(adjlist))-1) = false)
     then 
     (
     
     
       dfs(graph, hd(adjlist), k); 
       dfshelp(tl(adjlist))
       )
     
    else(
      
      if(!cycles = 1)then ()
      else 
      exist_cycle(hd(adjlist), stack);
      dfshelp(tl(adjlist))
    )
in
  if true then 
  (
  
 Array.update(!visited, current-1, true); 
  push_back(current, stack);
  dfshelp(adj);
  if(!cycles = 1)then () else
  pop_back(stack);
  counter:= !counter + 1;
  !counter
 
  )
  else 0
end;

fun trees () = 
    let 
      val count = ref 0;
      val cnt = ref (!cycle);
    in 
     while ((!cnt <> nil)andalso(!cycles2 = 0))do(
       dfs2 (graph, hd(!cnt), !count);
       cnt := tl(!cnt);
       count:= !count+1;
       stack:= nil
     );
      (!cycles2)
    end;


fun main (n, m) = 
  (
  if(dfs(graph, 1, ~1)<>n)then print("NO CORONA\n")
  else(
  (i_have_to_be_one:= !i_have_to_be_one+1);
  
  if (!cycles = 0) then print("NO CORONA\n") 
  else(
  initialize();
  set();
  stack:= nil;
  
  
  if(trees() <> 0) then (print("NO CORONA\n");printList(!stack))
  else (print ( "CORONA " ^ Int.toString(List.length(!cycle)) ^ "\n" );
  ArrayQSort.sort Int.compare (!nodes);
  printNodes()
  )
  )
  )
  )
fun repeat2 (N, M, edges) = 
  let
     val cnt = ref M;  
     val list = ref edges;  
  in 
  (
    visited := (Array.array(N, false));
    graph := (Array.array(N, nil:adjList));
    
    while(!cnt > 0 ) do(
      
      addEdge (hd(!list), (hd(tl(!list))), graph);  
      list := tl(tl(!list));
      cnt := !cnt-1
      
    );
    main(N, M);
    erase()
  )  
  end; 

fun coronograph file =
  let
    fun readInt input =
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    val inStream = TextIO.openIn file           (*and for reading from a file i 've used the code from the site of pl1*)

    fun readInts 0 acc = rev acc      (* Replace with 'rev acc' for proper order. *)
        | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    fun fordown T = 
    let
      val N = readInt inStream
      val M = readInt inStream
      val _ = TextIO.inputLine inStream
      val edges = readInts (M*2) [] 
  in 
    if (M <> N andalso T = 1) then print("NO CORONA\n")
    else if (M <> N) then (print("NO CORONA\n"); fordown (T-1))
    else if (T = 1) then repeat2(N, M, edges)
    else if (T > 0) then (repeat2(N, M, edges); fordown(T-1)) (*a little change in the second argument.*)
    else ()
  end
    in
      fordown (readInt inStream)
    end;                               (*it needs n * 2 to because otherwise it returns only the one half of the numbers*)
