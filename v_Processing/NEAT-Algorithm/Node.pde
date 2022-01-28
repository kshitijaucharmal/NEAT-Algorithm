class Node{
  int number, layer;
  float sum, outputValue;
  ArrayList<Gene> inGenes = new ArrayList<Gene>();
  
  Node(int n, int l){
    number = n;
    layer = l;
  }
  
  Node clone(){
    Node n = new Node(number, layer);
    n.sum = sum;
    n.outputValue = outputValue;
    return n;
  }
  
  void calculate(){
    if(layer == input_layer){
      println("No calculations on the input layer");
      return;
    }
    
    for(Gene g : inGenes){
      if(g.enabled)
        sum += g.in_node.outputValue * g.weight;
    }
    
    outputValue = activate(sum);
  }
  
  // sigmoid activation
  float activate(float x){
    return 1 / (1 + exp(-x));
  }
  
  // reset function
  void reset(){
    sum = 0;
    outputValue = 0;
  }
}
