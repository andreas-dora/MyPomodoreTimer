class Clock{
  float x;
  float y;
  float r1;
  float r2;
  int fs =72;
  String displayA;
  String displayB;
  String displayStr;

  float runArc;

  
  Clock(float x_, float y_, float r1_, float r2_){
    x = x_;
    y = y_;
    r1 = r1_;
    r2 = r2_;
  }
  
  void update(int displayA_, int displayB_){
    runArc = (map(displayLeft,0, displayStart, TWO_PI, 0))-HALF_PI;
    displayA = nf(floor(displayA_),2,0);
    displayB = nf((displayB_),2,0);
    displayStr = displayA + ":" + displayB;  
  }
  
  void show(){
    noStroke();
    fill(mainC);
    ellipse(x,y, 2*r1, 2*r1);
    fill(255,50,10);
    arc(x,y, 2*r1, 2*r1, -HALF_PI, runArc, PIE);
    fill(backG);
    ellipse(x,y, 2*r2, 2*r2);
    fill(mainC);
    textFont(fClock);
    textAlign(CENTER);
    text(displayStr, x, y+fs/3,6);
  }
}
