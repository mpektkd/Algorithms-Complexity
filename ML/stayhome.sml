(*global variables*)
val airplanes = ref (Queue.mkQueue(): (int*int) Queue.queue);
val virus = ref (Queue.mkQueue(): (int*int) Queue.queue);       
val home = ref (Queue.mkQueue(): (int*int) Queue.queue);
val swter = ref (Queue.mkQueue(): (int*int) Queue.queue);
val myMap = ref (Array2.array(0,0, ~1));
val deque = ref (Queue.mkQueue(): (int*int*int) Queue.queue);
val i_have_to_be_one = ref 0;
val N = ref 0;(*rows*)
val M = ref 0;(*columns*)
val visited = ref (Array2.array(0,0,false));
val path = ref (Array2.array(0,0, #"E"));
val rescue_path = ref (Array.array(0, #"E"));
val moves = ref ~1;

(*exception*)
exception out_of_range;

(*print the queues*)
fun printqueue2 (q:((int*int)Queue.queue)) = 
                Queue.app(fn x => print("(" ^ Int.toString(#1(x)) ^ ", " ^ Int.toString(#2(x)) ^ ")" ^ "\n")) q
                
fun printqueue3 (q:((int*int*int)Queue.queue)) = 
                Queue.app(fn x => print("(" ^ Int.toString(#1(x)) ^ ", " ^ Int.toString(#2(x))
                                          ^ ", " ^ Int.toString(#3(x))^ ")" ^ "\n")) q
(*fun polution *)

fun pollute_the_planes (ax,ay,t) = (
        i_have_to_be_one := !i_have_to_be_one + 1 ;    
        Queue.app (fn (a,b) => if (ax <> a andalso ay <> b) then( Array2.update(!myMap, a, b, (t+7));
                                        Queue.enqueue((!deque), (a,b,t+7))) else()) (!airplanes)
)


fun bfs() = 
        if Queue.isEmpty (!deque) then ()
        else 
        let 
           val (x,y,t) = Queue.dequeue(!deque);
           val (home_x, home_y) = Queue.head(!home);
        in (
          (*counter2:= !counter2 + 1;*)
          if (x < (!N)-1 andalso Array2.sub(!myMap, x+1,y) <> (~6) andalso Array2.sub(!myMap, x+1, y) > t+1 
                                        andalso Array2.sub(!visited, x+1, y) = false) 
                then(
                        Array2.update(!path, x+1, y, #"D");
                        Array2.update(!visited, x+1, y, true);
                        Queue.enqueue(!deque, (x+1,y,t+1))
                )
                else();
          if (y > 0 andalso Array2.sub(!myMap, x,y-1) <> (~6) andalso Array2.sub(!myMap, x, y-1) > t+1 
                                        andalso Array2.sub(!visited, x, y-1) = false) 
                then(
                        Array2.update(!path, x, y-1, #"L");
                        Array2.update(!visited, x, y-1, true);
                        Queue.enqueue(!deque, (x,y-1,t+1))
                )
                else();
          if (y < (!M)-1 andalso Array2.sub(!myMap, x,y+1) <> (~6) andalso Array2.sub(!myMap, x, y+1) > t+1 
                                        andalso Array2.sub(!visited, x, y+1) = false) 
                then(
                        Array2.update(!path, x, y+1, #"R");
                        Array2.update(!visited, x, y+1, true);
                        Queue.enqueue(!deque, (x,y+1,t+1))
                )
                else();     
          if (x > 0 andalso Array2.sub(!myMap, x-1,y) <> (~6) andalso Array2.sub(!myMap, x-1, y) > t+1 
                                        andalso Array2.sub(!visited, x-1, y) = false) 
                then(
                        Array2.update(!path, x-1, y, #"U");
                        Array2.update(!visited, x-1, y, true);
                        Queue.enqueue(!deque, (x-1,y,t+1))
                )
                else();
          (if(Array2.sub(!visited, home_x, home_y) = true) then ()
          else bfs()
          )
        )
        end;

fun printpath(moves) = 
let
  val counter = ref (moves-1);
in 
  while (!counter >=0) do (
        print(Char.toString(Array.sub(!rescue_path, !counter)));
        counter:= !counter-1
)
end;

(*flood fill algorithm taken from wiki*)
fun pollution () = 
        if Queue.isEmpty (!deque)then ()
        else
        let 
          val (x,y,t) = Queue.dequeue (!deque);
        in (
          if x > 0 then(
                if ((Array2.sub(!myMap, x-1, y) < 0 orelse Array2.sub(!myMap, x-1, y) > t+2) 
                                                        andalso Array2.sub(!myMap, x-1, y) <> (~6))
                        then(   if (!i_have_to_be_one) = 0 then(
                                if Array2.sub(!myMap, x-1, y) = (~2) then pollute_the_planes(x-1,y,t) else () 
                        )else();
                                Array2.update(!myMap, x-1, y, (t+2));
                                Queue.enqueue((!deque),(x-1, y, t+2))
                                
                        )
                        else ()
                )
          else ();
          if x < !N -1 then(
                if ((Array2.sub(!myMap, x+1, y) < 0 orelse Array2.sub(!myMap, x+1, y) > t+2) 
                                                andalso Array2.sub(!myMap, x+1, y) <> (~6))
                        then(   if (!i_have_to_be_one) = 0 then(
                                if Array2.sub(!myMap, x+1, y) = (~2) then pollute_the_planes(x+1,y,t) else () 
                        )else();
                                Array2.update(!myMap, x+1, y, (t+2));
                                Queue.enqueue((!deque),(x+1, y, t+2))
                        )
                        else ()
                )
          else ();
          if y > 0 then(
                if ((Array2.sub(!myMap, x, y-1) < 0 orelse Array2.sub(!myMap, x, y-1) > t+2)
                                                andalso Array2.sub(!myMap, x, y-1) <> (~6))
                        then(   if (!i_have_to_be_one) = 0 then(
                                if Array2.sub(!myMap, x, y-1) = (~2) then pollute_the_planes(x,y-1,t) else () 
                        )else();

                                Array2.update(!myMap, x, y-1, (t+2));
                                Queue.enqueue((!deque),(x, y-1, t+2))
                        )
                        else ()
                )
          else ();
          if y < !M-1 then(
                if ((Array2.sub(!myMap, x, y+1) < 0 orelse Array2.sub(!myMap, x, y+1) > t+2) 
                                                andalso Array2.sub(!myMap, x, y+1) <> (~6))
                        then(   if (!i_have_to_be_one) = 0 then(
                                if Array2.sub(!myMap, x, y+1) = (~2) then pollute_the_planes((x,y+1, t)) else () 
                        )else();
                                Array2.update(!myMap, x, y+1, (t+2));
                                Queue.enqueue((!deque),(x, y+1, t+2))
                        )
                        else ()
                )
          else ();
          (*counter := !counter + 1;*)
          pollution()
        )
        end


(*read from file*)
fun readfile (infile : string) =
let
  val ins = TextIO.openIn infile
  fun loop ins = 
    case TextIO.inputLine ins of
         SOME line => line :: loop ins
       | NONE => []
in
  loop ins before TextIO.closeIn ins
end;


fun define_columns (nil, _, _) = raise out_of_range
    |define_columns ([#"\n"], _, _) = ()
    |define_columns (h::t, i , j) =
        if(h = #"A") then (
                Array2.update(!myMap,i,j,(~2));
                Queue.enqueue(!airplanes,(i,j));
                define_columns(t,i, j+1)
        )   
        else if(h = #"W") then (
                Array2.update(!myMap,i,j,(0));
                Queue.enqueue(!virus,(i,j));
                define_columns(t,i, j+1)
        )
        else if(h = #"T") then (
                Array2.update(!myMap,i,j,(~4));
                Queue.enqueue(!home,(i,j));
                define_columns(t,i, j+1)
        )
        else if(h = #"S") then (
                Array2.update(!myMap,i,j,(~5));
                Queue.enqueue(!swter,(i,j));
                define_columns(t,i, j+1)
        )
        else if(h = #"X") then (
                Array2.update(!myMap,i,j,(~6));
                define_columns(t,i, j+1)
        )
        else(
                define_columns(t,i, j+1)
        )        


fun define_rows(nil, _) = ()
    |define_rows (h::t, i) =
        let
            val L1 = explode(h)
        in
            define_columns(L1, i, 0); define_rows(t, i+1)
        end;


fun find_the_path(ch,(x,y)) = (
        moves:= !moves+1;
        (
        if (x,y) = Queue.head(!swter) then ()
        else if (ch = #"D") then( 
                Array.update(!rescue_path, !moves, #"D");
                find_the_path(Array2.sub(!path, x-1,y), (x-1,y))        
        )
        else if (ch = #"L") then (
                Array.update(!rescue_path, !moves, #"L");
                find_the_path(Array2.sub(!path, x,y+1), (x,y+1))    
        )    
        else if (ch = #"R") then(
                Array.update(!rescue_path, !moves, #"R");
                find_the_path(Array2.sub(!path, x,y-1), (x,y-1))        
        )
        else (
                Array.update(!rescue_path, !moves, #"U");
                find_the_path(Array2.sub(!path, x+1,y), (x+1,y))        
        )
        )
)

fun main () = 
        let 
         val (a,b) = Queue.head(!virus);
         val (swter_x, swter_y) = Queue.head(!swter);
         val (home_x, home_y) = Queue.head(!home);        
        in
        path:= Array2.array(!N, !M, #"E");
        visited:= Array2.array(!N,!M,false);
         Queue.enqueue((!deque), (a,b,0));
         pollution();
         Queue.enqueue((!deque), (swter_x,swter_y,0));
         Array2.update(!visited,swter_x,swter_y,true);
         bfs();
          (if (Array2.sub(!visited, home_x, home_y) = false) then print("IMPOSSIBLE\n")
         else (rescue_path := Array.array((!N)*(!M), #"E"); 
         find_the_path(Array2.sub(!path, home_x,home_y), (home_x,home_y));
        print(Int.toString(!moves) ^ "\n");printpath(!moves);print("\n"))
         )
        end;
        

fun stayhome file = 
    let
        val list = readfile file;
    in 
         N :=  List.length list; M := size(hd list)-1; myMap := Array2.array(!N, !M, ~1);define_rows(list, 0); main()(*; printmap(0)*)
    end;
