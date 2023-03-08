(*set an exception*)

exception set_problem;
(*function for number transformation from decimal to binary
the function returns the result inversely*)

fun transform 0 = [0]
    |transform 1 = [1]
    |transform n = n mod 2 :: transform (n div 2);


(*function that returns the sum of the digits of a binary number*)

fun sum list = List.foldr (op +) 0 list;

(*function that finds the first non-zero element
(but the first element of the list), abstract 2 from this and add 1 to the previous*)
fun set nil = raise set_problem
    |set [a] = raise set_problem
    |set (a::b::[]) = (a + 2:: b - 1 ::[])
    |set (a::b::cs) = if b <> 0 then (a + 2 :: b - 1 :: cs)
                               else (a :: set (b :: cs));

(*function that pop the last element if it is zero
(there will be ,the most, 1 zero-element at the tail end)*)
fun pop (x::[0]) = [x]
    |pop l = if hd(List.rev(l)) = 0 then hd(l) :: pop(tl(l))
            else l;

(*func main that excecutes the algorithm*)
fun main (n, k) = case n = k of
    true => [n]
    |false =>
      let
        val list = transform(n)
        (*function to make loop in order to apply the funcs "set",
         "pop" (k-sum)times to take the correct result*)
        fun loop n t f1 f2 l = if n < t then loop (n + 1) t f1 f2 (f2(f1(l))) else l
      in
        if ((k < sum(list)) orelse (k > n)) then nil
        else loop 0 (k - sum(list)) set pop list
      end;
(*print the list*)
fun printList xs = print(String.concatWith "," (map Int.toString xs));
(*function that calls the "main" as many times as reps indicates*)
fun repeat (reps, list) =
  let
    val counter = ref reps;
    val list1 = ref list;
  in
    while !counter > 0 do (
       print("[");
       printList(main(hd (!list1), hd(tl (!list1)))); (*for the printing of the list i have found two functions have helped me in site*)
       print("]\n");                                  (*:https://stackoverflow.com/questions/36799572/how-to-print-a-list*)
       list1 := tl(tl(!list1));
      counter := !counter - 1
      )
  end;

(*read file*)
fun powers2 file =
  let
    fun readInt input =
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    val inStream = TextIO.openIn file

    val n = readInt inStream
                                      (*and for reading from a file i 've used the code from the site of pl1*)
    val _ = TextIO.inputLine inStream

    fun readInts 0 acc = rev acc      (* Replace with 'rev acc' for proper order. *)
        | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
  in
      (*repeat*)(n, readInts (n * 2) []) (*a little change in the second argument.*)
  end;                               (*it needs n * 2 to because otherwise it returns only the one half of the numbers*)
