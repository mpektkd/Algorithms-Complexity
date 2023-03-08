import java.util.*;

public class Swter implements Solver{
    public Set<State> solve (State initial, Set<MyPoint> Planes){
        Set<State> path = new HashSet<>();
        Queue<State> deque = new ArrayDeque<>();
        deque.add(initial);
        path.add(initial);
        State s;
        while(!deque.isEmpty()){
            s = deque.remove();
            for(State n : s.next()){
                
                if(!n.isBad()){
                if (!path.contains(n)){

                    deque.add(n);
                    path.add(n);

                    if(n.isFinal()){                  
                        return path;}
                }
            }
            }
        }
        return null;
    }
}
