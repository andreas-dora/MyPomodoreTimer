class Timer{
  
  int savedTime;
  int totalTime;
  int passedT = 0;
 // int passedTime;  
  Timer(){
  }
  
  void start(int tempTotalTime){ 
    savedTime = millis();
  totalTime = tempTotalTime;
  timeLeft = totalTime;
  }
  
  boolean isFinished(){
   int passedTime = millis() - savedTime;
   passedT = 0;
    if (passedTime > totalTime) {
      return true;
    } else {
     passedT = passedTime;
//     timeLeft = totalTime - passedTime;

      return false;
    }
  }
  
}
