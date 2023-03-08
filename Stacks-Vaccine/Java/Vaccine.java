import java.util.*;
import java.io.*;
import java.lang.String;

public class Vaccine {

    private Stack<String> kwstas; 
    public Vaccine(){
        kwstas = new Stack<>();
    }
    public static void main(String args[]) {
        
        try{
        Vaccine object = new Vaccine();
        Solver solver = new BFSolver();
        String First = "";
        String Last = "";
        Integer Length = 0;
        /*
        object.kwstas.add("G");
        object.kwstas.add("A");
        object.kwstas.add("C");
        object.kwstas.add("G");
        object.kwstas.add("C");
        object.kwstas.add("G");
        object.kwstas.add("C");
        System.out.println(object.kwstas);
        */
        
        BufferedReader reader = new BufferedReader(new FileReader(args[0]));

            int k;
            int e;
            String line = null;
            line = reader.readLine();
                e = Integer.parseInt(line);                
                while(e > 0){
            while((k = reader.read()) != -1){
                
                char ch[] = {(char) k};
                String str = new String(ch);
                if(str.contentEquals("\n")) {break;}
               // System.out.println(str);
                object.kwstas.add(str);
            }


       Stack<String> mystack = new Stack<>();
        mystack.addAll(object.kwstas);
        State initial = new VaccineState(object.kwstas, First, Last, Length, false, false, false, false, "", false,false,null);


        State result = solver.solve(initial);
        if (result == null) {
            System.out.println("No solution found.");
          } else {
            printSolution(result);
            System.out.println("");
          }
        
        e-=1;
        object.kwstas.clear();
    }
    reader.close(); 
      
    return;
        }
        catch(Exception e){
            System.out.println("Problem");
        }
    }

    private static void printSolution(State s) {
        if (s.getPrevious() != null) {
          printSolution(s.getPrevious());
        }
        System.out.print(s);
      }
}