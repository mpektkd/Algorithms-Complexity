import java.io.*;
import javax.print.attribute.ResolutionSyntax;
import java.util.*;
import java.lang.*;

public  class Stayhome {
    private Set<MyPoint> seas = new HashSet<>(); 
    private Set<MyPoint> airplanes = new HashSet<>();
    private Queue<MyPoint> virus = new LinkedList<>();
    private Queue<MyPoint> home = new LinkedList<>();
    private Queue<MyPoint> swter = new LinkedList<>();
    private int rows;
    private int columns;


    public static void main(String args[]) throws Exception{
        try{
            Stayhome object = new Stayhome();
            object.run(args);
            MyPoint coor_virus = new MyPoint(object.virus.remove());
            MyPoint coor_swter = new MyPoint(object.swter.remove());
            MyPoint coor_home = new MyPoint(object.home.remove());
            Solver Virus = new Polution();
            State initial = new PoluteState(new Integer(coor_virus.getX()),new Integer(coor_virus.getY()), new Integer(0),
              null, new Boolean(false), new Boolean(false));
              PoluteState.initialize_rows(new Integer(object.rows));
              PoluteState.initialize_columns(new Integer(object.columns));
              PoluteState.initialize_seas(object.getSeas());
              PoluteState.initialize_planes(object.getPlanes());

            Set<State> poluted_map = Virus.solve(initial, object.airplanes);
            SwterState Final = new SwterState(new Integer(coor_home.getX()), new Integer(coor_home.getY()), new Integer(0), null, null,false);
            State Initial = new SwterState(new Integer(coor_swter.getX()), new Integer(coor_swter.getY()), new Integer(0), null, null, new Boolean(false));
            Solver swter = new Swter();
            SwterState.initialize_rows(new Integer(object.rows));
            SwterState.initialize_columns(new Integer(object.columns));
            SwterState.initialize_seas(object.getSeas());
            SwterState.initialize_poluted(poluted_map);
            SwterState.initialize_final(Final);
            Set<State> path = swter.solve(Initial, null);
            if(path == null){
                System.out.println("IMPOSSIBLE");
                return;
            }
            SwterState F = object.find_final(path,Final);
            Deque<Character> Path = new ArrayDeque<>();
            Path.addFirst(F.getPathName());
            F = (SwterState)F.getPrevious();
            while(!F.equals(Initial)){
                Path.addFirst(F.getPathName());
                F = (SwterState)F.getPrevious();
            }
            System.out.println(Path.size());
            object.print(Path);
            return;
        }
        catch(Exception e){
            System.out.println("Problem");
        }
    }

    public void print(Deque<Character> Path){
        for(Character ch : Path){
            System.out.print(ch);
        }
        System.out.println();
    }

    public SwterState find_final(Set<State> path, SwterState Final){
       
        for(State s : path){
            
            SwterState S = (SwterState) s;
            if(S.equals(Final)){
                return S;
            }
        }
        return null;
    }


    public Set<MyPoint> getSeas(){return seas;}

    public Set<MyPoint> getPlanes(){return airplanes;}

    public void run(String args [])throws IOException{
        try{BufferedReader reader =
        new BufferedReader ( new FileReader ( args[0] ) ) ;
        
        
        int c = 0;
        int r = 0;
        int k;

        while((k = reader.read()) != -1){
            char ch = (char) k;
            if (ch == '\n'){
                if (r == 0)
                    columns = c;
                r+=1;
                c = 0;
                continue;
            }
            if (ch == 'W'){
                virus.add(new MyPoint(r,c));
            }
            else if (ch == 'A'){
                airplanes.add(new MyPoint(r,c));
            }
            else if (ch == 'T'){
                home.add(new MyPoint(r,c));
            }
            else if (ch == 'S'){
                swter.add(new MyPoint(r,c));
            }
            else if (ch == 'X'){
                seas.add(new MyPoint(r,c));
            }
            c+=1;
        }
        reader.close();
        rows = r;
    }
    catch(IOException e){
        System.out.println("Error. Usage: java Stayhome inputfile");
    }
    
    }
}