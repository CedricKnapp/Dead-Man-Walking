class Stats{
  //textFont(CenturyGothic-12.vlw);
  String header;
  char towerName;
  Tower towerType; 
  float rOF;
  float dmg;
  int lvl;
  int bodyCount = 0;
  
  Stats(Tower t){
    if(t instanceof Artillery){
      header = "Tower              Artillery\n\n" +
               "Rate Of Fire       " + ((Artillery)t).rOF + "\n\n" +
               "Damage             " + ((Artillery)t).dmg + "\n\n" +
               "Level              " + t.level + "\n\n";
                
    }else if(t instanceof Writer){
      header = "Tower              Writer's Tower\n\n" +
               "Rate Of Fire       " + ((Writer)t).rOF + "\n\n" +
               "Damage             " + ((Writer)t).dmg + "\n\n" +
               "Level              " + lvl + "\n\n";
                
    }else if(t instanceof Hostel){
      header = "Tower              Hostel Tower\n\n" +
               "Range              " + rOF + "\n\n" +
               "Occupants          " + ((Hostel)t).refugeesHeld  + "\n\n" +
               "Level              " + lvl + "\n\n";
                
    }else if(t instanceof Chainsaw){
      header = "Tower              Chainsaw Tower\n\n" +
               "Range              " + rOF + "\n\n" +
               "Damage             " + dmg + "\n\n" +
               "Level              " + lvl + "\n\n";
                
    }
      towerType = t;
  }
  
  void updateStats(){
    Tower t = towerType;
    bodyCount = t.killCount;
    if(t instanceof Artillery){
      header = "Tower              Artillery\n\n" +
               "Rate Of Fire       " + ((Artillery)t).rOF + "\n\n" +
               "Damage             " + ((Artillery)t).dmg + "\n\n" +
               "Level              " + t.level + "\n\n";
    }else if(t instanceof Writer){
      header = "Tower              Writer's Tower\n\n" +
               "Rate Of Fire       " + ((Writer)t).rOF + "\n\n" +
               "Damage             " + ((Writer)t).dmg + "\n\n" +
               "Level              " + lvl + "\n\n";
                
    }else if(t instanceof Hostel){
      header = "Tower              Hostel Tower\n\n" +
               "Range              " + rOF + "\n\n" +
               "Occupants          " + ((Hostel)t).refugeesHeld  + "\n\n" +
               "Level              " + lvl + "\n\n";
                
    }else if(t instanceof Chainsaw){
      header = "Tower              Chainsaw Tower\n\n" +
               "Range              " + rOF + "\n\n" +
               "Damage             " + dmg + "\n\n" +
               "Level              " + lvl + "\n\n";
                
    }
  }
  
  void displayStats(){
    if(tutorialStage >= 6){              //If not intruding with the tutorial
      if(tutorialStage == 6){
        tutorialStage++;
      }
      if(!(tutorialStage >= 8 && tutorialStage < TUTORIAL_MAX)){    //If not in the tutorial
      textFont(medFont);
      fill(255);
      text("TOWER STATS", width / 2 + 30, 530);
      rect(width/2 - 60, 533, 180, 1);
      textAlign(LEFT);
      textFont(smallFont);
      text("Body Count:      " + bodyCount, width / 2 + 60, 550);
      text(header,  width / 2 - 120, 550);
      textAlign(CENTER);
      }
    }
  }
}