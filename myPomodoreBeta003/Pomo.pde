class Pomo{
  float x;
  float y;
  float r;
  int c;
  String index;
  float theta = 1;
  float pOffset;
  Pomo(){
  }
  void platz(float x_, float y_, float pOffset_, float r_, float theta_ ){
  x = x_;
  y = y_;
  r = r_;
  theta = theta_;
  pOffset = pOffset_ - r;
  //index = nf(index_,2,0);
  }
  
  void update(){
  }
  
  void show(){
  //   float x = width/2;
  //float y = (height - 2*offset)/3; 
  pushMatrix();
  translate(x, y);
  rotate(theta);
  
    fill(mainC);
    noStroke();
    ellipse(0,pOffset,r,r);
    popMatrix();
    //textFont(f1);
    //textAlign(CENTER);
    //text(index, x,y+8);
   // float tw = r *2/ (textWidth(index));
 // float tw = r -offset;
  //textWidth(index) = tw;
  // println("Mover: " + index + " :  " +textWidth(index) + "  /  TW: " +fs);
    
  }
}
