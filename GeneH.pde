class GeneH{
  int global_inno = 0;
  ArrayList<Gene> allGenes = new ArrayList<Gene>();
  
  GeneH(){
    
  }
  
  Gene exists(Node n1, Node n2){
    for(Gene g : allGenes){
      if(g.in_node.number == n1.number && g.out_node.number == n2.number){
        return g;
      }
    }
    return null;
  }
}
