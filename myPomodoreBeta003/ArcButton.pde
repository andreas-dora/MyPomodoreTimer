class ArcButton {
  float x;
  float y;
  float r;
  String a="";
  // String b;

  boolean isAktive;
  int fs; //fontsize
  color tc;
  color topC;
  color bottomC;

  color normalC = mainC;
  color highC = hiLite;
  int stW;

  ArcButton(float x_, float y_, float r_, String a_) {
    x = x_;
    y = y_;
    r = r_;
    a = a_;
    //if (r > 21) {
    //  stW = 3;
    //} else {
    //  stW = 2;
    //}
  }

  boolean mouseOver(float mx, float my) {
    float d = dist(x, y, mx, my);
    if ((d < r)&& (isAktive)) {
      return true;
    } else {
      return false;
    }
  }

  boolean isPositive(float mx, float my) {
    float d = dist(x, y, mx, my);
    if ((d < r)&& (isAktive)) {
      return true;
    } else {
      return false;
    }
  }

  //boolean isNegative(float mx, float my) {
  //  float d = dist(x, y, mx, my);
  //  if ((d < r)&& (isAktive)) {
  //    return true;
  //  } else {
  //    return false;
  //  }
  //}

  void a_update(boolean aktive_) {
    isAktive = aktive_;
    
   
  }

  //void a_show(float mx, float my){
  //  if ((isAktive)&& (mouseOver(mx, my))){
  //    c = c2;
  //    tc = c1;
  //  } else if(isAktive){
  //    c = c1;
  //    tc = c1;
  //  } else {
  //    c = c0;
  //    tc = c0;
  //  }
  //  fill(c0);
  //  stroke(c);
  //  strokeWeight(stW);
  //  ellipse(x,y, 2*r, 2*r);
  //  fill(tc);
  //  textFont(fett, fs);
  //  textAlign(CENTER);
  //  text(a, x, y+fs/3,6);
  //}

  void a_show(float mx, float my) {
    if ((isAktive)&&(isPositive(mx, my))) {
      topC = highC;
      bottomC = normalC;
      tc = backG;
 

    } else if (isAktive) {
      topC = mainC;
    //  bottomC = normalC;
      tc = backG;
    } else {
      topC = backG;
   //   bottomC = backG;
      tc = backG;
    }
    fill(topC);
    //stroke(topC);
    //strokeWeight(stW);
    noStroke();
    ellipse(x, y, 2*r, 2*r);
    //stroke(bottomC);
    //  arc(x,y, 2*r, 2*r, 0, PI, PIE);
    fill(tc);
    textFont(fZeichen);
    textAlign(CENTER, CENTER);
    text(a, x, y-1);
  }
}
