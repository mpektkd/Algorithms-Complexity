import java.util.*;
import java.lang.*;

public class SwterState implements State {
    
    private static Integer N;
    private static Integer M;
    private Integer coor_x;
    private Integer coor_y;
    private Integer time;
    private SwterState previous;
    private static SwterState final_state;
    private Character path_name;
    private static Set<State> poluted;
    private Boolean sea;
    private static Set<MyPoint> seas;

    public SwterState(Integer X, Integer Y, Integer Time, SwterState Previous, Character PathName, Boolean Sea){
        coor_x = X;
        coor_y = Y;
        time = Time;
        previous = Previous;
        path_name = PathName;
        sea = Sea;
    }

    public SwterState(SwterState o){
        coor_x = o.coor_x;
        coor_y = o.coor_y;
        time = o.time;
        previous = o.previous;
        path_name = o.path_name;
        sea = o.sea;
    }

    public boolean isFinal(){
        return this.equals(final_state);

    }

    public static void initialize_rows(Integer n){N = n;}

    public static void initialize_columns(Integer m){M = m;}
    
    public static void initialize_final(SwterState F){final_state = F;}

    public static void initialize_poluted(Set<State> p){poluted = p;}

    public static void initialize_seas(Set<MyPoint> s){seas = s;}

    public Character getPathName(){return path_name;}

    public int getcoor_x(){return coor_x;}

    public int getcoor_y(){return coor_y;}

    public int gettime(){return time;}

    @Override
    public boolean isBad(){
        return poluted.contains(new PoluteState(this)) || coor_x < 0 || coor_x > N-1 || coor_y < 0 || coor_y > M-1 || sea;
    };
    

    @Override 
    public Collection<State> next(){
        Collection<State> states = new ArrayList<>();
        states.add(new SwterState(coor_x+1, coor_y, time+1,this, 'D',seas.contains(new MyPoint (coor_x+1,coor_y))));
        states.add(new SwterState(coor_x, coor_y-1, time+1,this, 'L',seas.contains(new MyPoint (coor_x,coor_y-1))));
        states.add(new SwterState(coor_x, coor_y+1, time+1,this, 'R',seas.contains(new MyPoint (coor_x,coor_y+1))));
        states.add(new SwterState(coor_x-1, coor_y, time+1,this, 'U',seas.contains(new MyPoint (coor_x-1,coor_y))));
        return states;
    }

    @Override 
    public State getPrevious(){return previous;}

    @Override 
    public boolean isPlane(){return false;}


    @Override 
    public boolean equals (Object o){
        if(this == o) return true;
        if(o== null || this.getClass() != o.getClass()) return false;
        SwterState other = (SwterState) o;
        return coor_x == other.getcoor_x() && coor_y == other.getcoor_y();
    }

    @Override
    public int hashCode(){
        return Objects.hash(coor_x, coor_y);
    }

    @Override 
    public String toString(){
        return "(coor_x = " + coor_x + ", coor_y = " + coor_y + ", path time = " + time + ")";
    }
} 