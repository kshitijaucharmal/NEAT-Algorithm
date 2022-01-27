
int inputs = 4;
int outputs = 3;
int input_layer = 0;
int output_layer = 10;

// compatibility variables
float c1 = 0.1f;
float c2 = 0.1f;
float c3 = 0.8f;

GeneH gh;
Genome g1;
Genome g2;

float[] ins;

void setup(){
  size(600, 600);
  println("Inputs");
  ins = new float[inputs];
  for(int i = 0; i < ins.length; i++){
    float r = random(-5, 5);
    println(i + " " + r);
    ins[i] = r;
  }
  
  gh = new GeneH();
  g1 = new Genome(gh);
  g2 = new Genome(gh);
}

void draw(){
  background(51);
}

void keyPressed(){
  if(key == 'c'){
    g1.add_gene();
    g1.printGenome(true);
  }
  if(key == 'n'){
    g1.add_node();
    g1.printGenome(true);
  }
  if(key == 'q'){
    printArray(g1.calculate(ins));
  }
  if(key == 'm'){
    g1.mutate();
    g1.printGenome(true);
  }
  
  if(key == 'C'){
    g2.add_gene();
    g2.printGenome(true);
  }
  if(key == 'N'){
    g2.add_node();
    g2.printGenome(true);
  }
  if(key == 'Q'){
    printArray(g2.calculate(ins));
  }
  if(key == 'M'){
    g2.mutate();
    g2.printGenome(true);
  }
  
  if(key == 'p'){
    Genome child = g1.crossover(g2, true);
    child.printGenome(true);
  }
  if(key == 'd'){
    g1.measure_cd(g2);
  }
}
