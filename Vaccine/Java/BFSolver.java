import java.util.*;
import java.util.concurrent.TimeUnit;
public class BFSolver implements Solver {
    @Override 
    public State solve(State initial) {
        Queue<State> remaining = new ArrayDeque<>();
        Set<State> seen = new HashSet<>();
        remaining.add(initial);
        seen.add(initial);
        
        while (!remaining.isEmpty()) {
            //System.out.println(seen);
            State s = remaining.remove();
            if (s.isFinal()) return s;
            for (State n : s.next()) {
                if (!seen.contains(n)) {
                    remaining.add(n);
                    seen.add(n);
                }               
            }
        }
        return null;
    }
    private static void printSolution(State s) {
        if (s.getPrevious() != null) {
          printSolution(s.getPrevious());
        }
        System.out.print(s);
      }
}

