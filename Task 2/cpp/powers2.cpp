#include <iostream>
#include <vector>
#include <cmath>
#include <fstream>

using namespace std;
/*func that pops the zero-elements from the end*/
void pop(vector<int> &v){

  while(v[v.size() - 1] == 0){

    v.pop_back();

  }
}
/*function for number transformation from decimal to binary
the function returns the result inversely*/

vector<int> transform(int n){
  vector<int> v1;
  int i = -1;
  while((n / 2 != 0)||(n == 1)){

    v1.push_back(n % 2);
    i += 1;

    n = n / 2;
    }

  return v1;
}
/*function that returns the sum of the digits of a binary number*/

int sum (vector<int> v){

  int summary = 0;

  for(unsigned int i = 0; i < v.size(); i++){

    summary += v[i];
  }

  return summary;
}
/*func that print the elements of the vector*/
ostream &operator <<(ostream &out, vector<int> v){


  cout << "[";
    for(unsigned int i = 0; i < v.size() - 1; i++){

      cout << v[i] << ",";

    }
    cout << v[v.size() - 1] << "]";


  return out;
}

int main(int args, char *argv[]){
ifstream file;
file.open(argv[1]);
int reps;
file >> reps;

for(int m = 0; m < reps; m++){
  int N, K;

  file >> N;
  file >> K;


if(K == N){
   cout << "[" << K << "]" << endl;
   continue;
}

vector<int> list = transform(N);

if((K < sum(list))||(K > N)){

   cout << "[]" << endl;
  continue;

}
//if ( K >= 3)
int i, dif;

dif = K - sum(list);

for(int k = 0; k < dif; k++){


i = 1;
while(list[i] == 0) i += 1;
/* abstract 2 from the first non-zero element but the
first element of the vector and add 1 to the previous*/
list[i - 1] += 2;
list[i] -= 1;

}
pop(list);
cout << list << endl;

}
return 0;
}
