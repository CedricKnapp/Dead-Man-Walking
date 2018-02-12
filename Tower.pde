class Tower{
  ArrayList<PImage> construct = new ArrayList<PImage>();
  float x;
  float y;
  int frame;
  int killCount = 0;
  Grid home; 
  float bHealth;
  float curHealth;
  Stats stat;
  float range;
  float dmg;
  float health;
  boolean firing;
  int level;
  boolean isCovered = false;//Used later to allow a UI button covering a tower to be clicked instead of the tower
  int numUpgrades; //The number of upgrades the tower has (value 2-4)
  TowerUI towerUI;
  boolean maxed1 = false;
  boolean maxed2 = false;
  boolean maxed3 = false;
  boolean maxed4 = false;
  
  Tower(float xP, float yP, ArrayList<PImage> p, boolean u, int n){
    x = xP;
    y = yP;
    construct = p;
    frame = 0;
    level = 0;
  }
  
  Tower(float xP, float yP, PImage p, Grid g, boolean u){
    x = xP;
    y = yP;
    ArrayList<PImage> construct = new ArrayList<PImage>();
    construct.add(p);
    frame = 0;
    home = g;
    level = 0;
  }
  
  Tower(float xP, float yP, ArrayList<PImage> p, Grid g, boolean u){
    x = xP;
    y = yP;
    construct = p;
    frame = 0;
    home = g;
    level = 0;
  }
  
  Tower(float xP, float yP, ArrayList<PImage> p, Grid g, boolean u, int n){
    numUpgrades = n;
    x = xP;
    y = yP;
    construct = p;
    frame = 0;
    home = g;
    level = 0;
  }
  
  Tower(float xP, float yP, ArrayList<PImage> p, Grid g, float r){
    x = xP;
    y = yP;
    construct = p;
    frame = 0;
    home = g;
    range = r;
    level = 0;
  }
  
  boolean clicked(){          
    if(isCovered == false){
      Tower closestTower;
      closestTower = null;
      float closestDist = 100;          //Holds a value outside of the range to compare with towers in range
      for(int i = 0; i < towersList.size(); i++){
        if(dist(mouseX, mouseY, towersList.get(i).x, towersList.get(i).y - 10) < closestDist && dist(mouseX, mouseY, towersList.get(i).x, towersList.get(i).y - 10) <= 20){  //If found tower that is inside search range
          closestDist = dist(mouseX, mouseY, towersList.get(i).x, towersList.get(i).y - 10);  //Set the closest tower to found tower
          closestTower = towersList.get(i);                                                   //Alongside the distance (so we may compare with the next search tower to see if it's less than this value)
        }
      }
      
      if(closestTower != null && !closestTower.isCovered){          //If closeest tower exists 
        if(closestTower.equals(this)){    //And the tower is this one
          clickedTower = this;            //Keep it the same
          return true;
        }
      }else{
         clickedTower = null;
      }
      
      if(clickedTower == null){
        if (numUpgrades == 2){
          boolean buttonR = dist(mouseX, mouseY, towerUI.towerButtons.get(0).x, towerUI.towerButtons.get(0).y) < towerUI.towerButtons.get(0).TOWER_BUTTON_SIZE/2;
          boolean buttonL = dist(mouseX, mouseY, towerUI.towerButtons.get(1).x, towerUI.towerButtons.get(1).y) < towerUI.towerButtons.get(1).TOWER_BUTTON_SIZE/2;
          if(buttonR){    //If the mouse is within range set to Right button
            clickedTower = this;
            return true;
          }else if(buttonL){    //If the mouse is within range set to Left button
            clickedTower = this;
            return true;
          }
        }
        else if (numUpgrades == 3){
          boolean buttonR = dist(mouseX, mouseY, towerUI.towerButtons.get(0).x, towerUI.towerButtons.get(0).y) < towerUI.towerButtons.get(0).TOWER_BUTTON_SIZE/2;
          boolean buttonL = dist(mouseX, mouseY, towerUI.towerButtons.get(1).x, towerUI.towerButtons.get(1).y) < towerUI.towerButtons.get(1).TOWER_BUTTON_SIZE/2;
          boolean buttonT = dist(mouseX, mouseY, towerUI.towerButtons.get(2).x, towerUI.towerButtons.get(2).y) < towerUI.towerButtons.get(2).TOWER_BUTTON_SIZE/2;
          if(buttonR){    //If the mouse is within range set to Right button
            clickedTower = this;
            return true;
          }else if(buttonL){    //If the mouse is within range set to Left button
            clickedTower = this;
            return true;
          }else if(buttonT){   //If the mouse is within range set to Top button
            clickedTower = this;
            return true;
          }
        }
        else if (numUpgrades == 4){
          boolean buttonR = dist(mouseX, mouseY, towerUI.towerButtons.get(0).x, towerUI.towerButtons.get(0).y) < towerUI.towerButtons.get(0).TOWER_BUTTON_SIZE/2;
          boolean buttonL = dist(mouseX, mouseY, towerUI.towerButtons.get(1).x, towerUI.towerButtons.get(1).y) < towerUI.towerButtons.get(1).TOWER_BUTTON_SIZE/2;
          boolean buttonT = dist(mouseX, mouseY, towerUI.towerButtons.get(2).x, towerUI.towerButtons.get(2).y) < towerUI.towerButtons.get(2).TOWER_BUTTON_SIZE/2;
          boolean buttonB = dist(mouseX, mouseY, towerUI.towerButtons.get(3).x, towerUI.towerButtons.get(3).y) < towerUI.towerButtons.get(3).TOWER_BUTTON_SIZE/2;
          if(buttonR){    //If the mouse is within range set to Right button
            clickedTower = this;
            return true;
          }else if(buttonL){    //If the mouse is within range set to Left button
            clickedTower = this;
            return true;
          }else if(buttonT){   //If the mouse is within range set to Top button
            clickedTower = this;
            return true;
          }else if(buttonB){   //If the mouse is within range set to Bottom button
            clickedTower = this;
            return true;
          }
        }
      }
    }
    return false;
  }
  
  void update(){
    stat.updateStats();
    for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range){
      }
    }
  }
  
  void drawTower(){
    println(construct.size());
    image(construct.get(frame), x - 15, y - 25);
    fill(255, 255, 0);
    if(frame < construct.size() - 1){
      frame++;
    }else{
      //frame++;
    }
    
    
    stroke(0, 255, 0);
    noFill();
    if(clickedTower != null){
      if(clickedTower.equals(this) && !(this instanceof Hostel)){
        strokeWeight(2);
        ellipse(x, y, range * 2, range * 2);
        noStroke();
      }
    }
    noStroke();
      
    if(gameMode == 'D'){    //If debug mode
      stroke(255, 0, 0);
      strokeWeight(2);
      if(isCovered){
        fill(0);
        textSize(7);
        text("COVERED", x, y - 30);
        fill(0, 0, 255, 50);
      }else{
        fill(0);
        textSize(7);
        text("UNCOVERED", x, y - 30);
        noFill();
      }
      ellipse(x, y - 10, 25, 25);
      noFill();
      ellipse(x + 34, y - 10, 20, 20);
      ellipse(x - 34, y - 10, 20, 20);
      stroke(0, 255, 0);
      noFill();
      strokeWeight(1);
      if(clickedTower != null){
        if(clickedTower.equals(this)){
          strokeWeight(2);
        }else{
          strokeWeight(1);
        }
      }
      ellipse(x, y, range * 2, range * 2);
      stroke(0);
      noStroke();
    }
  }
}

class Artillery extends Tower{
  float rOF = 100;
  Moveable target1 = null;
  Moveable target2 = null;
  boolean reset = false;
  boolean reset2 = false;
  boolean dualGuns = false;
  boolean molotov = false;
  boolean barrage = false;
  float barrageTime = 0;
  float barrageActiveTime = 0;
  float oldROF = rOF;
  float molotovTime = 0;
  int timeStart;
  int timeEnd, timeEnd2;
  boolean thirdUpgrade = false;
  int gunFire = 2;
  //int thickness = 3;
  int shotsFired = 0;
  ArrayList<Integer> timer = new ArrayList<Integer>();
  ArrayList<Integer> list = new ArrayList<Integer>();
  
  float getROF() { return rOF; }
  
  Artillery(float xP, float yP, ArrayList<PImage> p, Grid g, float r){
    super(xP, yP, p, g, r);
    towerUI = new TowerUI(this, numUpgrades, damageIcon, artDamageI, growIcon, artRangeI);
    stat = new Stats(this);
    towerUI.upgrade1.maxed = false;
    towerUI.upgrade2.maxed = false;
    range = 50;
    dmg = 0.5;
    reload1.play();
    reload2.play();
    reload3.play();
    curStats = stat;
    super.numUpgrades = 2; //Number of upgrades the tower has (value 2-4)
    if(thirdUpgrade){
      towerUI = new TowerUI(this, numUpgrades, damageIcon, artDamageI, growIcon, artRangeI, gunsIcon, artDualGuns);
    }
    stat.updateStats();
  }
  
  SoundFile chooseShot(){
    int i = (int)random(0, 3);
    if(i == 0){
      return shot1;
    }else if(i == 1){
      return shot2;
    }else{
      return shot3;
    }
  }
  
  int findZombieInRange(){
    for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range && zombies.get(i).getHealth() >= 0){
            boolean isIn = false;
            for(int j = 0; j < list.size(); j++){
              if(list.get(j) == i){
                isIn = true;
              }
            }
            if(isIn == false){
              list.add(i);
              return i;
            }
      }
    }
    return -1;
  }
  
  void update(){
    if(barrage){
        if(millis() >= barrageTime){
          barrageActiveTime = millis() + 6000;
          oldROF = rOF;
          rOF = 10;
          barrageTime = millis() + 30000;
        }
        if(millis() >= barrageActiveTime){
          rOF = oldROF;
        }
      }
    for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range && zombies.get(i).getHealth() >= 0 && target1 == null){    //Attack one zombie
        if(!zombies.get(i).equals(target2)){
          if(zombies.get(i) instanceof Refugee  || zombies.get(i) instanceof Reinforcement){
            if(zombies.get(i) instanceof Refugee){
              if(((Refugee)zombies.get(i)).marked == false){        //If the refugees are not marked
                 if(reset == false){
                   if(molotov && millis() >= molotovTime){
                     grenades.add(new Grenade(x, y, zombies.get(i).getX() + (12/Grenade.ANIMATION_SPEED)*zombies.get(i).getXVelo()*frameRate, zombies.get(i).getY()));
                     molotovTime = millis() + random(5000, 6000);
                   }
                  shoot(i);
                  target1 = zombies.get(i);
                  timeEnd = millis() + (int)rOF;
                  reset = true;
                 }
              }
            }
          }else{
            if(reset == false){
              if(molotov && millis() >= molotovTime){
                     grenades.add(new Grenade(x, y, zombies.get(i).getX() + (12/Grenade.ANIMATION_SPEED)*zombies.get(i).getXVelo()*frameRate, zombies.get(i).getY()));
                     molotovTime = millis() + random(5000, 6000);
                   }
               shoot(i);
               target1 = zombies.get(i);
               timeEnd = millis() + (int)rOF;
               reset = true;
            }
          }
        }
      }
    }
    if(dualGuns){
      for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range && zombies.get(i).getHealth() >= 0 && target2 == null){    //Attack one zombie
        if(!zombies.get(i).equals(target1)){
          if(zombies.get(i) instanceof Refugee  || zombies.get(i) instanceof Reinforcement){
            if(zombies.get(i) instanceof Refugee){
              if(((Refugee)zombies.get(i)).marked == false){        //If the refugees are not marked
                 if(reset2 == false){
                  shoot(i);
                  target2 = zombies.get(i);
                  timeEnd2 = millis() + (int)rOF;
                  reset2 = true;
                 }
              }
            }
          }else{
            if(reset2 == false){
               shoot(i);
               target2 = zombies.get(i);
               timeEnd2 = millis() + (int)rOF;
               reset2 = true;
            }
          }
      }
      }
    }
    }
    if(reset){
      if(millis() >= timeEnd){
        reset = false;
        target1 = null;
      }
    }
    if(reset2){
      if(millis() >= timeEnd2){
        reset2 = false;
        target2 = null;
      }
    }
  }
  
  
  void shoot(int i){
      zombies.get(i).setHealth(zombies.get(i).getHealth() - dmg);
      if(millis() <= barrageActiveTime){
        zombies.get(i).setX(zombies.get(i).getX() - random(2.5, 6));
      }
      if(zombies.get(i).getHealth() < 0){
        killCount++;
        stat.updateStats();
      }
      stroke(255, 255, 50);
      strokeWeight((int)random(1, 3));
      int chance = (int)random(0, 2);
      chooseShot().play();
      if(view == 0){
      if(chance == 0){  //If in the right view
        line(zombies.get(i).getX() + 7 + random(-2, 3), zombies.get(i).getY() + 5 + random(-3, 7), x - 9, y + 4);
        }else{
          line(zombies.get(i).getX() + 7 + random(-2, 3), zombies.get(i).getY() + 5 + random(-3, 7), x + 9, y + 3);
        }
      }
      noStroke();
    }
}

class Chainsaw extends Tower{
  float rOF = 30;
  float oldROF = rOF;
  Moveable target1 = null;
  Moveable target2 = null;
  Moveable target3 = null;
  boolean reset = false;
  boolean reset2 = false;
  boolean reset3 = false;
  boolean freeze = true;
  int splashDam = 50;
  boolean twoSaws = false;
  boolean threeSaws = false;
  boolean workingChainsaw = false;
  boolean hail = false;
  float hailTime = 0;
  float hailActiveTime = 0;
  int timeStart;
  int timeEnd, timeEnd2, timeEnd3;
  
  Chainsaw(float xP, float yP, ArrayList<PImage> p, Grid g){
    super(xP, yP, p, g, true, 4);
    towerUI = new TowerUI(this, numUpgrades, lessTimeIcon, facCooldownI, damageIcon, facDamageI, growIcon, facRangeI, doubleIcon, facSawsII);
    stat = new Stats(this);
    towerUI.upgrade1.maxed = false;
    towerUI.upgrade2.maxed = false;
    towerUI.upgrade3.maxed = false;
    towerUI.upgrade4.maxed = false;
    range = 120;
    dmg = 7;
    rOF = 1000;    //fire every second
    curStats = stat;
    chainsawRev.play();
    stat.updateStats();
  }
  
  void update(){
    if(hail){
        if(millis() >= hailTime){
          hailActiveTime = millis() + 6000;
          oldROF = rOF;
          rOF = random(50, 100);
          hailTime = millis() + 60000;
        }
        if(millis() < hailActiveTime){
          rOF = random(50, 100);
        }
        if(millis() >= hailActiveTime){
          rOF = oldROF;
        }
      }
    for(int k = 0; k < sawBlades.size(); k++){            //Search through every existing saw
      if(sawBlades.get(k).reached == true){               //If the saw reached it's destination
        for(int j = 0; j < zombies.size(); j++){     //Go through every zombie
          float zomBulDist = dist(sawBlades.get(k).destX, sawBlades.get(k).destY, zombies.get(j).getX(), zombies.get(j).getY());
          if(zomBulDist <= splashDam){            //If a zombie is within the splash damage radius (15 pixels)
            if(freeze){
              int ran = (int) random(0, 40);
              if(ran == 0){
                FreezeBottle temp = new FreezeBottle(sawBlades.get(k).destX, sawBlades.get(k).destY, true);
                potions.add(temp);
              }
            }
            if(zomBulDist < (splashDam / 3) || zombies.get(j).getFrozen()){     //If a zombie is within the a third of the splash damage radius (within 5 pixels of the targeted zombie) 
              zombies.get(j).setHealth(zombies.get(j).getHealth() - dmg);  
              if(zombies.get(j).getHealth() < 0){
                killCount++;
                stat.updateStats();
              }//Apply the full amount of damage to those specific zombies
            }else{                                                                                                                                                        //If the zombies are outside the core radius but stand on the outer edge of the damage circle (within 5 - 15 pixels of the targete zombie and NOT within 5 pixels)
              zombies.get(j).setHealth(zombies.get(j).getHealth() - (dmg*(1/3)));  //Give those zombies a lesser amount of damage inflicted upon them
              if(zombies.get(j).getHealth() < 0){
                killCount++;
                stat.updateStats();
              }//Apply the full amount of damage to those specific zombies            
            }
            if(zomBulDist<splashDam){
              int[] temp2 = {(int)random(140, 240), (int)random(0, 0), (int)random(0, 0)};
              for(int f = 0; f <= 10; f++){
                Particle temp4 = new Particle(zombies.get(j).getX(), zombies.get(j).getY(), random(1, 2), temp2);
                particles.add(temp4);
              }
            }
            if(workingChainsaw){
              sparks.play();
              stuck.add(new StuckSaw(sawBlades.get(k).destX, sawBlades.get(k).destY, this));
            }
          }
        }
        chainsawRel.play();        //Play chainsaw reload sound
        sawBlades.remove(sawBlades.get(k));  //Remove that intance of the saw
      }
    }
    for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range && zombies.get(i).getHealth() >= 0 && target1 == null){
         if(reset == false&& !(zombies.get(i).equals(target2)) && !(zombies.get(i).equals(target3))){
           if(zombies.get(i) instanceof Refugee){
            if(((Refugee)zombies.get(i)).marked == false){
              shoot(i);
              target1 = zombies.get(i);
              timeEnd = millis() + (int)rOF;
              reset = true;
            }
           }else{
             shoot(i);
             target1 = zombies.get(i);
             timeEnd = millis() + (int)rOF;
             reset = true;
           }
         }
      }
    }
    if(twoSaws == true){
        for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range && zombies.get(i).getHealth() >= 0 && target2 == null){
         if(reset2 == false && !(zombies.get(i).equals(target1)) && !(zombies.get(i).equals(target3))){
           if(zombies.get(i) instanceof Refugee){
            if(((Refugee)zombies.get(i)).marked == false){
              shoot(i);
              target2 = zombies.get(i);
              timeEnd2 = millis() + (int)rOF;
              reset2 = true;
            }
           }else{
             shoot(i);
             target2 = zombies.get(i);
             timeEnd2 = millis() + (int)rOF;
             reset2 = true;
           }
         }
      }
    }
    }
    if(threeSaws == true){
        for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range && zombies.get(i).getHealth() >= 0 && target3 == null){
         if(reset3 == false && !(zombies.get(i).equals(target1)) && !(zombies.get(i).equals(target2))){
           if(zombies.get(i) instanceof Refugee){
            if(((Refugee)zombies.get(i)).marked == false){
              shoot(i);
              target3 = zombies.get(i);
              timeEnd3 = millis() + (int)rOF;
              reset3 = true;
            }
           }else{
             shoot(i);
             target3 = zombies.get(i);
             timeEnd3 = millis() + (int)rOF;
             reset3 = true;
           }
         }
      }
    }
    }
    
    if(reset){
      if(millis() >= timeEnd){
        reset = false;
        target1 = null;
      }
    }
    if(reset2){
      if(millis() >= timeEnd2){
        reset2 = false;
        target2 = null;
      }
    }
    if(reset3){
      if(millis() >= timeEnd3){
        reset3 = false;
        target3 = null;
      }
    }
  }
  
  void shoot(int i){
    sawBlades.add(new SawBlade(x, y, zombies.get(i).getX() + (12/SawBlade.ANIMATION_SPEED)*zombies.get(i).getXVelo()*frameRate, zombies.get(i).getY()));
    chainsawRev2.play();
  }
}

class Hostel extends Tower{
  float rOF = 30;
  boolean reset = false;
  int timeStart;
  int timeEnd;
  int thickness = 3;
  int capacity = 3;
  int refugeesHeld;
  boolean full;
  float addedRange = 0;
  boolean breed = false;
  boolean damageEffect = true;

  Hostel(float xP, float yP, ArrayList<PImage> p, Grid g){
    super(xP, yP, p, g, true, 3);
    towerUI = new TowerUI(this, numUpgrades, peopleIcon, hosCapI, rangeIcon, hosBeaconI, eyeballIcon, hosRangeI);
    stat = new Stats(this);
    towerUI.upgrade1.maxed = false;
    towerUI.upgrade2.maxed = false;
    towerUI.upgrade3.maxed = false;
    rumble.play();
    range = 40;
    dmg = 0.05;
    refugeesHeld = 0;
    full = false;
    rOF = 10;
    curStats = stat;
    for(int j = 0; j <= 5; j++){
      int[] temp4 = {(int)random(200, 260), (int)random(104, 164), (int)random(209, 255)};
      Particle temp1 = new Particle(x, y, random(1, 2), temp4);
      particles.add(temp1);
    }
    curStats = stat;
    stat.updateStats();
  }
  
  Hostel(float xP, float yP, ArrayList<PImage> p, Grid g, boolean f){  //Indicates that this is not a functional tower
    super(xP, yP, p, g, true, 3);
    stat = new Stats(this);
    range = 40;
    dmg = 2;
    refugeesHeld = 0;
    full = false;
    rOF = 1000;
    curStats = stat;
  }
  
  void update(){
    stat.updateStats();
    if(levelUpdated){              //If the level ended
      workerNum += refugeesHeld;   //Add all the hostels kept overnight
      if(breed){
        workerNum += refugeesHeld * (int)random(2, 4);
      }
      for (int i = 0; i < refugeesHeld; i++){
          Refugee temp = new Refugee(this.x + random(-5, 5), this.y + random(-5, 5), random(2, 3), 10, true, true);
          zombies.add(temp);
          ((Refugee)zombies.get(i)).full.add(this);
          //zombies.get(i).setX(this.x + random(-5, 5) );
          //zombies.get(i).setY(this.y + random(-5, 5));
        }
      refugeesHeld = 0;            //Empty the hostels
      full = false;
    }
    for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range){
         if(reset == false){
           if(zombies.get(i) instanceof Refugee  || zombies.get(i) instanceof Reinforcement){                //If the zombie is anything other than a marked refugee
           if(zombies.get(i) instanceof Refugee){
              if(((Refugee)zombies.get(i)).marked == false){
                shoot(i);
                timeEnd = millis() + (int)rOF;
                reset = true;
              }
           }
           }else{
             shoot(i);
             timeEnd = millis() + (int)rOF;
             reset = true;
           }
         }
      }
    }
    if(reset){
      if(millis() >= timeEnd){
        reset = false;
        thickness = 3;
      }
    }
    if(refugeesHeld >= capacity){
      this.full = true;
    }
  }
  
  void shoot(int i){
    zombies.get(i).setHealth(zombies.get(i).getHealth() - dmg);
    if(zombies.get(i).getHealth() < 0){
        killCount++;
        stat.updateStats();
      }
    int[] temp2 = {(int)random(130, 175), (int)random(0, 50), (int)random(0, 50)};
    Particle temp = new Particle(zombies.get(i).getX() + random(6, 10), zombies.get(i).getY() + random(6, 10), random(0.2, 1.4), temp2, -0.4, -0.2, -1, 1);
    particles.add(temp);
    temp = new Particle(zombies.get(i).getX() + random(6, 10), zombies.get(i).getY() + random(6, 10), random(0.2, 1.4), temp2, -0.4, -0.2, -1, 1);
    particles.add(temp);
    temp = new Particle(zombies.get(i).getX() + random(6, 10), zombies.get(i).getY() + random(6, 10), random(0.2, 1.4), temp2, -0.4, -0.2, -1, 1);
    particles.add(temp);
  }
}


class Writer extends Tower{
  float rOF = 30;
  boolean reset = false;
  boolean lightning = false;
  float timeL = 0; 
  boolean poison = false;
  int timeStart;
  int timeEnd;
  float slow = 0;
  int thickness = 3;
  
  Writer(float xP, float yP, ArrayList<PImage> p, Grid g){
    super(xP, yP, p, g, true, 3);
    towerUI = new TowerUI(this, numUpgrades, damageIcon, wriDamageI, lessTimeIcon, wriCooldown, heartbleedIcon, wriCripplingBlowsI);
    towerUI.upgrade1.maxed = false;
    towerUI.upgrade2.maxed = false;
    towerUI.upgrade3.maxed = false;
    range = 120;
    slow = 0;
    poison = false;
    lightning = false;
    dmg = 5;
    inflate.play();
    stat = new Stats(this);
    rOF = 1700;
    curStats = stat;
    for(int j = 0; j <= 5; j++){
      int[] temp4 = {(int)random(240, 260), (int)random(144, 164), (int)random(239, 259)};
      Particle temp1 = new Particle(x, y, random(4, 13), temp4);
      particles.add(temp1);
    }
    curStats = stat;
    stat.updateStats();
  }
  
  void update(){
    for(int i = 0; i < zombies.size(); i++){
      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= range){
         if(reset == false){
           if(zombies.get(i) instanceof Refugee  || zombies.get(i) instanceof Reinforcement){                //If the zombie is anything other than a marked refugee
           if(zombies.get(i) instanceof Refugee){
              if(((Refugee)zombies.get(i)).marked == false){
                shoot(i);
                timeEnd = millis() + (int)rOF;
                reset = true;
              }
           }
           }else{
             shoot(i);
             timeEnd = millis() + (int)rOF;
             reset = true;
           }
         }
         if(lightning){
           if(millis() > timeL){
             Bolt temp = new Bolt(x, y, zombies.get(i));    //zombies.get(i).getX(), zombies.get(i).getY(),
             bolts.add(temp);
             zombies.get(i).setHealth(zombies.get(i).getHealth() - 5);
             timeL = millis() + random(20000, 22000);
           }
         }
      }
    }
    if(reset){
      if(millis() >= timeEnd){
        reset = false;
        thickness = 3;
      }
    }
  }
  void shoot(int i){
    if(poison){
      zombies.get(i).poisonHit();
    }
    zombies.get(i).setHealth(zombies.get(i).getHealth() - dmg);
    if(zombies.get(i).getInitXVelo() >= 0.2 && zombies.get(i).getXVelo() >= 0.6){
      zombies.get(i).setInitXVelo(zombies.get(i).getInitXVelo() - slow);
      zombies.get(i).setXVelo(zombies.get(i).getXVelo() - slow);
    }
    if(zombies.get(i).getHealth() < 0){
        killCount++;
        stat.updateStats();
      }
    int[] temp2 = {250, 154, 249};
    Particle temp = new Particle(zombies.get(i).getX(), zombies.get(i).getY(), random(4, 6), temp2);
    particles.add(temp);
    temp = new Particle(zombies.get(i).getX(), zombies.get(i).getY(), random(4, 6), temp2);
    particles.add(temp);
    temp = new Particle(zombies.get(i).getX(), zombies.get(i).getY(), random(4, 6), temp2);
    particles.add(temp);
    ding.play();
    for(int j = 0; j <= 5; j++){
      int[] temp3 = {(int)random(240, 260), (int)random(144, 164), (int)random(239, 259)};
      temp = new Particle(x, y, random(4, 13), temp3);
      particles.add(temp);
    }
  }
}

class Home extends Tower{
  float rOF = 30;
  boolean reset = false;
  int timeStart;
  int timeEnd;
  int thickness = 3;
  int capacity = 3;
  int refugeesHeld;
  boolean full;
  
  Home(float xP, float yP, PImage p, Grid g, boolean f){  //Indicates that this is not a functional tower
    super(xP, yP, p, g, true);
    stat = new Stats(this);
    refugeesHeld = 0;
    full = false;
    curStats = stat;
  }
  
  void update(){
    stat.updateStats();
  }
}