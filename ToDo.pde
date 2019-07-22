class Todo{
  float x;
  float y;
  float w;
  float h;
  String inhalt;
  
  Todo(float y_, String inh_){
    x = offset;
    y = y_;
    w = width -(aButtonR + offset)*2;
    h = 26;
    inhalt = inh_;
  }
  
  void show(){
    fill(mainC);
    noStroke();
    rect(x,y,w,h);
    fill(0);
    ellipse(width-(offset+aButtonR),y,2*aButtonR,2*aButtonR);

    fill(0);
    textFont(fText);
    textAlign(LEFT,TOP);
    text(inhalt, x+offset, y+offset);
    
  }
}
