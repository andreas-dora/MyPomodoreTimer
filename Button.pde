class Button{
  float x;
  float y;
  float r;
  String a="";
  boolean isAktive;
 // int fs; //fontsize
  color tc;
  color c;
  color c0 = backG;
  color c1 = mainC;
  color c2 = color(#FFD700);
  int stW;
  int fSelect;
  
  Button(float x_, float y_, float r_){
    x = x_;
    y = y_;
    r = r_;
    
    if(r > 21){
      stW = 3;
    } else {
      stW = 2;
    }
  }
  
  boolean mouseOver(float mx, float my){
    float d = dist(x,y, mx, my);
    if(d < r){
      return true;
    } else {
      return false;
    }
  }
  
  void update(boolean aktive_, String a_,int fSel_){
    isAktive = aktive_;
    fSelect = fSel_;
     a = a_;
 
  }

  void show(float mx, float my){
    if ((isAktive)&& (mouseOver(mx, my))){
      c = hiLite;
      tc = c1;
    } else if(isAktive){
      c = c1;
      tc = c1;
    } else {
      c = c0;
      tc = c0;
    }
    fill(c0);
    stroke(c);
    strokeWeight(stW);
    ellipse(x,y, 2*r, 2*r);
    fill(tc);
    textAlign(CENTER, CENTER);
    if(fSelect == 0){
      textFont(fText);
      text(a, x, y);
    } else {
      textFont(fZahl);
      text(a, x, y);

    }


  }

}
