class Timer {
  int savedTime; //when timer started
  int timeLimit; //how long it should last
  
  Timer(int _timeLimit) {
    timeLimit = _timeLimit;
  }
  
  //start timer
  void start() {
    savedTime = millis();
    ready = false;
  }
  
  boolean isFinished() {
    //check how much time has passed
    int passedTime = millis() - savedTime;
    if (passedTime > timeLimit) {
      return true;
    } else {
      return false;
    }
  }
}
