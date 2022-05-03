class Gene{
  Node in_node, out_node;
  float weight;
  boolean enabled;
  int inno;
  
  Gene(Node in_node, Node out_node){
    this.in_node = in_node;
    this.out_node = out_node;
    this.weight = random(-1, 1);
    this.inno = -1;
    this.enabled = true;
  }
  
  String printGene(boolean printToConsole){
    StringBuilder sb = new StringBuilder();
    sb.append(inno + "] ");
    sb.append(in_node.number + "(" + in_node.layer + ')');
    sb.append(" -> ");
    sb.append(out_node.number + "(" + out_node.layer + ") ");
    sb.append(weight + " ");
    sb.append(enabled + " \n");
    if(printToConsole) println(sb.toString());
    return sb.toString();
  }
  
  void mutateGene(){
    if(random(1) < 0.1){
      weight = random(-1, 1);
    }
    else{
      weight += randomGaussian()/50;
      if(weight > 1) weight = 1;
      if(weight < -1) weight = -1;
    }
  }
  
  Gene clone(){
    Gene g = new Gene(in_node.clone(), out_node.clone());
    g.weight = weight;
    g.inno = inno;
    g.enabled = enabled;
    return g;
  }
}
