
Genome g;
GeneHistory gh;
int input_layer = 0;
int output_layer = 10;
PVector text_pos;

void setup(){
  //size(600, 600);
  fullScreen();
  
  text_pos = new PVector(width/2, height/2);
  
  gh = new GeneHistory(4, 2);
  g = new Genome(gh);
}

void draw(){
  background(255);
  ShowAsDiagram();
  ShowAsText();
}

void ShowAsDiagram(){
  g.show();
}

void ShowAsText(){
  push();
  fill(0, 100);
  noStroke();
  textSize(24);
  textAlign(CENTER, CENTER);
  text(g.ShowGenomeText(), text_pos.x, text_pos.y);
  pop();
}

void keyPressed(){
  if(key == 'c'){
    g.AddGene();
  }
  
  if(key == 'n'){
    g.AddNode();
  }
}

void mouseWheel(){
  text_pos.y -= 10;
}
