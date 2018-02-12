final int THAW_TIME = 5000;
final int COOL_TIME = 7000;

interface Moveable{
  void drawZombie();    //Updates the zombie frame animation
  void display();       //Draws the image of the zombie
  void update();        //Update contains the AI and changes teh zombie location
  void dead();          //Remove the zombie if their condition need them to not exist
  void shocked();
  float getX();  
  float getY();
  void setY(float y);
  void setX(float x);
  void poisonHit();
  float getXVelo();
  float getInitXVelo();
  float getHealth();
  boolean getSpeedy();
  boolean getInCombat();
  boolean getShocked();
  boolean getFrozen();
  boolean getFire();
  void setInCombat(boolean b);
  void setHealth(float h);
  void setInitialHealth(float h);
  void freeze();
  void burn();
  void setXVelo(float x);
  void setInitXVelo(float i);
  void setSpeedy(boolean s);
}

class Refugee implements Moveable{
  float hostel_dist; //Should this be an Int?
  float shortest = 100000; //Shortest Hostel distance
  Hostel hostel_dest;
  float x;
  float y;
  float yTarg;
  float xVel, yVel, initVelo;
  float health;
  float ogHealth;
  boolean morning = false;
  float zWidth;
  boolean hoarder;
  boolean inCombat = false;
  boolean isSpeedy = false;
  boolean isFrozen = false;
  boolean isBurning = false;
  boolean isShocked = false;
  boolean isEntered = true;
  float timeUnfreeze;
  float timeUnburn;
  float timePosion = 0;
  float timeShocked = 0;
  float time;
  boolean death, marked;
  int skin = (int) random(0, 2);
  PImage[] frames = new PImage[5];
  int curFrame = 0;
  
  
  ArrayList<Hostel> un_checked;
  ArrayList<Hostel> full;

  Refugee(float xPos, float yPos){
  x = xPos;
  y = yPos;
  marked = false;
  health = 10;
  ogHealth = health;
  xVel = random(1, 2.2);
  yVel = 0;
  death = false;
  timePosion = 0;
  timeShocked = 0;
  isEntered = false;
  zWidth = 10;
  hostel_dist = 51;
  hostel_dest = null;
  
  un_checked = new ArrayList<Hostel>();
  full = new ArrayList<Hostel>();
  }
  
  Refugee(float xPos, float yPos, float s, float h){
  x = xPos;
  y = yPos;
  marked = false;
  health = h;
  ogHealth = health;
  morning = false;
  xVel = s;
  timePosion = 0;
  timeShocked = 0;
  yVel = 0;
  death = false;
  isEntered = false;
  zWidth = 10;
  hostel_dist = 51;
  hostel_dest = null;
  
  un_checked = new ArrayList<Hostel>();
  full = new ArrayList<Hostel>();
  }
  
  Refugee(float xPos, float yPos, float s, float h, boolean t){
  x = xPos;
  y = yPos;
  marked = t;
  timePosion = 0;
  health = h;
  ogHealth = health;
  xVel = s;
  yVel = 0;
  death = false;
  isEntered = false;
  zWidth = 10;
  hostel_dist = 51;
  hostel_dest = null;
  
  un_checked = new ArrayList<Hostel>();
  full = new ArrayList<Hostel>();
  }
  
  void poisonHit(){
    timePosion = millis() + 2000;
  }
  
  Refugee(float xPos, float yPos, float s, float h, boolean t, boolean m){
  x = xPos;
  y = yPos;
  marked = t;
  health = h;
  ogHealth = health;
  xVel = s;
  yVel = 0;
  death = false;
  morning = m;
  isEntered = false;
  zWidth = 10;
  hostel_dist = 51;
  hostel_dest = null;
  
  un_checked = new ArrayList<Hostel>();
  full = new ArrayList<Hostel>();
  }
  
void shocked(){
    isShocked = true;
    timeShocked = millis() + 1000;
}
  
  void infect(){
    Zombie temp = new Zombie(x, y);
    zombies.add(temp);
    zombies.remove(this);
  }
  
  void marked(){
    if(marked == false){
      if(dist(mouseX, mouseY, x + 5, y + 5) <= 5){
        for(int i = 0; i < 5; i++){
          Particle temp = new Particle(x + 5, y + 5, random(3, 5), new int[] {(int) random(240, 260), (int) random(240, 260), (int) random(30, 40)}, 1,3, -1, 1);
          particles.add(temp);
        }
        marked = true;
      }
    }
  }
  
  void freeze(){
  isFrozen = true;
  timeUnfreeze = millis() + THAW_TIME;
  }
  
  void burn(){
    isBurning = true;
    timeUnburn = millis() + COOL_TIME;
  }
  
  void giveSkin(){
    if(skin == 0){
      frames = new PImage[] {c1walk1, c1walk2, c1freeze, c1burn, c1death};
    }else if(skin == 1){
      frames = new PImage[] {c2walk1, c2walk2, c2freeze, c2burn, c2death};
    }
  }
  
  void update(){
  if(death == false){
    if(isFrozen == false){
      if(isBurning){    //If on fire
        curFrame = 3;    //Set zombie frame to freeze
        Particle temp = new Particle(x + 6 + random(2, 5), y + 5 + random(0, 10), 'N');  //Add a flame
        particles.add(temp);
        health -= 0.1;
        temp = new Particle(x + 6 + random(2, 4), y + 7 + random(0, 2), 'T');                           //Add sut
        particles.add(temp);
        if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or set on fire
          curFrame = 0;
          isBurning = false;
        }
      }
      if(inCombat){
        //if in combat do nothing
      }else{
         if(morning == false){  //If the refugee is not already safe
        //This will update the instance unchecked list of hostels.
        //This will wipe the arrayList so it can be repopulated again (without duplicates) /// Only runs if the arrayList is bigger than 0
        if(un_checked.size() > 0){
          for(int i = un_checked.size()-1; i > -1; i--){
            un_checked.remove(i);
          }
        }
        //This will populate the arrayList of unchecked 
        for(int i = towersList.size()-1; i > -1; i--){
          if(towersList.get(i) instanceof Hostel){
            un_checked.add((Hostel)towersList.get(i));
          }
        }
        //This will compare the contents of the full arrayList with the un_checked one. Since the full list is only updated everytime a refugee finds a full hostel
        //We can effectively use the full hostel list as a constant check for already visited hostels.
        for (int i = full.size()-1; i > -1; i--){ //First loops through the array of all full/visited hostels 
          for (int z = un_checked.size()-1; z > -1; z--){ //Nested loop through the unchecked array
            if(un_checked.get(z).equals(full.get(i))){ //If any of the unchecked hostels match an already visited hostel
              un_checked.remove(z);               // It is promptly removed from the unchecked list.
            }
          }
        }
        //Loops through the array of unchecked hostels
        for(int i = un_checked.size()-1; i > -1; i--){
          Hostel hostel_2check = un_checked.get(i); //Make sum nice local variables
          hostel_dist = dist(this.x, this.y, hostel_2check.x, hostel_2check.y); // Calculate distance between the refugee and hostels
          if(hostel_dist < (70 + un_checked.get(i).addedRange)  && hostel_dist < shortest){ //If the hostel is within this distance, and in the case it's shorter than the previous shortest distance
            shortest = hostel_dist; //Replace the shortest distance with the current one (since it's shorter)
            hostel_dest = hostel_2check; //Set our specific hostel destination to be this one specifically. This should be the shortest distance, so it'll prioritize this hostel over others.
          }
        }
        if(hostel_dest != null){ //If a hostel destination is defined
          //Get the difference in X coords and Y coords from hostel and refugee
          float x_dif = hostel_dest.x - this.x;
          float y_dif = hostel_dest.y - this.y;
          
          //If the hostel is located forward of the refugee, move towards it.
          if(x_dif < 0){
           xVel = -3;
          }
          //If the hostel is located behind the refugee, move backwards on the X plane
          else if(x_dif > 0){
            xVel = 3;
          }
          //In the case the X difference is 0, stop it from moving. This code currently doesn't execute due to the nature of the moving refugee for some reason.
          //else if (x_dif > -1 ){
          //  xVel = 0;
          //}
          
          //Follow the same scheme for the Y coords, in this case replace the X plane with the Y plane.
          if(y_dif > 1){
             yVel = 3;
          }
          else if(y_dif < -1){
            yVel = -3;
          }
          else{
            yVel = 0;
           // xVel = 0;
          }
          //The y_dif and x_dif should actually be 0 in this case, but since that code doesn't execute properly, we say within 10 pixels the refugee will check the status of the hostel
          //Whether if it's full or not.
          if((y_dif < 10 && x_dif < 10) ){
            if(hostel_dest.full == true && hostel_dest !=null){
              //In the case that is full, we add this hostel to the full arrayList and promptly clear the current hostel destination to be empty and set our yVel to be 0 (so it continues moving horizontally)
              full.add(hostel_dest);
              //This resets the hostel destination and the appropriate shortest distance. Shortest wasn't being reset before which is why it was not checking any other hostels afterwards.
              hostel_dest = null;
              shortest = 10000;
              yVel = 0;
              xVel = 3;
              
            }
            else if(hostel_dest.full == false){
              //Otherwise, increase the count of refugees in this specific hostel and remove the instance of the refugee (by setting it's health to less than 0
              hostel_dest.refugeesHeld++; //Note this code might not actually be functioning correctly, my logic may be faulty. 
              
              //If anything, to update the refugeesHeld in that specific hostel, we'll probably need to access the arrayList of towers until we find this specific tower/hostel. THEN we update it accordingly.
              //That can be done by simply using a forLoop to run through the towersList and .equals compare this variable to the current iteration of the loop.
              if(hostel_dest.full == false){
                isEntered = true;
              }
            }
            }
        }
      }
      x += xVel;
      y += yVel;
    }
    }else{      //if the zombie is frozen
      curFrame = 2;    //Set zombie frame to freeze
      if(millis() >= timeUnfreeze || isBurning){  //If cooldown time was reached, or set on fire
        curFrame = 0;
        isFrozen = false;
      }
    }
    if(x >= width){    //Reached the edge
       //x = 0; 
       
      }
      
      if(millis() <= timePosion){
        health -= 0.2;
        int[] temp2 = {250, 154, 249};
        Particle temp = new Particle(x + random(3, 10), y + random(3, 10), random(1, 2.5), temp2);
        particles.add(temp);
      }
      
        if(millis() >= timeShocked){
          isShocked = false;
        }
    }else{
      xVel = 0;
      yVel = 0;
    }
    //if(isEntered){
    //  zombies.remove(this);
    //}
  }
  
  void drawZombie(){
    if(millis() <= time){
      if(curFrame == 0){
      //image(frames[curFrame], x, y);
      curFrame = 1;
      }else if(curFrame == 1){
        //image(frames[curFrame], x, y);
        curFrame = 0;
      }
    }else{
      time = millis() + (int)random(20, 40);
    }
  }
  
  void display(){
    giveSkin();
    if(marked){
      fill(#FCFC2B, 120);
      ellipse(x + 12, y + 17, 14, 5);
    }
    if (death == false){
      if(health < ogHealth / 6){
        fill(255, 0, 0);
      }else{
        fill(0, 255, 0);
      }
      if(health / ogHealth * 100 / 7 < 0){    //The health is negative
          //Don't display
      }else{                                  //Otherwise draw health
        rect(x  + 5, y - 5, health / ogHealth * 100 / 7, 5);
      }
      
      image(frames[curFrame], x, y);
    }else{
      image(frames[curFrame], x, y);
    }
    if(isSpeedy && death == false){
      tint(100, 255, 100, 200);
      image(frames[curFrame], x, y);
      Particle temp = new Particle(x + random(4, 20), y + random(4, 20), 'S');
      particles.add(temp);
      noTint();
    }
  }
  
  void dead(){
    
      if(isEntered){
        zombies.remove(this);
      }
      if(health < 0){
        death = true;
        curFrame = 4;
        int rand = (int)random(0, innoGrunt.size());
        while(rand == lastUsedDeathSound){
          rand = (int)random(0, innoGrunt.size());
        }
        lastUsedDeathSound = rand;
        innoGrunt.get(rand).play();
        deadZombies.add(this);      //remove brackets
        zombies.remove(this);
      }
    if(marked){                      //If marked
      if(x >= width - 10){                //And passed through screen
       zombies.remove(this);         //Remove self from game
      }
    }else if(x >= width){    //Reached the edge adn NOT marked
       zombies.remove(this);         //Remove self from game
      }
  }
  
  float getX() {  return x; }
  float getY() {  return y; }
  float getHealth() {  return health; }
  float getXVelo() {  return xVel; }
  float getInitXVelo() {  return initVelo; }
  boolean getSpeedy() {  return isSpeedy; }
  boolean getFire() {  return isBurning; }
  boolean getInCombat() {  return inCombat; }
  boolean getFrozen() {  return isFrozen; }
  boolean getShocked() {  return isShocked; }
  void setInCombat(boolean b) {  inCombat = b; }
  
  void setSpeedy(boolean s) {  isSpeedy = s; }
  void setInitXVelo(float i) {  initVelo = i; }
  void setXVelo(float x) {  xVel = x; }
  void setY(float yP) {  y = yP; }
  void setX(float xP) {  x = xP; }
  void setHealth(float h) {  health = h; }
  void setInitialHealth(float h) {  ogHealth = h; }
}

// ------------------------------------------------------------------------ Z O M B I E   C L A S S ------------------------------------------------------------------ //
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //


class Zombie implements Moveable{
float x;
float y;
float yTarg;
float xVel, yVel, initVelo;
float health;
float ogHealth;
float zWidth;
boolean hoarder;
float timePosion = 0;
float timeShocked = 0;
boolean isShocked = false;
boolean isSpeedy = false;
boolean inCombat = false;
boolean isFrozen = false;
boolean isBurning = false;
float timeUnfreeze;
float timeUnburn;
int price;
float time;
boolean death;
int skin;
PImage[] frames = new PImage[6];
int curFrame = 0;

Zombie(float xPos, float yPos){
  x = xPos;
  y = yPos;
  yTarg = y + random(-20, 20);
  while(!(yTarg > 40 || yTarg < (height - 210))){
    yTarg = y + random(-20, 20);
  }
  price = 1;
  health = 10;
  ogHealth = health;
  xVel = random(0.5, 2.5);
  initVelo = xVel;
  skin = ((int)random(0, 3));
  yVel = random(0.2, 0.5);
  int p = (int) random(0, 2);
  if(p == 0){
    hoarder = true;
  }else{
    hoarder = false;
  }
  timeShocked = 0;
  time = millis() + 500;
  death = false;
  zWidth = 10;
  giveSkin();
}

Zombie(float xPos, float yPos, float speed, float h){
  x = xPos;
  y = yPos;
  yTarg = y + random(-20, 20);
  while(!(yTarg > 40 || yTarg < (height - 210))){
    yTarg = y + random(-20, 20);
  }
  health = h;
  ogHealth = health;
  xVel = speed;
  initVelo = xVel;
  price = 1;
  skin = ((int)random(0, 3));
  yVel = random(0.2, 0.5);
  int p = (int) random(0, 2);
  if(p == 0){
    hoarder = true;
  }else{
    hoarder = false;
  }
  time = millis() + 500;
  death = false;
  zWidth = 10;
  giveSkin();
}

Zombie(float xPos, float yPos, float speed, float h, boolean b){
  x = xPos;
  y = yPos;
  price = 1;
  yTarg = y + random(-20, 20);
  while(!(yTarg > 40 || yTarg < (height - 210))){
    yTarg = y + random(-20, 20);
  }
  health = h;
  ogHealth = health;
  xVel = speed;
  initVelo = xVel;
  skin = ((int)random(0, 3));
  yVel = random(0.2, 0.5);
  hoarder = b;
  time = millis() + 500;
  death = false;
  zWidth = 10;
  giveSkin();
}

void poisonHit(){
    timePosion = millis() + 2000;
}

void shocked(){
    isShocked = true;
    timeShocked = millis() + 100;
}

void giveSkin(){
  if(skin == 0){
    frames = new PImage[] {z1walk1, z1walk2, z1freeze, z1burn, z1attack, z1death};
  }else if(skin == 1){
    frames = new PImage[] {z2walk1, z2walk2, z2freeze, z2burn, z2attack, z2death};
  }else if(skin == 2){
    frames = new PImage[] {z3walk1, z3walk2, z3freeze, z3burn, z3attack, z3death};
  }
}

void drawZombie(){
  if(millis() <= time){
    if(curFrame == 0){
    //image(frames[curFrame], x, y);
    curFrame = 1;
    }else if(curFrame == 1){
      //image(frames[curFrame], x, y);
      curFrame = 0;
    }
  }else{
    time = millis() + (int)random(20, 40);
  }
}

void display(){
  giveSkin();
  if (death == false){
    if(health < ogHealth / 6){
      fill(255, 0, 0);
    }else{
      fill(0, 255, 0);
    }
    if(health / ogHealth * 100 / 7 < 0){    //The health is negative
          //Don't display
    }else{    
      rect(x  + 5, y - 5, health / ogHealth * 100 / 7, 5);
    }
    //frames = new PImage[] {z1walk1, z1walk2, z1freeze, z1burn, z1attack, z1death};
    
    image(frames[curFrame], x, y);
  }else{
    image(frames[curFrame], x, y);
  }
  if(isSpeedy && death == false){
    tint(100, 255, 100, 200);
    image(frames[curFrame], x, y);
    Particle temp = new Particle(x + random(4, 20), y + random(4, 20), 'S');
    particles.add(temp);
    noTint();
  }
}

void freeze(){
  isFrozen = true;
  timeUnfreeze = millis() + THAW_TIME;
}

void burn(){
  isBurning = true;
  timeUnburn = millis() + COOL_TIME;
}

void update(){
  if(death == false){
    if(isFrozen == false){
      if(isBurning){    //If on fire
        curFrame = 3;    //Set zombie frame to freeze
        Particle temp = new Particle(x + 6 + random(2, 5), y + 5 + random(0, 10), 'N');  //Add a flame
        particles.add(temp);
        health -= 0.1;
        temp = new Particle(x + 6 + random(2, 4), y + 7 + random(0, 2), 'T');                           //Add sut
        particles.add(temp);
        if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or set on fire
          curFrame = 0;
          isBurning = false;
        }
      }
      if(inCombat){
        //if in combat do nothing
      }else{
      if(isSpeedy){
        if(xVel >= initVelo){
           xVel -= 0.02;
        }else{
          isSpeedy = false;
        }
      }
      if(hoarder){                                                //If the zombie is a hoarder
        for(int i = 0; i < zombies.size(); i++){                      //Find every zombie
          if(dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) <= 30 && dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) >= 5){    //That is 10 pixels close
          //if(dist(x, y, zombies.get(i).x, zombies.get(i).y) <= 30 && dist(x, y, zombies.get(i).x, zombies.get(i).y) >= 5){    //That is 10 pixels close
            if(!zombies.get(i).equals(this)){                          //And it's not yourself, idiot
              if (zombies.get(i).getY() > y){            //Move closer to that zombie
                y += 0.09;
                //y += yVel;
              }else if (zombies.get(i).getY() < y){
                y -= 0.09;
                //y -= yVel;
              }
              if (zombies.get(i).getXVelo() + 0.5 < xVel){            //Move closer to that zombie
                xVel -= 0.05;
              }
            }
          }else{      //If not in hoard
            if(xVel < initVelo && !isSpeedy){
              xVel += 0.05;
            }else if(xVel > initVelo && !isSpeedy){
              xVel = initVelo;
            }
          }
        }
        x += xVel;
      }else{
        x += xVel;
        if(abs(yTarg - y) < 5 * yVel){
          yTarg = y + random(-20, 20);
          while(yTarg < 40 || yTarg > (height - 210)){
            yTarg = y + random(-20, 20);
          }
        }else if(y > (yTarg + yVel*2)){
          y -= yVel;
        }else if(y < (yTarg - yVel*2)){
          y += yVel;
        }
      }
      for(int i = 0; i < zombies.size(); i++){                      //Find every zombie
          if(dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) <= 40 && dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) >= 2 && x >= width / 3){    //That is 30 pixels close
            if(zombies.get(i) instanceof Refugee){
              if(zombies.get(i).getY() > y){
                y += yVel;
              }else if(zombies.get(i).getY() < y){
                y -= yVel;
              }
              if(zombies.get(i).getX() > x){
                x += xVel;
              }else if(zombies.get(i).getX() < x){
                x -= xVel;
              }
              if(dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) <= 5){
                ((Refugee)zombies.get(i)).infect();
              }
            }
          }
      }
    }
    }else{      //if the zombie is frozen
      curFrame = 2;    //Set zombie frame to freeze
      if(millis() >= timeUnfreeze || isBurning){  //If cooldown time was reached, or set on fire
        curFrame = 0;
        isFrozen = false;
      }
    }
    if(x >= width){    //If passed through the screen
     //x = 0;
     population--;
     enteredIn.play();
    }
    if(millis() <= timePosion){
        health -= 0.2;
        int[] temp2 = {250, 154, 249};
        Particle temp = new Particle(x + random(3, 10), y + random(3, 10), random(1, 2.5), temp2);
        particles.add(temp);
    }
    if(millis() >= timeShocked){
      isShocked = false;
    }
  }else{
    xVel = 0;
    yVel = 0;
  }
}
void dead(){
    if(health < 0){
      death = true;
      curFrame = 5;
      tweets.add(new Tweet(price));
      if(tweets.size() % 15 == 0){
        tweet2.play();
      }else if(tweets.size() % 5 == 0){
        tweet1.play();
      }
      int rand = (int)random(0, grunts.size());
      while(rand == lastUsedDeathSound){
        rand = (int)random(0, grunts.size());
      }
      lastUsedDeathSound = rand;
      workerNum += price;
      grunts.get(rand).play();
      deadZombies.add(this);      //remove brackets
      zombies.remove(this);
    }
    if(x >= width){    //If passed through the screen
     zombies.remove(this);
    }
}
float getX() {  return x; }
float getY() {  return y; }
float getHealth() {  return health; }
float getXVelo() {  return xVel; }
float getInitXVelo() {  return initVelo; }
boolean getSpeedy() {  return isSpeedy; }
boolean getFire() {  return isBurning; }
boolean getShocked() {  return isShocked; }
boolean getFrozen() {  return isFrozen; }
boolean getInCombat() {  return inCombat; }
void setInCombat(boolean b) {  inCombat = b; }
void setHoarder(boolean b) {  hoarder = b; }
void setSpeedy(boolean s) {  isSpeedy = s; }
void setInitXVelo(float i) {  initVelo = i; }
void setXVelo(float x) {  xVel = x; }
void setX(float xP) {  x = xP; }
void setY(float yP) {  y = yP; }
void setHealth(float h) {  health = h; }
void setInitialHealth(float h) {  ogHealth = h; }
}

// ------------------------------------------------------------ S C R E A M E R   C L A S S -------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //

class Screamer implements Moveable{
float x;
float y;
float xVel, yVel, initVelo;
float health;
float ogHealth;
float zWidth;
boolean hoarder = true;
float time;
boolean isBurning = false;
float timeUnburn;
float timePosion = 0;
float timeShocked = 0;
boolean isShocked = false;
boolean isFrozen = false;
boolean inCombat = false;
float timeUnfreeze;
boolean isSpeedy = false;
float deathtime;
float timeSinceScream, timeReset;
boolean death;
boolean attacking = false;
int skin, price;
PImage[] frames = new PImage[11];
int curFrame = 0;

Screamer(float xPos, float yPos){
  x = xPos;
  y = yPos;
  health = 2;
  price = 5;
  ogHealth = health;
  xVel = random(1, 1.2);
  initVelo = xVel;
  curFrame = 0;
  frames = new PImage[] {s1walk1, s1walk2, s1freeze, s1burn, s1attack, s1scream, s1death1, s1death2, s1death3, s1death4, s1death5};
  yVel = 1;
  time = millis() + 500;
  timeSinceScream = millis() + (int)random(3000, 5000);
  timeReset = timeSinceScream;
  yVel = 0;
  death = false;
  zWidth = 10;
}

  void poisonHit(){
    timePosion = millis() + 2000;
  }

void shocked(){
    isShocked = true;
    timeShocked = millis() + 100;
}

void drawZombie(){
  if(millis() <= time){
    if(curFrame == 0){
    curFrame = 1;
    }else if(curFrame == 1){
      curFrame = 0;
    }
  }else{
    time = millis() + (int)random(20, 40);
  }
  
  
}
void burn(){
  isBurning = true;
  timeUnburn = millis() + COOL_TIME;
}

void freeze(){
  isFrozen = true;
  timeUnfreeze = millis() + THAW_TIME;
}

void display(){
  frames = new PImage[] {s1walk1, s1walk2, s1freeze, s1burn, s1attack, s1scream, s1death1, s1death2, s1death3, s1death4, s1death5};
  if (death == false){
    if(health < ogHealth / 6){
      fill(255, 0, 0);
    }else{
      fill(0, 255, 0);
    }
    if(health / ogHealth * 100 / 7 < 0){    //The health is negative
      //Don't display
    }else{    
      rect(x  + 5, y - 5, health / ogHealth * 100 / 7, 5);
    }
    image(frames[curFrame], x, y);
  }else{
    image(frames[curFrame], x, y);
  }
}

void update(){
  if(death == false){
    if(isFrozen == false){
      if(isBurning){    //If on fire
        curFrame = 3;    //Set zombie frame to burn
          Particle temp = new Particle(x + 6 + random(2, 5), y + 5 + random(0, 10), 'N');  //Add a flame
          particles.add(temp);
          health -= 0.1;
          temp = new Particle(x + 6 + random(2, 4), y + 7 + random(0, 2), 'T');                           //Add sut
          particles.add(temp);
        if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or set on fire
          curFrame = 0;
          
          if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or set on fire
            curFrame = 0;
            isBurning = false;
          }
        }
      }
      if(inCombat){
        //if in combat do nothing
      }else{
      if(isSpeedy){
        if(xVel > initVelo){
           xVel -= 0.02;
        }else{
          isSpeedy = false;
        }
      }
      if(hoarder){         //If the zombie is a hoarder
      int hoardCount = 0;
        for(int i = 0; i < zombies.size(); i++){                      //Find every zombie
        if(dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) <= 60){
          if(!zombies.get(i).equals(this)){                          //And it's not yourself, idiot
            hoardCount++;
          }
        }
          if(dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) <= 30 && dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) >= 5){    //That is 10 pixels close
          //if(dist(x, y, zombies.get(i).x, zombies.get(i).y) <= 30 && dist(x, y, zombies.get(i).x, zombies.get(i).y) >= 5){    //That is 10 pixels close
            if(!zombies.get(i).equals(this)){                          //And it's not yourself, idiot
              if (zombies.get(i).getY() > y){            //Move closer to that zombie
                y += 0.09;
                //y += yVel;
              }else if (zombies.get(i).getY() < y){
                y -= 0.09;
                //y -= yVel;
              }
              if (zombies.get(i).getXVelo() + 0.5 < xVel){            //Move closer to that zombie
                xVel -= 0.05;
              }else if (zombies.get(i).getXVelo() - 0.5 > xVel){            //Move closer to that zombie
                xVel += 0.05;
              }
            }
          }else{      //If not in hoard
            if(xVel < initVelo){
              xVel += 0.05;
            }else if(xVel > initVelo && !isSpeedy){
              xVel = initVelo;
            }
          }
        }
        x += xVel;
        
        if(hoardCount >= 4 && (millis() > timeReset)){      //If zombie is in a hoard with a count greater than 4
          curFrame = 2;
          screech1.play();
          isSpeedy = true;
          for(int i = 0; i < zombies.size(); i++){                      //Find every zombie that is close to you
            if(dist(x, y, zombies.get(i).getX(), zombies.get(i).getY()) <= 60){
              if(zombies.get(i).getXVelo() <= 3.0 * zombies.get(i).getInitXVelo()){
                zombies.get(i).setXVelo(zombies.get(i).getXVelo() * 2 + 1);
                if(zombies.get(i).getXVelo() <= 4){
                   zombies.get(i).setXVelo(5);
                }
                zombies.get(i).setSpeedy(true);
              }
            }
          }
          timeSinceScream = millis() + 5000;
          timeReset = millis() + 9000;
        }else if(millis() > timeSinceScream){
          curFrame = 0;
        }
        hoardCount = 0;
      }else{
          x += xVel;
          y += yVel;
      }
     }
    }else{      //if the zombie is frozen
      curFrame = 4;    //Set zombie frame to freeze
      if(millis() >= timeUnfreeze || isBurning){
        curFrame = 0;
        isFrozen = false;
      }
    }
    if(x >= width){    //If passed through the screen
     //x = 0;
     population -= 5;
    }
    if(millis() <= timePosion){
        health -= 0.2;
        int[] temp2 = {250, 154, 249};
        Particle temp = new Particle(x + random(3, 10), y + random(3, 10), random(1, 2.5), temp2);
        particles.add(temp);
      }
    if(millis() >= timeShocked){
      isShocked = false;
    }
  }else{
    xVel = 0;
    yVel = 0;
  }
}
void dead(){
    if(health < 0){
      death = true;
      if(curFrame < 6){
        curFrame = 6;
        deathtime = millis() + 150;
      }else{
        if(millis() >= deathtime){
          curFrame++;
          deathtime += 50;
        }
      }
      if(curFrame == 6){
      int rand = (int)random(0, grunts.size());
      while(rand == lastUsedDeathSound){
        rand = (int)random(0, grunts.size());
      }
      lastUsedDeathSound = rand;
      grunts.get(rand).play();
      }
      if(curFrame == 10){
        
      workerNum += price;
      tweets.add(new Tweet(price));
      deadZombies.add(this);
      zombies.remove(this);
      }
    }
    if(x >= width){    //If passed through the screen
     zombies.remove(this);
    }
}
float getX() {  return x; }
float getY() {  return y; }
float getHealth() {  return health; }
float getXVelo() {  return xVel; }
float getInitXVelo() {  return initVelo; }
boolean getSpeedy() {  return isSpeedy; }
boolean getFire() {  return isBurning; }
boolean getShocked() {  return isShocked; }
boolean getFrozen() {  return isFrozen; }
boolean getInCombat() {  return inCombat; }
void setInCombat(boolean b) {  inCombat = b; }
void setSpeedy(boolean s) {  isSpeedy = s; }
void setX(float xP) {  x = xP; }
void setY(float yP) {  y = yP; }
void setInitXVelo(float i) {  initVelo = i; }
void setXVelo(float x) {  xVel = x; }
void setHealth(float h) {  health = h; }
void setInitialHealth(float h) {  ogHealth = h; }
}

// ------------------------------------------------------------ R E I N F O R C E M E N T   C L A S S ---------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------- //

class Reinforcement implements Moveable{
float x;
float y;
float xVel, yVel, initVelo;
float health;
float ogHealth;
float zWidth;
boolean hoarder = true;
float damage = 0.1;
float time;
float timePosion = 0;
float timeShocked = 0;
boolean isBurning = false;
boolean inCombat = false;
float timeUnburn;
boolean isFrozen = false;
boolean isShocked = false;
float timeUnfreeze;
boolean isSpeedy = false;
float deathtime;
float timeSinceScream, timeReset;
boolean attacking = false;
boolean death;
int skin;
Moveable zombieInCombat = null;
PImage[] frames = new PImage[11];
int curFrame = 0;

Reinforcement(float xPos, float yPos){
  x = xPos;
  y = yPos;
  health = 5;
  ogHealth = health;
  xVel = random(-1.2, -1);
  initVelo = xVel;
  curFrame = 0;
  frames = new PImage[] {k1walk1, k1walk2, k1walk3, k1freeze, k1burn, k1death};
  time = millis() + 500;
  yVel = 0;
  death = false;
  zWidth = 10;
}

void poisonHit(){
    timePosion = millis() + 2000;
}

void drawZombie(){
  if(millis() <= time){  //Walking animation
    if(curFrame == 0){
    curFrame = 1;
    }else if(curFrame == 1){
      curFrame = 2;
    }else if(curFrame == 2){
      curFrame = 0;
    }
  }else{
    time = millis() + (int)random(20, 40);
  }
  
  
}
void burn(){
  isBurning = true;
  timeUnburn = millis() + COOL_TIME;
}

void shocked(){
    isShocked = true;
    timeShocked = millis() + 100;
}

void freeze(){
  isFrozen = true;
  timeUnfreeze = millis() + THAW_TIME;
}

void display(){
  frames = new PImage[] {k1walk1, k1walk2, k1walk3, k1freeze, k1burn, k1death};
  if (death == false){
    if(health < ogHealth / 6){
      fill(255, 0, 0);
    }else{
      fill(0, 255, 0);
    }
    if(health / ogHealth * 100 / 7 < 0){    //The health is negative
      //Don't display
    }else{    
      rect(x  + 5, y - 5, health / ogHealth * 100 / 7, 5);
    }
    image(frames[curFrame], x, y);
  }else{
    image(frames[curFrame], x, y);
  }
}

void update(){
  if(death == false){
    if(isFrozen == false){
      if(isBurning){    //If on fire
        curFrame = 4;    //Set knight frame to burn
          Particle temp = new Particle(x + 6 + random(2, 5), y + 5 + random(0, 10), 'N');  //Add a flame
          particles.add(temp);
          health -= 0.1;
          temp = new Particle(x + 6 + random(2, 4), y + 7 + random(0, 2), 'T');                           //Add sut
          particles.add(temp);
        if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or set on fire
          curFrame = 0;
          
          if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or set on fire
            curFrame = 0;
            isBurning = false;
          }
        }
      }else{
        if(zombieInCombat == null){      //if we havne't found a zombie yet
          for(int i = 0; i < zombies.size(); i++){    //find every zombie
            if(!zombies.get(i).equals(this) && !(zombies.get(i) instanceof Reinforcement)){                          //And it's not yourself, idiot
              if(zombies.get(i) instanceof Refugee){ 
                if(((Refugee)zombies.get(i)).marked == false){
                  if(zombies.get(i).getInCombat() == false){
                    if(((Refugee)zombies.get(i)).marked == false){
                      if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= 10 && zombies.get(i).getInCombat() == false){ //If we found one that's close
                        attacking = true;
                        zombieInCombat = zombies.get(i);
                        zombies.get(i).setInCombat(true);
                      }else if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= 30){ //If we found one that's close
                        if(zombies.get(i).getX() > x){
                          x += xVel;
                        }else if(zombies.get(i).getX() < x){
                          x -= xVel;
                        }
                        if(zombies.get(i).getY() > y){
                          y++;
                        }else if(zombies.get(i).getY() < y){
                          y--;
                        }
            
                      }else{
                        //attacking = false;
                      }
                    }
                  }
              }
              }else{
                if(zombies.get(i).getInCombat() == false){
                    if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= 10 && zombies.get(i).getInCombat() == false){ //If we found one that's close
                      attacking = true;
                      zombieInCombat = zombies.get(i);
                      zombies.get(i).setInCombat(true);
                    }else if(dist(zombies.get(i).getX(), zombies.get(i).getY(), x, y) <= 30){ //If we found one that's close
                      if(zombies.get(i).getX() > x){
                        x += xVel;
                      }else if(zombies.get(i).getX() < x){
                        x -= xVel;
                      }
                      if(zombies.get(i).getY() > y){
                        y++;
                      }else if(zombies.get(i).getY() < y){
                        y--;
                      }
          
                    }else{
                      //attacking = false;
                    }
                }
              }
            }
          }
        }else{    //if we've found a zombie
          if(zombieInCombat.getHealth() < 0){
            attacking = false;
            zombieInCombat = null;
          }else{
            zombieInCombat.setHealth(zombieInCombat.getHealth() - (damage + random(0, damage)));
            if(zombieInCombat.getFrozen() == false){      //Dont hurt yourself if zombie is frozen
              health -= random(0, 0.1);
            }
          }
        }
        if(!attacking){  //If not in combat
          x += xVel;
          y += yVel;
        }
        
        
      }
    }else{      //if the zombie is frozen
      curFrame = 3;    //Set zombie frame to freeze
      if(millis() >= timeUnfreeze || isBurning){
        curFrame = 0;
        isFrozen = false;
      }
    }
    if(millis() <= timePosion){
        health -= 0.2;
        int[] temp2 = {250, 154, 249};
        Particle temp = new Particle(x + random(3, 10), y + random(3, 10), random(1, 2.5), temp2);
        particles.add(temp);
    }
    if(millis() >= timeShocked){
      isShocked = false;
    }
    if(x >= width){
     x = 0; 
    }
  }
  
}
void dead(){
    if(health < 0){
      if(zombieInCombat != null){
        zombieInCombat.setInCombat(false);
      }
      death = true;
      if(curFrame < 5){
        curFrame = 5;
      }
      if(curFrame == 5){
      int rand = (int)random(0, grunts.size());
      while(rand == lastUsedDeathSound){
        rand = (int)random(0, grunts.size());
      }
      lastUsedDeathSound = rand;
      grunts.get(rand).play();
      }
      if(curFrame == 5){
      deadZombies.add(this);
      zombies.remove(this);
      }
    }
    if(x <= 0){
    zombies.remove(this);
    }
}
float getX() {  return x; }
float getY() {  return y; }
float getHealth() {  return health; }
float getXVelo() {  return xVel; }
float getInitXVelo() {  return initVelo; }
boolean getSpeedy() {  return isSpeedy; }
boolean getFire() {  return isBurning; }
boolean getShocked() {  return isShocked; }
boolean getFrozen() {  return isFrozen; }
boolean getInCombat() {  return inCombat; }
void setInCombat(boolean b) {  inCombat = b; }
void setX(float xP) {  x = xP; }
void setY(float yP) {  y = yP; }
void setSpeedy(boolean s) {  isSpeedy = s; }
void setInitXVelo(float i) {  initVelo = i; }
void setXVelo(float x) {  xVel = x; }
void setHealth(float h) {  health = h; }
void setInitialHealth(float h) {  ogHealth = h; }
}


// ------------------------------------------------------------ G U T T E R   C L A S S ---------------------------------------------------------------- //


class Gutter implements Moveable{
float x;
float y;
float xVel, yVel, initVelo;
float health;
float ogHealth;
float zWidth;
boolean hoarder = false;
float time;
boolean isBurning = false;
boolean inCombat = false;
boolean isShocked = false;
boolean inOffense = false;
float timePosion = 0;
float timeShocked = 0;
float timeUnburn;
boolean isFrozen = false;
float timeUnfreeze;
boolean isSpeedy = false;
float deathtime;
float timeSinceAttack, timeReset;
boolean death;
int skin, price;
PImage[] frames = new PImage[11];
int curFrame = 0;

Gutter(float xPos, float yPos){
  x = xPos;
  y = yPos;
  price = 25;
  health = 400;
  ogHealth = health;
  xVel = random(0.2, 0.4);
  initVelo = xVel;
  curFrame = 0;
  frames = new PImage[] {b1walk1, b1walk2, b1walk3, b1freeze, b1burn, b1attack1, b1attack2, b1attack3, b1death1, b1death2, b1death3, b1death4, b1death5, b1death6, b1death7, b1death8, b1death9, b1death10, b1death11, b1death12, b1death13, b1death14, b1death15, b1death16, b1death17, b1death18, b1death19, b1death20, b1death21};
  yVel = 1;
  time = millis() + 500;
  timeSinceAttack = millis() + (int)random(3000, 5000);
  timeReset = timeSinceAttack;
  yVel = 0;
  death = false;
  zWidth = 10;
}

void poisonHit(){
  timePosion = millis() + 2000;
}

void shocked(){
    isShocked = true;
    timeShocked = millis() + 100;
}

void drawZombie(){
  if(millis() >= time){
    if(curFrame == 0){
    curFrame = 1;
    }else if(curFrame == 1){
      curFrame = 2;
    }else if(curFrame == 2){
      curFrame = 0;
    }
    time = millis() + (int)random(500, 600);
  }
  
  
}
void burn(){
  isBurning = true;
  timeUnburn = millis() + COOL_TIME;
}

void freeze(){
  isFrozen = true;
  xVel = initVelo / 2;
  timeUnfreeze = millis() + THAW_TIME;
}

void display(){
  frames = new PImage[] {b1walk1, b1walk2, b1walk3, b1freeze, b1burn, b1attack1, b1attack2, b1attack3, b1death1, b1death2, b1death3, b1death4, b1death5, b1death6, b1death7, b1death8, b1death9, b1death10, b1death11, b1death12, b1death13, b1death14, b1death15, b1death16, b1death17, b1death18, b1death19, b1death20, b1death21};
  if (death == false){
    if(health < ogHealth / 6){
      fill(255, 0, 0);
    }else{
      fill(0, 255, 0);
    }
    if(health / ogHealth * 100 / 5 < 0){    //The health is negative
      //Don't display
    }else{    
      rect(x - 12, y - 40, health / ogHealth * 100 / 5, 5);
    }
    image(frames[curFrame], x - 37 , y - 50);
  }else{
    image(frames[curFrame], x - 37, y - 50);
  }
}

void attack(){
  if (curFrame == 5 && millis() > timeReset - 300){
    curFrame = 6;
  }else if (curFrame == 6 && millis() > timeReset){
    curFrame = 0;
    inOffense = false;
  }
}

void update(){
  if(death == false){
    if(isFrozen == false){
      if(isBurning){    //If on fire
        curFrame = 4;    //Set zombie frame to burn
          Particle temp = new Particle(x - 14 + random(2, 5), y + random(0, 10), 'N');  //Add a flame
          particles.add(temp);
          health -= 0.1;
          temp = new Particle(x  - 14 + random(2, 4), y + random(0, 2), 'T');                           //Add sut
          particles.add(temp);
        if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or frozen
          curFrame = 0;
          temp = new Particle(x - 36 + random(2, 5), y + 5 + random(0, 10), 'N');  //Add a flame
          particles.add(temp);
          health -= 0.1;
          temp = new Particle(x  - 36 + random(2, 4), y + 7 + random(0, 2), 'T');                           //Add sut
          particles.add(temp);
          if(millis() >= timeUnburn || isFrozen){  //If cooldown time was reached, or set on fire
            curFrame = 0;
            isBurning = false;
          }
        }
      }
      if(isSpeedy){
        if(xVel > initVelo){
           xVel -= 0.02;
        }else{
          isSpeedy = false;
        }
      }
      if(curFrame == 5 || curFrame == 6){
        attack();
      }
      if(millis() > timeSinceAttack){
        for(int i =0 ; i < towersList.size(); i++){
          if(dist(towersList.get(i).x, towersList.get(i).y, x, y) < 30){
            curFrame = 5;
            timeReset = millis() + 600;
            attack();
            inOffense = true;
            bash.play();
            timeSinceAttack = millis() + 5000;
          }
        }
      }
        x += xVel;
        y += yVel;
      
    }else{      //if the zombie is frozen
      curFrame = 3;    //Set zombie frame to freeze
        x += xVel;
      if(millis() >= timeUnfreeze || isBurning){
        curFrame = 0;
        xVel = initVelo;
        isFrozen = false;
      }
    }
    if(x >= width){    //If passed through the screen
     //x = 0;
     population -= 25;
     enteredIn2.play();
    }
    if(millis() <= timePosion){
        health -= 0.2;
        int[] temp2 = {250, 154, 249};
        Particle temp = new Particle(x + random(3, 10), y + random(3, 10), random(1, 2.5), temp2);
        particles.add(temp);
      }
    if(millis() >= timeShocked){
      isShocked = false;
    }
  }else{
    xVel = 0;
    yVel = 0;
  }
}
void dead(){
    if(health < 0){
      death = true;
      if(curFrame < 8){
        curFrame = 8;
        deathtime = millis() + 150;
        guts1.play();
      }else{
        if(millis() >= deathtime){
          curFrame++;
          deathtime += 100;
        }
      }
      if(curFrame == 6){
      int rand = (int)random(0, grunts.size());
      while(rand == lastUsedDeathSound){
        rand = (int)random(0, grunts.size());
      }
      lastUsedDeathSound = rand;
      ;
      }
      if(curFrame == 28){
      tweets.add(new Tweet(price));
      workerNum += price;
      deadZombies.add(this);
      zombies.remove(this);
      }
    }
    if(x >= width){    //If passed through the screen
     zombies.remove(this);
    }
}
float getX() {  return x; }
float getY() {  return y; }
float getHealth() {  return health; }
float getXVelo() {  return xVel; }
float getInitXVelo() {  return initVelo; }
boolean getSpeedy() {  return isSpeedy; }
boolean getFire() {  return isBurning; }
boolean getShocked() {  return isShocked; }
boolean getFrozen() {  return isFrozen; }
boolean getInCombat() {  return inCombat; }
void setInCombat(boolean b) {  inCombat = b; }
void setSpeedy(boolean s) {  isSpeedy = s; }
void setX(float xP) {  x = xP; }
void setY(float yP) {  y = yP; }
void setInitXVelo(float i) {  initVelo = i; }
void setXVelo(float x) {  xVel = x; }
void setHealth(float h) {  health = h; }
void setInitialHealth(float h) {  ogHealth = h; }
}