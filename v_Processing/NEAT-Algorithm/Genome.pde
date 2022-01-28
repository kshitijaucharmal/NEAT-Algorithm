class Genome{
  GeneH gh;
  int total_nodes;
  int highest_inno;
  
  ArrayList<Gene> genes = new ArrayList<Gene>();
  ArrayList<Node> nodes = new ArrayList<Node>();
  
  Genome(GeneH gh){
    this.gh = gh;
    
    // init nodes
    for(int i = 0; i < inputs; i++){
      nodes.add(new Node(total_nodes++, input_layer));
    }
    for(int i = 0; i < outputs;i++){
      nodes.add(new Node(total_nodes++, output_layer));
    }
  }
  
  boolean exists(int x){
    for(Gene g : genes){
      if(g.inno == x){
        return true;
      }
    }
    return false;
  }
  
  void connect_nodes(Node n1, Node n2){
    if(n1.layer > n2.layer){
      Node temp = n1;
      n1 = n2;
      n2 = temp;
    }
    
    Gene c = gh.exists(n1, n2);
    Gene x = new Gene(n1, n2);
    
    if (c != null){
      x.inno = c.inno;
      if(!exists(c.inno)){
        genes.add(x);
        n2.inGenes.add(x);
      }
    }
    else{
      x.inno = gh.global_inno++;
      gh.allGenes.add(x.clone());
      genes.add(x);
      n2.inGenes.add(x);
    }
  }
  
  void add_gene(){
    Node n1 = nodes.get(int(random(nodes.size())));
    Node n2 = nodes.get(int(random(nodes.size())));
    
    while(n1.layer == n2.layer){
      n1 = nodes.get(int(random(nodes.size())));
      n2 = nodes.get(int(random(nodes.size())));
    }
    
    connect_nodes(n1, n2);
  }
  
  void add_node(){
    if(genes.size() == 0) add_gene();
    
    Node n = new Node(total_nodes++, (int)random(input_layer+1, output_layer));
    Gene g = genes.get(int(random(genes.size())));
    while(!g.enabled){
      g = genes.get(int(random(genes.size())));
    }
    connect_nodes(g.in_node, n);
    connect_nodes(n, g.out_node);
    genes.get(genes.size()-1).weight = g.weight;
    genes.get(genes.size()-2).weight = 1f;
    g.enabled = false;
    nodes.add(n);
  }
  
  float[] calculate(float[] ins){
    if(ins.length != inputs) {
      println("Not correct inputs");
      return null;
    }
    
    for(int i = 0; i < inputs; i++){
      nodes.get(i).outputValue = ins[i];
    }
    
    float[] outs = new float[outputs];
    int ctr = 0;
    
    // all hidden nodes
    for(int i = inputs+outputs; i < nodes.size(); i++){
      nodes.get(i).calculate();
    }
    
    // for output nodes
    for(int i = inputs; i < inputs+outputs; i++){
      nodes.get(i).calculate();
      outs[ctr++] = nodes.get(i).outputValue;
    }
    
    // reset all nodes
    for(int i = 0; i < nodes.size(); i++){
      nodes.get(i).reset();
    }
    
    return outs;
  }
  
  Gene getGene(int inno){
    for(Gene g : genes){
      if(g.inno == inno){
        return g.clone();
      }
    }
    return null;
  }
  
  Genome crossover(Genome partner, boolean summary){
    Genome child = new Genome(this.gh);
    child.nodes.clear();
    if(total_nodes > partner.total_nodes){
      child.total_nodes = total_nodes;
      for(int i = 0; i < total_nodes; i++){
        child.nodes.add(nodes.get(i).clone());
      }
    }
    else{
      child.total_nodes = partner.total_nodes;
      for(int i = 0; i < partner.total_nodes; i++){
        child.nodes.add(partner.nodes.get(i).clone());
      }
    }
    
    for(int i = 0; i < gh.global_inno; i++){
      boolean p1 = exists(i);
      boolean p2 = partner.exists(i);

      if(p1 && p2){
        if(summary) println(i + " Exists in both parents");
        if(random(1) < 0.5) child.genes.add(getGene(i));
        else child.genes.add(partner.getGene(i));
        continue;
      }
      if(p1 && !p2){
        if(summary) println(i + " Exists in parent 1");
        child.genes.add(getGene(i));
        continue;
      }
      if(p2 && !p1){
        if(summary) println(i + " Exists in parent 2");
        child.genes.add(partner.getGene(i));
        continue;
      }
      if(summary) println(i + " Doesn't exist in either");
    }
    child.fix_connections();
    return child;
  }
  
  float measure_cd(Genome partner){
    float cd = 0; // compatibility distance
    
    int matching = 0;
    int disjoint = 0;
    int excess = 0;
    int n = 1; // fix this
    
    float wsum = 0;
    
    for(int i = 0; i < gh.global_inno; i++){
      boolean p1 = exists(i);
      boolean p2 = partner.exists(i);
      
      if(p1 && p2){
        matching ++;
        wsum += abs(getGene(i).weight - partner.getGene(i).weight);
        continue;
      }
      
      if(p1 || p2){
        disjoint ++;
        continue;
      }
    }
    if(matching == 0) matching = 1;
    cd = ((c1 * excess)/n) + ((c2 * disjoint)/n) + (c3 * wsum/matching);
    
    println(cd);
    return cd;
  }
  
  void fix_connections(){
    for(int i = 0; i < nodes.size(); i++){
      nodes.get(i).inGenes.clear();
    }
    
    for(int i = 0; i < genes.size(); i++){
      genes.get(i).in_node.inGenes.add(genes.get(i));
    }
  }
  
  void mutate(){
    if(genes.size() == 0) add_gene();
    
    if(random(1) < 0.8){
      for(int i = 0; i < genes.size(); i++){
        genes.get(i).mutateGene();
      }
    }
    
    if(random(1) < 0.08){
      add_gene();
    }
    
    if(random(1) < 0.02){
      add_node();
    }
  }
  
  String printGenome(boolean printToConsole){
    String s = "Genome\n----------------------------------------\n";
    for(Gene g : genes){
      s += g.printGene(false);
    }
    s+='\n';
    if(printToConsole) print(s);
    return s;
  }
}
