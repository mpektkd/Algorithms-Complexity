import java.util.*;

public interface Solver {
    public Set<State> solve(State initial, Set<MyPoint> Planes);
}