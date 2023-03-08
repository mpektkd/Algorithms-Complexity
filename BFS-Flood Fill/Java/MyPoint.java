import java.util.*;


public class MyPoint {
    
    private int X;
    private int Y;

    public MyPoint(int x, int y){
        X = x;
        Y = y;
    }

    public MyPoint(MyPoint p){
        X = p.getX();
        Y = p.getY();
    }

    public int getX(){return X;}
    
    public int getY(){return Y;}

    @Override
    public boolean equals (Object o){
        if(this == o) return true;
        if(o == null || getClass() != o.getClass()) return false;
        MyPoint other = (MyPoint) o;
        return getX() == other.getX() && getY() == other.getY();
    }

    @Override
    public int hashCode(){
        return Objects.hash(X, Y);
    }

    @Override
    public String toString(){
        return "(x = " + X + ", y = " + Y + ")" ;
    }
}