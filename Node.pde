class Node{
  int number, layer;
  float sum = 0f;
  float outputValue = 0f;
  ArrayList<Gene> inGenes = new ArrayList<Gene>();
  
  // for showing
  PVector pos;
  float node_size = 30;
  
  Node(int n, int l){
    number = n;
    layer = l;
    
    pos = new PVector(width/2, height/2);
    if(layer != input_layer || layer != output_layer){
      pos.y = random(height);
    }
  }
  
  void show(){
    push();
    fill(255);
    stroke(0);
    strokeWeight(3);
    circle(pos.x, pos.y, node_size);
    fill(0);
    strokeWeight(2);
    textAlign(CENTER, CENTER);
    textSize(node_size-7);
    text(number, pos.x, pos.y);
    pop();
  }
  
  Node Clone(){
    Node n = new Node(number, layer);
    n.sum = sum;
    n.outputValue = outputValue;
    return n;
  }
  
  void AddGene(Gene g){
    inGenes.add(g);
  }
}
