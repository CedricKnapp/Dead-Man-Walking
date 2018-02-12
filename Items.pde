//Every items that a tower will need to deploy
interface Item{
  float getX();
  float getY();
  void setX(float xP);
  void setY(float yP);
  void drawItem();
  void updateItem();
}

class Bolt{
  float x, y, destX, destY;
  float thickness;
  float tX1, tY1, tX2, tY2;
  int maxSpread;
  Moveable target;
  
  Bolt(float xP, float yP, Moveable m){
    x = xP;
    y = yP;
    destX = m.getX();
    destY = m.getY();
    tX1 = x + random(-40, 40);
    tY1 = y + random(-40, 40);
    tX2 = destX + random(-40, 40);
    tY2 = destY + random(-40, 40);
    target = m;
    maxSpread = 0;
    thickness = 4;
    fill(255);
    rect(0, 0, width, height);
    int rand = (int) random(0, 2);
    if(rand == 0){
      thunder1.play();
    }else{
      thunder2.play();
    }
     
  }
  
  void drawBolt(){
    stroke(255);
    strokeWeight(thickness);
    if(view == 0){
    line(x, y, tX1, tY1);
    line(tX1, tY1, tX2, tY2);
    line(tX2, tY2, destX, destY);
    }
  }
  
  void updateBolt(){
    if(thickness >= 3.8 ){
      for(int i = 0; i < zombies.size(); i++){  //Find every zombie
        if(maxSpread <= 1){    //At spawn and if there are less than 3 targets affected
          if(!(zombies.get(i).equals(target))){      //That isn't the inital target
            if(dist(zombies.get(i).getX(), zombies.get(i).getY(), destX, destY) <= 120 && zombies.get(i).getShocked() == false){  //Search
              if(zombies.get(i) instanceof Refugee){    //If target is a refugee
                  if(((Refugee)zombies.get(i)).marked == false){  //That isn't marked, shoot:
                    zombies.get(i).setHealth(zombies.get(i).getHealth() - 5);
                    zombies.get(i).shocked();
                    Bolt temp = new Bolt(destX, destY, zombies.get(i));
                    bolts.add(temp);
                    maxSpread++;
                  }
              }else{                                              //Shoot here
                  zombies.get(i).setHealth(zombies.get(i).getHealth() - 5);
                  zombies.get(i).shocked();
                  Bolt temp = new Bolt(destX, destY, zombies.get(i));
                  bolts.add(temp);
                  maxSpread++;
              }
            }
          }
        }
      }
    }
    if(thickness <= 0.2){
      bolts.remove(this);
    }else{
      thickness *= 0.92;
    }
  }
}

//Throwable item for chainsaw factory [Cedric's Saw]
class SawBlade{
  float orginX, orginY;
  float destX, destY;
  int rotation = 0;
  int frame = 0;
  float chainX, chainY;
  static final float ANIMATION_SPEED = 12; //A value of 1,(assuming 30fps) will result in an animation time of 12 seconds, value of 12 will take 1 second animation. 
  float currentAng = 0;
  float amplitude;
  final float H_COMPRESS = .5; //Horizontal compression by a factor of 2 to use only half of the sine function for the given period
  
  //For travel Direction Variables, 0 indicates no motion along that axis, 1 indicates positive movement direction, and -1 indicates negative direction
  int vertTravelDir = 0;
  int horTravelDir = 0;

  //Value for what the x should increase by
  float deltaX;
  
  //Value is set to true when the animation of the shot is completed
  boolean reached = false;
  
  SawBlade(float orginX, float orginY, float destX, float destY){
    this.orginX = orginX;
    this.orginY = orginY;
    this.destX = destX;
    this.destY = destY;
    
    //Set the amplitude of the wave equal to a constant added to the height of the wave
    amplitude = -150;
    
    //set the xInc amount
    deltaX = 0;
    
    //Sets the coresponding variables depending on the travel direction
    if(destX > orginX){horTravelDir = 1;}
    else if(destX < orginX){horTravelDir = -1;}
    else{horTravelDir = 0;}
    
    if(destY > orginY){vertTravelDir = 1;}
    else if(destY < orginY){vertTravelDir = -1;}
    else{vertTravelDir = 0;}
    
    //Sets the chain position and adjusts it for the ANIMATION_SPEED
    if(horTravelDir == 1){
      chainX = orginX;
    }else if(horTravelDir == 0){
      chainX = orginX;
    }else if(horTravelDir == -1){
      chainX = orginX;
    }
    chainY = orginY; 
  }
  
  void update(){
    if(currentAng <= 360/ANIMATION_SPEED){
      if(currentAng <= 180/ANIMATION_SPEED){
        if(vertTravelDir == 1 || vertTravelDir == 0){chainY = amplitude*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY;}
        else if(vertTravelDir == -1 || vertTravelDir == 0){chainY = (amplitude - computeLinDist(orginY,destY))*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY;}
      }else if(currentAng > 180/ANIMATION_SPEED){
        if(vertTravelDir == 1){chainY = (amplitude - computeLinDist(orginY,destY))*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY + computeLinDist(orginY,destY);}
        else if(vertTravelDir == -1){chainY = amplitude*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY - computeLinDist(orginY,destY);}
      }
      if (horTravelDir == 1){chainX += deltaX;}
      else if (horTravelDir == -1){chainX -= deltaX;}
      
      currentAng++;
      deltaX = (computeLinDist(destX,orginX)/360)*ANIMATION_SPEED;
    }else{
      reached = true; 
    }
    display();
  }
  
  void display(){
    if(view == 0){
     if(frame == 2){
       frame  = 0;
     }else{
       frame++;
     }
    pushMatrix();
    translate(chainX, chainY);
    rotate(radians(rotation));
    rotation += 12;
    image(chainsawImg, 0, 0);
    popMatrix();
    }
  }
 
  float computeLinDist(float pos1, float pos2){
    return abs(pos1-pos2);
  }
}


class Grenade{
  float orginX, orginY;
  float destX, destY;
  PImage frame;
  int fNum = 0;
  float chainX, chainY;
  static final float ANIMATION_SPEED = 12; //A value of 1,(assuming 30fps) will result in an animation time of 12 seconds, value of 12 will take 1 second animation. 
  float currentAng = 0;
  float amplitude;
  final float H_COMPRESS = .5; //Horizontal compression by a factor of 2 to use only half of the sine function for the given period
  
  //For travel Direction Variables, 0 indicates no motion along that axis, 1 indicates positive movement direction, and -1 indicates negative direction
  int vertTravelDir = 0;
  int horTravelDir = 0;

  //Value for what the x should increase by
  float deltaX;
  
  //Value is set to true when the animation of the shot is completed
  boolean reached = false;
  
  Grenade(float orginX, float orginY, float destX, float destY){
    this.orginX = orginX;
    this.orginY = orginY;
    this.destX = destX;
    this.destY = destY;
    
    //Set the amplitude of the wave equal to a constant added to the height of the wave
    amplitude = -150;
    
    //set the xInc amount
    deltaX = 0;
    
    //Sets the coresponding variables depending on the travel direction
    if(destX > orginX){horTravelDir = 1;}
    else if(destX < orginX){horTravelDir = -1;}
    else{horTravelDir = 0;}
    
    if(destY > orginY){vertTravelDir = 1;}
    else if(destY < orginY){vertTravelDir = -1;}
    else{vertTravelDir = 0;}
    
    //Sets the chain position and adjusts it for the ANIMATION_SPEED
    if(horTravelDir == 1){
      chainX = orginX;
    }else if(horTravelDir == 0){
      chainX = orginX;
    }else if(horTravelDir == -1){
      chainX = orginX;
    }
    chainY = orginY; 
  }
  
  void update(){
    if(currentAng <= 360/ANIMATION_SPEED){
      if(currentAng <= 180/ANIMATION_SPEED){
        if(vertTravelDir == 1 || vertTravelDir == 0){chainY = amplitude*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY;}
        else if(vertTravelDir == -1 || vertTravelDir == 0){chainY = (amplitude - computeLinDist(orginY,destY))*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY;}
      }else if(currentAng > 180/ANIMATION_SPEED){
        if(vertTravelDir == 1){chainY = (amplitude - computeLinDist(orginY,destY))*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY + computeLinDist(orginY,destY);}
        else if(vertTravelDir == -1){chainY = amplitude*sin(H_COMPRESS*radians(currentAng*ANIMATION_SPEED)) + orginY - computeLinDist(orginY,destY);}
      }
      if (horTravelDir == 1){chainX += deltaX;}
      else if (horTravelDir == -1){chainX -= deltaX;}
      
      currentAng++;
      deltaX = (computeLinDist(destX,orginX)/360)*ANIMATION_SPEED;
    }else{
      reached = true; 
      potions.add(new Molotov(chainX, chainY, true));
      grenades.remove(this);
    }
    display();
  }
  
  void display(){
    if(fNum == 0){
      frame = rocket1;
      fNum++;
    }else if(fNum == 1){
      frame = rocket2;
      fNum++;
    }if(fNum == 2){
      frame = rocket3;
      fNum = 0;
    }
      
    image(frame, chainX, chainY);
    ellipse(chainX,chainY, 3,3);
  }
 
  float computeLinDist(float pos1, float pos2){
    return abs(pos1-pos2);
  }
}

//Freezes any movebale zombie (including refugees, excluding gutters)
class FreezeBottle implements Item{
  float x;  
  float y;
  float yVelo = 0.1;
  boolean temp = false;
  float destY;
  public FreezeBottle(float xP, float yP){  //Create freeze grenade at mouse pointer
    x = xP;
    destY = yP;
    y = yP - 200;                            //Launch it 50 pixels above mouse click
  }
  public FreezeBottle(float xP, float yP, boolean f){  //Create molotov at mouse pointer
    x = xP;
    destY = yP;
    y = yP - 2;
    temp = true;
  }
  //Accessor and mutator methods
  float getX() { return x; }
  float getY() { return y; }
  void setX(float xP) { x = xP; }
  void setY(float yP) { y = yP; }
  
  //Draw the freeze grenade
  void drawItem(){
    fill(#1AEDDA, 200);
    if(view == 0){
    ellipse(x, y, 5, 5);
    }
      Particle temp = new Particle(x, y, 'F');  //Emit freeze particles
      particles.add(temp);                      //Add to the list
      temp = new Particle(x, y, 'F');  //Emit freeze particles
      particles.add(temp);                      //Add to the list
      
  }
  
  void updateItem(){
    if(y <= destY){  //Until past the destination
      y += yVelo;    //Change y location
      yVelo *= 1.22; //Increase the velocity
    }else{
      y = destY;
      splash();      //ONce reached dest., splash
    }
    if(temp){
      splash();
    }
  }
  
  void splash(){
    for(int i = 0; i <=20; i++){
      Particle temp = new Particle(x, y, 'P');  //Emit freeze particles
      particles.add(temp);                      //Add to the list
    }
    for(int i = 0; i <=10; i++){
      Particle temp = new Particle(x, y, 'F');  //Emit different freeze particles
      particles.add(temp);                      //Add to the list
    }
    for(int i = 0; i < zombies.size(); i++){                                         //Go through every zombie
      if(dist(x, y, zombies.get(i).getX() + 7, zombies.get(i).getY() + 7) <= 35){    //That is 35 pixels close
        zombies.get(i).freeze();                                                     //Freeze 'em
      }
    }
    potions.remove(this);                                                            //Remove this item
  }
}

//Burns all zombies
class Molotov implements Item{
  float x;
  float y;
  boolean temp;
  float yVelo = 0.1;
  float destY;
  public Molotov(float xP, float yP){  //Create molotov at mouse pointer
    x = xP;
    destY = yP;
    y = yP - 200;                       //Launch it 50 pixels above mouse click
  }
  
  public Molotov(float xP, float yP, boolean f){  //Create molotov at mouse pointer
    x = xP;
    destY = yP;
    y = yP - 2;
    temp = true;
  }
  //Accessor and mutator methods
  float getX() { return x; }
  float getY() { return y; }
  void setX(float xP) { x = xP; }
  void setY(float yP) { y = yP; }
  
  void drawItem(){
    fill(#A55C17, 200);
    if(view == 0){
      rect(x - 2, y - 4, 4, 8, 3);
    }
    Particle temp = new Particle(x- 2, y-4, 'N');  //Emit cool flames (again i guess)
    particles.add(temp);
  }
  
  //Draw the molotov
  void updateItem(){
    if(y <= destY){    //Until molotov reaches destination
      y += yVelo;      //Change the y value
      yVelo *= 1.2;   //Incr. velocity
    }else{
      y = destY;
      splash();        //When dest. reached, splash
    }
    if(temp){
      splash();
    }
  }
  
  void splash(){
    for(int i = 0; i <=20; i++){
      Particle temp = new Particle(x, y, 'N');  //Emit cool flames
      particles.add(temp);
    }
    for(int i = 0; i <=10; i++){
      Particle temp = new Particle(x, y, 'Y');  //Emit cool flames (again i guess)
      particles.add(temp);
    }
    for(int i = 0; i < zombies.size(); i++){                                         //Go through every existing zombie
      if(dist(x, y, zombies.get(i).getX() + 7, zombies.get(i).getY() + 7) <= 35){    //That is 35 pixels close
        zombies.get(i).burn();                                                       //Burn 'em
      }
    }
    potions.remove(this);                                                            //Remove item for list
  }
}

class StuckSaw{
  float x, y;
  int frame;
  Tower t;
  int checkTime = 0;
  PImage[] frames = {spin0, spin1, spin2, spin3, spin4, spin5, spin6, spin0, spin1, spin2, spin3, spin4, spin5, spin6, spin0, spin1, spin2, spin3, spin4, spin5, spin6};
  
  StuckSaw(float xP, float yP, Tower to){
    x = xP;
    y = yP;
    frame = 0;
    t = to;
  }
  
  void drawSaw(){
    noTint();
    image(frames[frame], x, y);
    ellipse(x + 10, y + 10, 3, 3);
  }
  
  void updateSaw(){
    for(Moveable m: zombies){
      if(dist(x + 10, y + 10, m.getX(), m.getY()) <= 16){
        if(m instanceof Refugee){
          if(((Refugee)m).marked == false){
            m.setHealth(m.getHealth() - 0.15); 
          }
        }else{
           m.setHealth(m.getHealth() - 0.15);
        }
        if(m.getHealth() <= 0){
          for(int i = 0; i < towersList.size(); i++){
            if(towersList.get(i).equals(t)){
              towersList.get(i).killCount++;
              towersList.get(i).stat.updateStats();
            }
          }
        }
      }
    }
    if(frame < 18 && millis() >= checkTime){
      frame++;
      checkTime = millis() + 50;
    }else if(frame == 18){
      
      stuck.remove(this);
    }
  }
}