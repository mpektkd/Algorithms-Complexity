import java.util.*;
import java.lang.*;

public class PoluteState implements State{
    private static Integer N;
    private static Integer M;
    private Integer coor_x;
    private Integer coor_y;
    private State previous;
    private Integer time;
    private Boolean sea;
    private Boolean plane;
    private static Set<MyPoint> seas;
    private static Set<MyPoint> planes;

    public boolean isPlane(){return plane;}
    
    public static void initialize_rows(Integer n){N = n;}

    public static void initialize_columns(Integer m){M = m;}
    
    public static void initialize_seas(Set<MyPoint> s){seas = s;}

    public static void initialize_planes(Set<MyPoint> pl){planes = pl;}
 
    public int getCoor_x(){return coor_x;}

    public int getCoor_y(){return coor_y;}

    public int gettime(){return time;}

    public PoluteState(SwterState s){
        coor_x = s.getcoor_x();
        coor_y = s.getcoor_y();
        previous = null;
        time = s.gettime();
        sea = null;
        plane = null;

    }

    public PoluteState(Integer x, Integer y, Integer t, State p, Boolean Sea, Boolean Plane){
        coor_x = x;
        coor_y = y;
        time = t;
        previous = p;
        sea = Sea;
        plane = Plane;
    }

    @Override
    public boolean isFinal(){
        return false;
    }

    @Override
    public boolean isBad(){
        return coor_x < 0 || coor_x > N-1 || coor_y < 0 || coor_y > M-1 || sea;
    }

    @Override
    public State getPrevious(){
        return previous;
    }
 

    @Override
    public Collection<State> next(){
        Collection<State> states = new ArrayList<>();
        states.add(new PoluteState(coor_x-1,coor_y, time+2, this, seas.contains(new MyPoint (coor_x-1,coor_y)),planes.contains(new MyPoint (coor_x-1,coor_y))));
        states.add(new PoluteState(coor_x+1,coor_y, time+2, this, seas.contains(new MyPoint (coor_x+1,coor_y)),planes.contains(new MyPoint (coor_x+1,coor_y))));
        states.add(new PoluteState(coor_x,coor_y-1, time+2, this, seas.contains(new MyPoint (coor_x,coor_y-1)),planes.contains(new MyPoint (coor_x,coor_y-1))));
        states.add(new PoluteState(coor_x,coor_y+1, time+2, this, seas.contains(new MyPoint (coor_x,coor_y+1)),planes.contains(new MyPoint (coor_x,coor_y+1))));
        return states;
    }

    @Override
    public boolean equals (Object o){
        if(this == o) return true;
        if(o == null || getClass() != o.getClass()) return false;
        PoluteState other = (PoluteState) o;
        return coor_x == other.getCoor_x() && coor_y == other.getCoor_y() && time >= other.gettime();
    }

    @Override
    public int hashCode(){
        return Objects.hash(coor_x, coor_y);
    }

    @Override 
    public String toString(){
        return "(coor_x = " + coor_x + ", coor_y = " + coor_y + ", polution time = " + time + ")";
    }
}
