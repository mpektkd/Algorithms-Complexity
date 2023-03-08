#include<bits/stdc++.h>
#include<iostream>
#include <algorithm>
#include<vector>
#include <fstream>


unsigned int i_have_to_be_one = 0;
unsigned int status = 0;
std::vector<int> stack; //stack that has always vertices that haven't been explored yet completely
std::vector<int> cycle; //vector that contains the vertices that make the cycle
std::vector<bool> visited; //"bit"vector that indicates if a vertice is visited or not
std::vector<int> nodes;   //nodes vector contains the chlidren of every vertices
unsigned int indx;        // in cycle without the adjent vertices of the cycle


unsigned int sum(){  //sum all the vertices
  unsigned int k = 0;
  for(unsigned int m = 0; m < nodes.size(); ++m){
    k += nodes[m];
  }
  return k;
}
void purge1(){//initiallize the parameters again
 if(!cycle.empty())cycle.erase(cycle.begin(), cycle.end());
  if(!visited.empty())visited.erase(visited.begin(), visited.end());
   if(!nodes.empty())nodes.erase(nodes.begin(), nodes.end());
   if(!stack.empty())stack.erase(stack.begin(), stack.end());
   if(i_have_to_be_one != 0)i_have_to_be_one = 0;
   
}
void purge2(){
   if(!cycle.empty())cycle.erase(cycle.begin(), cycle.end());
   if(!visited.empty())visited.erase(visited.begin(), visited.end());
   if(!nodes.empty())nodes.erase(nodes.begin(), nodes.end());
   if(!stack.empty())stack.erase(stack.begin(), stack.end());
    if(i_have_to_be_one != 0)i_have_to_be_one = 0;
status = 0;
}

class DFSGraph {

public:
  DFSGraph (int g, int n): identity(g), plurality(n){
    adjList  = new std::vector<int>[plurality];
    }
  ~DFSGraph(){
    if(adjList != nullptr) 
   purge();
    }
  void addEdge (int a, int b){       //add edges
    adjList[a - 1].push_back(b);
    adjList[b - 1].push_back(a);
  }
  int getAdjList(unsigned int u, unsigned int i){
    return adjList[u][i];
  }
  // A utility function to do DFS of graph
  // recursively from a given vertex u.
  bool DFS_cycle(unsigned int u,  int k)
{ 
 
   visited[u] = true;
   stack.push_back(u+1);   //push the element that is been explored for that recursion
   
   for (unsigned int i=0; i<adjList[u].size(); i++){
     
       if (visited[adjList[u][i]-1] == false){   //check for visited vertices
           
         if(DFS_cycle((adjList[u][i])-1, k))return true;  //inspired from https://www.geeksforgeeks.org/depth-first-search-or-dfs-for-a-graph/
       }
       else {                                            //if the segment is true check for a cycle of three vertices at least
         if(stack.size() == 1)continue;                 //then go on because there is not a cycle
                      
         if (stack[stack.size()-2] != adjList[u][i]){  //then we have a cycle   
           if(i_have_to_be_one == 1)return true;       //if there is a cycle already then NO CORONA
           ++i_have_to_be_one;                        //it must be only one cycle per graph
           find_the_cycle(u, i);
            return true;            
            } 
            
         } 
       }
        
       if(k!=-1) ++nodes[k];                        //add child only for the vertices of the cycle
       
       stack.pop_back();                            //when a vertice is completely explored it is poped back
      
       
      return false;                                //no cycle
}

void find_the_cycle(unsigned int &u, unsigned int &i){
   
   indx = stack.size()-1;
   while(getAdjList(u, i) != stack[indx]){    //we find the vertices of the cycle
      cycle.push_back(stack[indx]);
      --indx;
    }
   cycle.push_back(stack[indx]);

}

 
void printadjList(unsigned int &k){
  std::sort(nodes.begin(), nodes.end());
  for(unsigned int i = 0; i < (k-1); ++i){
    std::cout << nodes[i] << " ";
  }
  std::cout << nodes[k-1] << std::endl;

}

void purge (){
  for (std::vector<int>::iterator it = adjList.begin(); it != adjList.end(); it++){
    if(!(*it.empty())) {
      delete *it;
    }
  }
  delete [] adjList;
}
private:
  unsigned int identity;
  unsigned int  plurality;
  std::vector<int> *adjList;
  

};



int main (int args, char *argv[]){
  std::ifstream file;
  file.open(argv[1]);
  unsigned int T, N, M, a, b;
  file >> T;

  for(unsigned int m = 0; m < T; ++m){
    
    file >> N;    
    file >> M;    

  DFSGraph virus(m, N);

  for(unsigned int j = 0; j < M; ++j){

    file >> a;
    file >> b;

    virus.addEdge(a, b);
  }

  if(M != N){
     std::cout << "NO CORONA" << std::endl;      //if edges are less than the vertices the graph is not cohesive
     purge1();                                   //then go on
     status = 0;
      continue;
    }

    for(unsigned int i = 0; i < N; ++i){

visited.push_back(false);

}
if(!(virus.DFS_cycle(0, -1))) {    //the DFS begins from a random vertice
  std::cout << "NO CORONA" << std::endl; 
    purge1();
 continue;

}

for(unsigned int m = 0; m < cycle.size(); ++m)nodes.push_back(0);


for(unsigned int m = 0; m < visited.size(); m++){
  visited[m] = false;
}


for(unsigned int m = 0; m < cycle.size(); ++m){
  visited[cycle[m]-1] = true;
}
if(!stack.empty())stack.erase(stack.begin(), stack.end());

unsigned int k = 0;

for(unsigned int l = 0; l < cycle.size(); ++l){    //we search for the trees
  if(virus.DFS_cycle(cycle[l]-1, l)){
        std::cout << "NO CORONA" << std::endl;
        status = 1;
        break;
  }
    else ++k;

   if(!stack.empty())stack.erase(stack.begin(), stack.end());
   if(!visited.empty())visited.erase(visited.begin(), visited.end());
   
}

if (status == 1){           //we check if status==-1 to return the control to outer loop                    
  purge2();
  continue;
  }           
         
if(sum() != N){
  std::cout << "NO CORONA" << std::endl;
   purge1();
  continue;
}

  std::cout << "CORONA " << k << std::endl;
  virus.printadjList(k);
    purge1();
    virus.purge();
  }

  return 0;
}

