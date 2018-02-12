//Each square of turf
class Grid{
 private float x;
 private float y;
 private float hei;       //Height
 private float wid;       //Width
 private boolean active;  //If active then it is being displayed on its own map
 int elevation;     //rip this
 int opacity;       //not relevant
 boolean taken;     //if occupied by an existing tower
 boolean  dragged = false;
 boolean hold;
 PImage grass;      //Holds the grass image
 int grassNum;      //For grass selection
 Tower tower;       //Holds a possible tower
 float opac = 60;
 
  public Grid(float xPos, float yPos){  //Create turf given an x and y location
      x = xPos;  //Set the turf square, set it to empty
      y = yPos;
      hei = 50;
      wid = 50;
      taken = false;
      active = false;
      hold = false;
      opacity = 255;
      elevation = getElevation((int)random(0, 3));  //Add elevation
      grassNum = ((int)random(0, 3));
      getTile(grassNum);  //Give the randomly selected tile
  }
  
  public Grid(float xPos, float yPos, float heightN, float widthN){  //Create turf given an x, y, width, and height location
      x = xPos;
      y = yPos;
      hei = heightN;
      taken = false;
      hold = false;
      active = false;
      wid = widthN;
      opacity = 255;
      elevation = getElevation((int)random(0, 3));
  }
  
  int getElevation(int e){  //Add elevation to each tile
    if(e == 1){
      grass = terrain1;
      return 10;
    }else if (e == 2){
      grass = terrain2;
      return 20;
    }else{
      grass = terrain3;
      return 30;
    }
  }
  
  void getTile(int e){  //Return grass image given #
    if(e == 1){
      grass = terrain1;
    }else if (e == 2){
      grass = terrain2;
    }else{
      grass = terrain3;
    }
  }
  
  void drawCell(){      //Draws cell
    fill(opacity, opacity, opacity, 255);
    rect(x, y, wid, hei);
    getTile(grassNum);     //Get the image
    noStroke();
    image(grass, x, y);    //draws the grass
    noStroke();
    if(opacity == 80){                        //Display darkened bubble if mouse over tile
      fill(opacity, opacity, opacity, opac);
      opac = opac * 0.98;                      //Descrease the opacity for fade effect
      rect(x, y, wid, hei, 20);
      if((mouseX > x) && (mouseX < x + wid) && (mouseY > y) && (mouseY < y + hei)){
        opac = 60;
      }
    }
  }
  
  boolean isShowing(){      //If tile is being drawn behind the phone, disable that tile
    if((x >= phone.x) && (x + wid <= phone.x + 220) && (y >= phone.y) && (y + hei <= phone.y + 400)){              //If tile is in phone range
      return false;        
    }else if((mouseX >= phone.x) && (mouseX<= phone.x + 220) && (mouseY >= phone.y) && (mouseY<= phone.y + 400)){  //If players mouse is in phone range
      return false;
    }else{
     return true;           //Otherwise function without interuption
    }
  }
  
  String toString(){
    return ("x:" + x + " and y:" + y);  //Display tiles x and y (testing)
  }
  
  void updateCell(int v){
    if(active){            //If enabled
      if(hold){            //When purchased
        if(removable){        //When the remove app is active
          opac = 60;          //Hihglight tile
        }
        if(removable && ((mouseX > x) && (mouseX < x + wid) && (mouseY > y) && (mouseY < y + hei))){  //If remove app is active and mouse is over tile
            opacity = 0;    //Darken
            opac = 60;
            if(mousePressed){           //If removed
              opacity = elevation;      //remove a holding square
              for(int i = 0; i < towersList.size(); i++){  //Find every existing tower
                if(towersList.get(i).home == this){        //That calls this tile home
                  towersList.remove(i);                    //Remove it from towers list
                }
              }
              hold = false;                                //Free up tile again
            }
        }else{
            opacity = 80;                                   //Be purchased
        }
      }else{        //If free (i.e. not purchased)
        if((mouseX > x) && (mouseX < x + wid) && (mouseY > y) && (mouseY < y + hei)){  //When selected, highlight
        if(removable == false){
          if((mousePressed) && (isShowing() == true) && (purchasingTower)){    //If clicked
            //hold = true;       //Be purchased
            //Create tower
            if(tutorialStage == 2){
                if(mouseX >= 250 && mouseX <= (250 + (width - 295)) && mouseY > 265 && mouseY <= 315){
                if(purchasedTower == 0){    ///If it was an artillery tower    //if broken replace purchasedTower with phone.getTowerCycle() == 0
                hold = true;       //Be purchased
                //build artillery towers
                ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
                sprites.add(art1);
                sprites.add(art2);
                sprites.add(art3);
                sprites.add(art4);
                sprites.add(art5);
                sprites.add(art6);
                sprites.add(art7);
                sprites.add(art8);
                Artillery newArtillery = new Artillery(mouseX, mouseY, sprites, this, 50.0);  //Create new Artillery tower at mouse location
                towersList.add(newArtillery);                                                 //Add to towers list
                temptimer = millis() + 100;
                tutorialStage++;  //Advance to the next tutorial
                purchasingTower = false;                                                       //Set tile to purchased
              }
            }
            }else if(tutorialStage == 8){
                if(mouseX >= 250 && mouseX <= (250 + (width - 295)) && mouseY > 115 && mouseY <= 165){  //250, 115, width - 295, 50, 10
                if(purchasedTower == 1){    ///If it was an artillery tower    //if broken replace purchasedTower with phone.getTowerCycle() == 0
                hold = true;       //Be purchased
                //build writers tent
                ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
                sprites.add(wri1);
                sprites.add(wri2);
                sprites.add(wri3);
                sprites.add(wri4);
                sprites.add(wri5);
                sprites.add(wri6);
                Writer newWriter = new Writer(mouseX, mouseY, sprites, this);                 //Create new Writers Tent at mouse location
                towersList.add(newWriter);                                                    //Add to towers list
                temptimer = millis() + 100;
                tutorialStage++;  //Advance to the next tutorial
                purchasingTower = false;                                                      //Set tile to purchased
              }
            }
            }else if(tutorialStage == 28){
                //build hostel
                if(mouseX >= 250 && mouseX <= (250 + (width - 295)) && mouseY > 365 && mouseY <= 415){  //250, 115, width - 295, 50, 10
                if(purchasedTower == 2){    ///If it was an artillery tower    //if broken replace purchasedTower with phone.getTowerCycle() == 0
                ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
                hold = true;       //Be purchased
                sprites.add(hos1);
                sprites.add(hos2);
                sprites.add(hos3);
                sprites.add(hos4);
                sprites.add(hos5);
                sprites.add(hos6);
                sprites.add(hos7);
                sprites.add(hos8);
                Hostel newHostel = new Hostel(mouseX, mouseY, sprites, this);                 //Create new Hostel at mouse location
                towersList.add(newHostel);                                                    //Add to towers list
                purchasingTower = true;                                                       //Set tile to purchased
                tutorialStage++;                                                              //Advance to the next tutorial  
                zombieTiming = millis() + random(500, 2500);                                  //Adds timer for zombie spawn
                }
            }
            }else{
              if(purchasedTower == 0){    ///If it was an artillery tower    //if broken replace purchasedTower with phone.getTowerCycle() == 0
                //build artillery towers
                hold = true;       //Be purchased
                ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
                sprites.add(art1);
                sprites.add(art2);
                sprites.add(art3);
                sprites.add(art4);
                sprites.add(art5);
                sprites.add(art6);
                sprites.add(art7);
                sprites.add(art8);
                Artillery newArtillery = new Artillery(mouseX, mouseY, sprites, this, 50.0);  //Create new Artillery tower at mouse location
                towersList.add(newArtillery);                                                 //Add to towers list
                purchasingTower = true;                                                       //Set tile to purchased
              }else if(purchasedTower == 1){    ///If it was an writers tent
                //build writers tent
                hold = true;       //Be purchased
                ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
                sprites.add(wri1);
                sprites.add(wri2);
                sprites.add(wri3);
                sprites.add(wri4);
                sprites.add(wri5);
                sprites.add(wri6);
                Writer newWriter = new Writer(mouseX, mouseY, sprites, this);                 //Create new Writers Tent at mouse location
                towersList.add(newWriter);                                                    //Add to towers list
                purchasingTower = true;                                                       //Set tile to purchased
              }else if(purchasedTower == 2){    ///If it was an hostel tower
                //build hostel
                hold = true;       //Be purchased
                ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
                sprites.add(hos1);
                sprites.add(hos2);
                sprites.add(hos3);
                sprites.add(hos4);
                sprites.add(hos5);
                sprites.add(hos6);
                sprites.add(hos7);
                sprites.add(hos8);
                Hostel newHostel = new Hostel(mouseX, mouseY, sprites, this);                 //Create new Hostel at mouse location
                towersList.add(newHostel);                                                    //Add to towers list
                purchasingTower = true;                                                       //Set tile to purchased
              }else if(purchasedTower == 3){    ///If it was an factory tower
                //build factory
                hold = true;       //Be purchased
                ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
                sprites.add(fac1);
                sprites.add(fac2);
                sprites.add(fac3);
                sprites.add(fac4);
                sprites.add(fac5);
                sprites.add(fac6);
                sprites.add(fac7);
                sprites.add(fac8);
                Chainsaw newFactory = new Chainsaw(mouseX, mouseY, sprites, this);            //Create new Factory at mouse location
                towersList.add(newFactory);                                                   //Add to towers list
                purchasingTower = true;                                                       //Set tile to purchased
         }
              if(phone.locked == true){
                if(workerNum - towers.get(phone.towersCycle).getPrice() < 0){
                  phone.locked = false;
                  purchasingTower = false;
                }else{
                  purchasingTower = true;    //If phone is locked indicate we still want to make another tower
                  workerNum -= towers.get(phone.towersCycle).getPrice();
                }
              }else{
                purchasingTower = false;
                //deployableName = "";
              }
            }
          }
          if(isShowing() == true){
            opacity = 150;       //If not clicked
            taken = true;        //Highlight
          }
        }else{
          if(isShowing() == true){
            opacity = 0;       //If not clicked
            taken = false;        //Highlight
          }
        }
        }else{
          taken = false;       //Resting color
          opacity = elevation;
        }
      }
    }
  }
  
  //Accessor and mutator methods
  public float getX(){ return x; }
  public float getY(){ return y; }
  public float getHeight(){ return hei; }
  public boolean getActive(){ return active; }
  public float getWidth(){ return wid; }
  public boolean getTaken(){ return taken; }
  public boolean getHold(){ return hold; }
  
  public void setHold(boolean v){ hold = v; }
  public void setActive(boolean b){ active = b; }
  
  
}