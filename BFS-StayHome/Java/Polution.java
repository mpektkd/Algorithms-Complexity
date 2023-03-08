import java.util.*;
import java.util.Collection;

public class Polution implements Solver {

    @Override
    public Set<State> solve(State initial, Set<MyPoint> Planes){
        Set<State> poluted = new HashSet<>(); 
        Queue<State> deque = new ArrayDeque<>();
        deque.add(initial);
        poluted.add(initial);
        State s;

        while(!deque.isEmpty()){

            s = deque.remove();
            for (State n : s.next()){
                if(!n.isBad()){
                    if (!poluted.contains(n)){
                        poluted.remove(n);
                        if(n.isPlane()){
                            PoluteState N = (PoluteState) n;
                            PoluteState Initial = (PoluteState) initial;
                            for(MyPoint p : Planes){
                                if((int)p.getX() != N.getCoor_x() && (int)p.getY() != N.getCoor_y()){
                                deque.add(new PoluteState((int)p.getX(),(int)p.getY(), N.gettime()+5, n, false,false));
                                poluted.add(new PoluteState( (int)p.getX(),(int)p.getY(), N.gettime()+5, n, false,false));
                                }
                            }
                        }
                        deque.add(n);
                        poluted.add(n);
                    }   
                }
                
            }
            
        }
        return poluted;

    }
}