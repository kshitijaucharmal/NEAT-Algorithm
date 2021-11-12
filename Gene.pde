class Gene{
  Node in_node, out_node;
  int inno = -1;
  float weight = random(-2, 2);
  boolean enabled = true;
  
  Gene(Node i, Node o){
    in_node = i;
    out_node = o;
  }
  
  void PrintGene(){
    println(inno + "] " + in_node.number + "(" + in_node.layer + ") -> " + 
      out_node.number + "(" + out_node.layer + ") " + weight + " " + enabled);
  }
  
  void show(){
    push();
    if(weight < 0) stroke(0, 0, 255);
    else stroke(255, 0, 0);
    if(!enabled) stroke(0, 255, 0, 100);
    strokeWeight(2 * abs(weight));
    line(in_node.pos.x, in_node.pos.y, out_node.pos.x, out_node.pos.y);
    pop();
  }
  
  String ShowGeneText(){
    String s = (inno + "] " + in_node.number + "(" + in_node.layer + ") -> " + 
      out_node.number + "(" + out_node.layer + ") " + weight + " " + enabled + "\n");
      
    return s;
  }
  
  Gene Clone(){
    Gene g = new Gene(in_node.Clone(), out_node.Clone());
    g.enabled = enabled;
    g.inno = inno;
    g.weight = weight;
    return g;
  }
}
