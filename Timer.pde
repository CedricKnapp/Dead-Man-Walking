class Timer{
  float startTime;
  float endTime;
  int amount;
  boolean is_Done;
  
  Timer(int a){
    is_Done = false;
    startTime = millis();
    amount = a * 1000;
    endTime = startTime + amount;
  }
  
  void updateTimer(){
    if (startTime >= endTime){
      is_Done = true;
    }
    startTime = millis(); 
  }
  
  boolean getIsDone() { return is_Done; }
  
  
}