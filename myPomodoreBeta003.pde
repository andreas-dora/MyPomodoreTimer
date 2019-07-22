/*
This Software uses Audiosamples 
"snap-66", "loofa__snap-072.aiff" and "loofa__snap-073.aiff" and "BossGong2" released by Loofa under Creative Commons
https://freesound.org/people/loofa/
"gong_soft" released by vrodge under Creative Commons
https://freesound.org/people/vrodge/
"je_ring" released by cmusounddesign under Creative Commons
https://freesound.org/people/cmusounddesign/
/
*/
import processing.sound.*;
SoundFile bossGong;
SoundFile snap;
SoundFile snapPlus;
SoundFile snapMinus;
SoundFile softGong;
SoundFile ring;
Clock clock;
Table pref;
Button[] button = new Button[4];
ArcButton[] aButton = new ArcButton[9];

ArrayList<Pomo> tempPomo;
ArrayList<Todo> todo;
Timer timer;
Timer testTimer;
color teal = #008080;
color silver = #C0C0C0;
color lawnGreen = #7CFC00;
color dimGray = #696969;
color backG = #323C50;
color mainC = #E0E0E0;
color hiLite = #00CED1;
PFont f1;
PFont fett;
PFont fText;
PFont fZahl;
PFont fClock;
PFont fZeichen;
int fsZahl = 24;
int fsText = 16;
int fsZeichen = 18;
int runTime;
int work; 
String workButton; 

int klPause;
String klPauseButton;
int grPause;
String grPauseButton;
int special;
String specialButton;

//float twPause;
//float twReset;
float clockX;
float clockY;
float clockR1;
float clockR2;

int displayTime;
int offset = 8;
int buttonR = 36;
int aButtonR = 8;
boolean isRunning = false;
boolean hasBegun = false;

int pomodore = 0; 
//int abstand = 20;
int pomoR = 16;
//int smallR = 18;
float pomoWinkel;
int myPassedTime;
int tempPassedTime;
int leftOver = 0;
int timeLeft;
int passingTime;
int tempTimeLeft;
int secondsPassed;
int displayStart = 0;
int displayLeft = 0;
int displayMin;
int displaySec;
int totalPomodore;
String nfPomodore;
boolean pomodoreRunde = false;
boolean pausenRunde = false;
boolean specialRunde = false;
boolean tempTest = false;
//--------------------------------------------------------------
//--------------------------------------------------------------
public void settings(){
  size(360,640);
}

void setup(){
 // size(360, 640); //360

   pref = loadTable("pref.csv", "header");
     
  for (TableRow row : pref.rows()) {
    special = row.getInt("Alarm");
    grPause = row.getInt("GrPause");
    work = row.getInt("Pomodore");
    klPause = row.getInt("KlPause");
    totalPomodore = row.getInt("totalPomodore");
  }
  
  klPauseButton = str(klPause/60000);
  grPauseButton = str(grPause/60000);
  specialButton = str(special/60000);
  workButton = str(work/60000);
  bossGong = new SoundFile(this, "boss-gong.wav");
  snap = new SoundFile(this, "loofa__snap-066.aiff");
  snapPlus = new SoundFile(this, "loofa__snap-073.aiff");
  snapMinus = new SoundFile(this, "loofa__snap-072.aiff");
  softGong = new SoundFile(this,"gong-soft.wav");
  ring = new SoundFile(this,"je-ring.wav");
  fText = loadFont("HelveticaNeue-Bold-16.vlw");
  fClock = loadFont("HelveticaNeue-Medium-72.vlw");
  fZahl = loadFont("HelveticaNeue-Bold-24.vlw");

  fZeichen = loadFont("HelveticaNeue-CondensedBlack-20.vlw");
  clockX = width/2;
  clockY = (height - 2*offset)/3;
  clockR1 = (width - 7*offset)/2;
  clockR2 = (width - 10*offset)/2;
  
  pomoWinkel = TWO_PI /24;
  nfPomodore = nf(totalPomodore,4,0);
 
  button[0] = new Button(offset + buttonR, offset+buttonR, buttonR);
  button[1] = new Button(width -(offset+buttonR), offset+buttonR, buttonR);
  button[2] = new Button(offset + buttonR, width +aButtonR, buttonR);
  button[3] = new Button(width - offset-buttonR, width + aButtonR, buttonR);
  
  aButton[0] = new ArcButton(2*offset +2*buttonR+ aButtonR , offset+aButtonR, aButtonR, "+");
  aButton[1] = new ArcButton(width -(2*offset+2*buttonR+ aButtonR), offset+aButtonR, aButtonR, "+");
  aButton[2] = new ArcButton(2*offset + 2*buttonR + aButtonR, width +buttonR, aButtonR, "+");
  aButton[3] = new ArcButton(width - (2*offset+2*buttonR+ aButtonR), width +buttonR , aButtonR, "+");
  
  aButton[4] = new ArcButton(offset+aButtonR, 2*offset +2*buttonR+ aButtonR, aButtonR, "-");
  aButton[5] = new ArcButton(width - (offset + aButtonR), 2*offset +2*buttonR+ aButtonR, aButtonR, "-");
  aButton[6] = new ArcButton(offset+aButtonR,width -(buttonR  + offset), aButtonR, "-");
  aButton[7] = new ArcButton(width - (offset + aButtonR),width -(buttonR  + offset) , aButtonR, "-");

  aButton[8] = new ArcButton(width - (offset + aButtonR),width +(2*buttonR  + offset+24) , aButtonR, "+");

  tempPomo = new ArrayList<Pomo>();
  todo = new ArrayList<Todo>();
  
  clock = new Clock(clockX, clockY, clockR1, clockR2);
  timer = new Timer();
  testTimer = new Timer();

}

//--------------------------------------------------------------
//--------------------------------------------------------------


void draw(){
  background(backG);

  if(isRunning){
    passingTime = timer.passedT;
  }

  timeLeft = runTime - passingTime - tempPassedTime;
  myPassedTime = passingTime + tempPassedTime;


   secondsPassed = floor(myPassedTime/1000);
   displayLeft = displayStart -secondsPassed;
   displayMin = floor(displayLeft/60);
   displaySec = displayLeft%60;
   //displayMin = floor(timeLeft/60000);
   //displaySec = timeLeft%60000;


  for(int i = 0; i < button.length; i++){
    button[i].show(mouseX, mouseY);
  }
  for(int i = 0; i < aButton.length; i++){
    aButton[i].a_show(mouseX, mouseY);
    aButton[i].a_update(!hasBegun);
  }
 
    //for (int i = 4; i< 8; i++){
    //  button[i].update(!hasBegun, "+", fsZeichen);
    //}
    //for (int i = 8; i< button.length; i++){
    //  button[i].update(!hasBegun, "-", fsZeichen);
    //}

    
    if(hasBegun){
      clock.update(displayMin, displaySec);
  
      button[3].update(true, "RESET", 0);  
      if(isRunning){      
        button[2].update(true, "PAUSE", 0);
      } else {
        button[2].update(true, "WEITER", 0);
      }        
    } else {
    clock.update(hour(), minute());
      button[2].update(true, workButton, 1);
      button[3].update(true, klPauseButton, 1);  
    }
    
    button[0].update(!hasBegun, specialButton, 1);
    button[1].update(!hasBegun, grPauseButton, 1);      
    clock.show();
    for(int i = 0; i < tempPomo.size(); i++){
    Pomo tp = tempPomo.get(i);
    tp.platz(clockX, clockY, clockR2, pomoR, (0 -(pomoWinkel*tempPomo.size()-pomoWinkel))/2+pomoWinkel*i);
}
  for(Pomo tp : tempPomo){
    tp.update();
    tp.show();    
  }
  
  for(Todo td : todo){
 //   td.update();
    td.show();    
  }  
  
  stroke(mainC);
  strokeWeight(3);
  line(offset, width + 2*buttonR+offset, width-2*offset,width +2*buttonR+offset);
  
  fill(mainC);
  textFont(fZahl);
  textAlign(LEFT);
  text("To Do List", offset +buttonR, width+ 2*(buttonR+offset+12));
  
  

  
  if((timer.isFinished())&& (isRunning)){
    if(pomodoreRunde){
      pomodoreUp();
    } else if (pausenRunde){
      pauseUp();

    } else if(specialRunde){
      specialUp();
    }
  } else if ((timer.isFinished())&& (!isRunning)){
      if(tempTest){
      tempDown();
    }
  }
 
  textFont(fText);
  fill(mainC);
  textAlign(CENTER);
  text(nfPomodore , width/2, width+buttonR+fsText);  
}

void mousePressed(){

  if(button[0].mouseOver(mouseX, mouseY)){
    if(!hasBegun){
      snap.play();
      runTime = special;
      displayStart = floor(runTime /1000); 
      timer.start(runTime);
      isRunning = true;
      hasBegun = true;
      specialRunde = true;
    } 
  }  
  if(button[1].mouseOver(mouseX, mouseY)){
    if(!hasBegun){
      
      snap.play();
      runTime = grPause;
      displayStart = floor(runTime /1000); 
      timer.start(runTime);
      isRunning = true;
      hasBegun = true;
      pausenRunde = true;    
      for (int i = tempPomo.size(); i >0; i--){  
       tempPomo.remove(i-1);
       }
    } 
  }  
    


  if(button[2].mouseOver(mouseX, mouseY)){
    if(!hasBegun){
      snap.play();
      tempTest = false;
      runTime = work;
      displayStart = floor(runTime /1000); 
      timer.start(runTime);
    //  isRunning = true;
      hasBegun = true;
      pomodoreRunde = true;
    } else if ((hasBegun)&&(isRunning)){
      snapMinus.play();
      tempPassedTime = myPassedTime;
       passingTime = 0;
       tempTimeLeft = timeLeft;
       timer.start(0);
    } else if ((hasBegun)&&(!isRunning)){
      snapPlus.play();
       timer.start(tempTimeLeft);
    }
     isRunning = !isRunning;
  }  
  
  if(button[3].mouseOver(mouseX, mouseY)){
    if(!hasBegun){
      snap.play();
      runTime = klPause;
    //  isRunning = true;
      pausenRunde = true;
      displayStart = floor(runTime /1000); 
      timer.start(runTime);
            hasBegun =true;
      isRunning =true;

    } else if(hasBegun){
      snapMinus.play();

      reset();     
    }
  }
  if(aButton[0].isPositive(mouseX, mouseY)){
    special+=60000;
    snapMinus.play();    
    specialButton = str(special/60000);
  }

  if(aButton[1].isPositive(mouseX, mouseY)){
    grPause+=60000;
    snapMinus.play();    
    grPauseButton = str(grPause/60000);
  }

  if(aButton[2].isPositive(mouseX, mouseY)){
    work+=60000;
    snapMinus.play();    
    workButton = str(work/60000);
  }
 
  if(aButton[3].isPositive(mouseX, mouseY)){
    klPause+=60000;
    snapMinus.play();    
    klPauseButton = str(klPause/60000);
  }
  if(aButton[4].isPositive(mouseX, mouseY)){
    if(special > 60000){ 
      snapMinus.play();
      special-=60000;
      specialButton = str(special/60000);
    }
  }
  if(aButton[5].isPositive(mouseX, mouseY)){
    if(grPause > 60000){ 
      snapMinus.play();
      grPause-=60000;
      grPauseButton = str(grPause/60000);
    }
  }
  if(aButton[6].isPositive(mouseX, mouseY)){
    if(work > 60000){ 
      snapMinus.play();
      work-=60000;
      workButton = str(work/60000);
    }
  }
  if(aButton[7].isPositive(mouseX, mouseY)){
    if(klPause> 60000){ 
      snapMinus.play();
      klPause-=60000;
      klPauseButton = str(klPause/60000);
    }
  }
  if(aButton[8].isPositive(mouseX, mouseY)){
   addToDo();
    }  
}

void reset(){
    timer.start(0);
  
    tempPassedTime = 0;
    timeLeft = 0;
    runTime = 0;
    passingTime = 0;
    displayStart = 0;
    displayLeft = 0;
    
    isRunning = false;
    hasBegun = false;
   pomodoreRunde = false;
   pausenRunde = false;
   specialRunde = false;
 
}

void pomodoreUp(){
  softGong.play();
  totalPomodore +=1;
  reset();
      tempPomo.add(new Pomo());
      TableRow row = pref.getRow(1); 
      row.setInt("Alarm", special);
      row.setInt("GrPause", grPause);
      row.setInt("Pomodore", work);
      row.setInt("KlPause", klPause);
      row.setInt("totalPomodore", totalPomodore);
      nfPomodore = nf(totalPomodore,4,0);
      saveTable(pref, "data/pref.csv");
      tempTest= true;
      timer.start(work);
}

void pauseUp(){
  bossGong.play();
  reset();
}

void specialUp(){
  ring.play();
  reset();
}
  
void tempDown(){
 for (int i = tempPomo.size(); i >0; i--){
   tempPomo.remove(i-1);
 }        
}

void addToDo(){
  todo.add(new Todo(490 +30*todo.size(), "Constrain-Fehler beheben"));
}
