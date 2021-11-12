class Genome{
  int inputs, outputs;
  ArrayList<Node> nodes = new ArrayList<Node>();
  ArrayList<Gene> genes = new ArrayList<Gene>();
  
  int total_nodes = 0;
  int highest_inno = 0;
  
  GeneHistory gh;
  
  Genome(GeneHistory gh){
    this.gh = gh;
    inputs = gh.inputs;
    outputs = gh.outputs;
    
    for(int i = 0; i < inputs; i++){
      nodes.add(new Node(total_nodes++, input_layer));
    }
    
    for(int i = 0; i < outputs; i++){
      nodes.add(new Node(total_nodes++, output_layer));
    }
  }
  
  boolean Exists(Gene x){
    for(Gene g : genes){
      if(g.inno == x.inno) return true;
    }
    return false;
  }
  
  void AddGene(){
    Node n1 = nodes.get(int(random(nodes.size())));
    Node n2 = nodes.get(int(random(nodes.size())));
    
    while(n1.layer == n2.layer){
      n1 = nodes.get(int(random(nodes.size())));
      n2 = nodes.get(int(random(nodes.size())));
    }
    
    ConnectNodes(n1, n2);
  }
  
  void AddNode(){
    if(genes.size() == 0) AddGene();
    
    Node n = new Node(total_nodes++, int(random(input_layer+1, output_layer))); // make a new node on a random layer
    Gene g = genes.get(int(random(genes.size()))); // select a random gene
    
    while(g.in_node.layer > n.layer || g.out_node.layer < n.layer){
      g = genes.get(int(random(genes.size())));
    }
    
    g.enabled = false; // disable the gene
    ConnectNodes(g.in_node, n); // connect from input to n
    ConnectNodes(n, g.out_node); // connect from n to output
    genes.get(genes.size()-1).weight = g.weight; // set same weight for n to outputs
    genes.get(genes.size()-2).weight = 1f; // set weight to 1 for input to n
    nodes.add(n); // add the node to the array
  }
  
  void ConnectNodes(Node n1, Node n2){
    // n2 always on bigger layer
    if(n1.layer > n2.layer){
      Node temp = n1;
      n1 = n2;
      n2 = temp;
    }
    
    Gene c = gh.Exists(n1, n2); // if exists or is null
    Gene x = new Gene(n1, n2); // new Gene to be added
    
    // dosent exist in history
    if(c == null){
      x.inno = gh.global_inno++;
      gh.AddGene(x.Clone());
      genes.add(x);
      n2.AddGene(x);
    }
    else{
      if(!Exists(c)){
        x.inno = c.inno;
        genes.add(x);
        n2.AddGene(x);
      }
    }
  }
  
  Genome Crossover(Genome partner){
    Genome child = new Genome(gh);
    return child;
  }
  
  void PrintGenome(){
    println("Genome\n-----------------------------------------------------");
    for(int i = 0; i < genes.size(); i++){
      genes.get(i).PrintGene();
    }
  }
  
  String ShowGenomeText(){
    String s = "Genome\n-----------------------------------------------------\n";
    for(int i = 0; i < genes.size(); i++){
      s += genes.get(i).ShowGeneText();
    }
    return s;
  }
  
  float startx = 20, endx = width-20;
  float gapx = (endx - startx)/(input_layer + output_layer);
  float gapy = 100;
  
  void show(){
    for(int i = 0; i < nodes.size(); i++){
      nodes.get(i).pos.x = gapx * nodes.get(i).layer + startx;
      if(nodes.get(i).layer == input_layer){
        nodes.get(i).pos.x = startx;
        nodes.get(i).pos.y = gapy * nodes.get(i).number + gapy;
      }
      else if(nodes.get(i).layer == output_layer){
        nodes.get(i).pos.x = width-20;
        nodes.get(i).pos.y = gapy * nodes.get(i).number + gapy;
        nodes.get(i).pos.y -= inputs * gapy;
      }
    }
    
    for(Gene g : genes){
      g.show();
    }
    
    for(Node n : nodes){
      n.show();
    }
  }
}
