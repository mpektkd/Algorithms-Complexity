import java.util.*;

public class VaccineState implements State {
    Stack<String> stack1;
    String First;
    String Last;
    Integer Length;
    boolean ContainsA;
    boolean ContainsU;
    boolean ContainsC;
    boolean ContainsG;
    String move; 
    boolean completed;
    boolean Rev;
    private final State previous;
    public VaccineState (final Stack<String> s1, final String f, String l, Integer ln, boolean a, boolean u, boolean c, boolean g, String m, boolean compl, boolean rev, final State p) {
        //System.out.println(s1);
        stack1 = s1;
        First = f;
        Last = l;
        Length = ln;
        previous = p;
        ContainsA = a;
        ContainsC = c;
        ContainsU = u;
        ContainsG = g;
        move = m;
        completed = compl;
        Rev = rev;
    }

    @Override
    public boolean isFinal() {
        return stack1.isEmpty(); 
    }
    @Override
    public boolean isBad() {
        return First == Last && Length >= 2;
    }
    
    @Override
    public State getPrevious() {
        return previous;
    }
    @Override
  public Collection<State> next() {
    Collection<State> states = new ArrayList<>();
    Stack<String> tempStack = new Stack<>();
    tempStack.addAll(stack1);
    String temp = tempStack.pop();
    Stack<String> kwstas2 = new Stack<>();
    for (String n: stack1) {
        if (n.contentEquals("A")) kwstas2.add("U");
        else if (n.contentEquals("U")) kwstas2.add("A");
        else if (n.contentEquals("G")) kwstas2.add("C");
        else if (n.contentEquals("C")) kwstas2.add("G");
    }
    
    switch (temp) {
        case "A":
        if (completed == false)
                states.add(new VaccineState(kwstas2, First, Last, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "c",true,false,this));
        if (Length == 0)             
                states.add(new VaccineState(tempStack, First, temp, Length.intValue()+1, true, ContainsU, ContainsC, ContainsG, "p",false,false,this));
        if (Length == 1)
                states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, true, ContainsU, ContainsC, ContainsG, "p",false, false,this));
        if (!ContainsA) 
                states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, true, ContainsU, ContainsC, ContainsG, "p",false,false,this));
        if (First.contentEquals("A")) 
                states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, true, ContainsU, ContainsC, ContainsG, "p",false,false,this));
        if (Length > 1 && Rev == false) 
                states.add(new VaccineState(stack1, Last, First, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "r",false,true,this));     
            break;
        case "U":
        if (completed == false)
           states.add(new VaccineState(kwstas2, First, Last, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "c",true,false,this));
        if (Length == 0)             
            states.add(new VaccineState(tempStack, First, temp, Length.intValue()+1, ContainsA, true, ContainsC, ContainsG, "p",false,false,this));
        if (Length == 1)
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, true, ContainsC, ContainsG, "p",false,false,this));
        if (!ContainsU) 
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, true, ContainsC, ContainsG, "p",false,false,this));
        if (First.contentEquals("U")) 
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, true, ContainsC, ContainsG, "p",false,false,this));
        if (Length > 1 && Rev == false) 
            states.add(new VaccineState(stack1, Last, First, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "r",false,true,this));     
        break;
        case "G":
        if (completed == false)
            states.add(new VaccineState(kwstas2, First, Last, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "c",false,false,this));
        if (Length == 0)             
            states.add(new VaccineState(tempStack, First, temp, Length.intValue()+1, ContainsA, ContainsU, ContainsC, true, "p",false,false,this));
        if (Length == 1)
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, ContainsU, ContainsC, true, "p",false,false,this));
        if (!ContainsG) 
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, ContainsU, ContainsC, true, "p",false,false,this));
        if (First.contentEquals("G")) 
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, ContainsU, ContainsC, true, "p",false,false,this));
        if (Length > 1 && Rev == false) 
            states.add(new VaccineState(stack1, Last, First, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "r",false,true,this));     
        break;
        case "C":
        if (completed == false)
            states.add(new VaccineState(kwstas2, First, Last, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "c",true,false,this));
        if (Length == 0)             
            states.add(new VaccineState(tempStack, First, temp, Length.intValue()+1, ContainsA, ContainsU, true, ContainsG, "p",false,false,this));
        if (Length == 1)
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, ContainsU, true, ContainsG, "p",false,false,this));
        if (!ContainsC) 
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, ContainsU, true, ContainsG, "p",false,false,this));
        if (First.contentEquals("C")) 
            states.add(new VaccineState(tempStack, temp, Last, Length.intValue()+1, ContainsA, ContainsU, true, ContainsG, "p",false,false,this));
        if (Length > 1 && Rev == false) 
            states.add(new VaccineState(stack1, Last, First, Length.intValue(), ContainsA, ContainsU, ContainsC, ContainsG, "r",false,true,this));     
        break;
    }
    return states;
  }
    @Override
  public String toString() {
    //StringBuilder sb = new StringBuilder("Stack 1: ");
    String kapa = new String(); 
    for (String n : stack1) {
         //sb.append(n);
         kapa += n;
     }
     /*sb.append("\n");
     sb.append(First);
     sb.append(", ").append(Last);
     sb.append(", ").append(Length);
     */
     //return kapa + " First: " + First + " Last: " + Last +"\n";
     return move;
  }
  
  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    VaccineState other = (VaccineState) o;
    return stack1.equals(other.stack1) && First.equals(other.First) && Last.equals(other.Last) && Length.equals(other.Length) && ContainsA == other.ContainsA 
        && ContainsU == other.ContainsU && ContainsG == other.ContainsG && ContainsC == other.ContainsC && completed == other.completed && Rev == other.Rev;
  }

  // Hashing: consider only the positions of the four players.
  @Override
  public int hashCode() {
    return Objects.hash(stack1, First, Last, completed);
  }
}