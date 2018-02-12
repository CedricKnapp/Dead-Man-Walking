class TowerUI{
  ArrayList<TowerButton> towerButtons = new ArrayList<TowerButton>();
  Tower tower;
  int numBubbles;  
  float UI_PADDING = 10.0f;
  float interval = 1.06f;
  final float UI_PADDING_MAX = 30.0f;
  PImage icon1 = null;
  PImage icon2 = null;
  PImage icon3 = null;
  PImage icon4 = null;
  Upgrade upgrade1 = null;
  Upgrade upgrade2 = null;
  Upgrade upgrade3 = null;
  Upgrade upgrade4 = null;
  float upgradePrice = 30;
 
  TowerUI(Tower tower, int numBubbles, PImage i1, Upgrade u1, PImage i2, Upgrade u2){
    this.tower = tower;
    this.numBubbles = 2;
    icon1 = i1;
    icon2 = i2;
    upgrade1 = u1;
    upgrade2 = u2;
    createBubbles();
  }
  
  TowerUI(Tower tower, int numBubbles, PImage i1, Upgrade u1, PImage i2, Upgrade u2, PImage i3, Upgrade u3){
    this.tower = tower;
    this.numBubbles = 3;
    icon1 = i1;
    icon2 = i2;
    icon3 = i3;
    upgrade1 = u1;
    upgrade2 = u2;
    upgrade3 = u3;
    createBubbles();
  }
  
  TowerUI(Tower tower, int numBubbles, PImage i1, Upgrade u1, PImage i2, Upgrade u2, PImage i3, Upgrade u3, PImage i4, Upgrade u4){
    this.tower = tower;
    this.numBubbles = 4;
    icon1 = i1;
    icon2 = i2;
    icon3 = i3;
    icon4 = i4;
    upgrade1 = u1;
    upgrade2 = u2;
    upgrade3 = u3;
    upgrade4 = u4;
    createBubbles();
  }
  
  void addUpgrade(PImage i3, Upgrade u3){
    icon3 = i3;
    numBubbles = 3;
    upgrade3 = u3;
    towerButtons.clear();
    createBubbles();
  }
  
  void setUpgrade(Upgrade u){
    if(u.nextUpgrade != null){
      if(upgrade1.equals(u)){
        upgrade1 = u.nextUpgrade;
        icon1 = upgrade1.icon;
      }else if(upgrade2.equals(u)){
        upgrade2 = u.nextUpgrade;
        icon2 = upgrade2.icon;
      }else if(upgrade3 != null){
         if(upgrade3.equals(u)){
           upgrade3 = u.nextUpgrade;
           icon3 = upgrade3.icon;
         }
      }else if(upgrade4 != null){
         if(upgrade4.equals(u)){
           upgrade4 = u.nextUpgrade;
           icon4 = upgrade4.icon;
         }
      }
    }
  }
  
  void setIcon(int n, PImage p){
    if(n == 1){
      icon1 = p;
    }else if(n == 2){
      icon2 = p;
    }else if(n == 3){
      icon3 = p;
    }else if(n == 4){
      icon4 = p;
    }
  }
  
  void createBubbles(){
    switch(numBubbles){
      case 2:
        towerButtons.add(new TowerButton(tower.x+tower.construct.get(0).width + UI_PADDING,tower.y-7, upgrade1.price, tower, upgrade1, 1)); //Adds a button right of the tower
        towerButtons.add(new TowerButton(tower.x-tower.construct.get(0).width - UI_PADDING,tower.y-7, upgrade2.price, tower, upgrade2, 2)); //Adds a button left of the tower
        break;
      case 3:
        towerButtons.add(new TowerButton(tower.x+tower.construct.get(0).width + UI_PADDING,tower.y-7, upgrade1.price, tower, upgrade1, 1)); //Adds a button right of the tower icon1,
        towerButtons.add(new TowerButton(tower.x-tower.construct.get(0).width - UI_PADDING,tower.y-7, upgrade2.price, tower, upgrade2, 2)); //Adds a button left of the tower, icon2
        towerButtons.add(new TowerButton(tower.x,tower.y-tower.construct.get(0).height - UI_PADDING-12.5, upgrade3.price, tower, upgrade3, 3)); //Adds a button above of the tower icon3,
        break;
      case 4:
        towerButtons.add(new TowerButton(tower.x+tower.construct.get(0).width + UI_PADDING,tower.y-7, upgrade1.price, tower, upgrade1, 1)); //Adds a button right of the tower
        towerButtons.add(new TowerButton(tower.x-tower.construct.get(0).width - UI_PADDING,tower.y-7, upgrade2.price, tower, upgrade2, 2)); //Adds a button left of the tower
        towerButtons.add(new TowerButton(tower.x,tower.y-tower.construct.get(0).height - UI_PADDING-12.5, upgrade3.price, tower, upgrade3, 3)); //Adds a button above of the tower
        towerButtons.add(new TowerButton(tower.x,tower.y+tower.construct.get(0).height + UI_PADDING-12.5, upgrade4.price, tower, upgrade4, 4)); //Adds a button below of the tower
        break;
    }
  }
  
  void updateTowerUI(){
    if(UI_PADDING_MAX - UI_PADDING < 10 && interval > 0){
      if(interval > 1){
        interval *= 0.98;
      }else{
        interval = 1;
      }
    }
    if(UI_PADDING < UI_PADDING_MAX){
      UI_PADDING *= interval;
      for(int i = 0; i < towerButtons.size(); i++){
        if(i == 0){
          towerButtons.get(i).setX(tower.x+tower.construct.get(0).width + UI_PADDING);
        }else if(i == 1){
          towerButtons.get(i).setX(tower.x-tower.construct.get(0).width - UI_PADDING);
        }else if(i == 2){
          towerButtons.get(i).setY(tower.y-tower.construct.get(0).height - UI_PADDING-12.5);
        }else{
          towerButtons.get(i).setY(tower.y+tower.construct.get(0).height + UI_PADDING-12.5);
        }
      }
      
    }else if(UI_PADDING > UI_PADDING_MAX){
      UI_PADDING = UI_PADDING_MAX;
      interval = 1.06;
      for(int i = 0; i < towerButtons.size(); i++){
        if(i == 0){
          towerButtons.get(i).setX(tower.x+tower.construct.get(0).width + UI_PADDING);
        }else if(i == 1){
          towerButtons.get(i).setX(tower.x-tower.construct.get(0).width - UI_PADDING);
        }else if(i == 2){
          towerButtons.get(i).setY(tower.y-tower.construct.get(0).height - UI_PADDING-12.5);
        }else{
          towerButtons.get(i).setY(tower.y+tower.construct.get(0).height + UI_PADDING-12.5);
        }
      }
    }
    for(int i = 0; i < towerButtons.size(); i++){
      if(towerButtons.get(i).getOpac() < 150){
        towerButtons.get(i).setOpac(towerButtons.get(i).getOpac() + 4);
      }
    }
    if (!tower.isCovered){
      for(TowerButton t: towerButtons){t.drawTowerButton(t.upgrade.icon);}
    }
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ T O W E R   B U T T O N   C L A S S ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class TowerButton{
  final float TOWER_BUTTON_SIZE = 40;
  int id;
  boolean isClicked;
  boolean isHovered = false;
  boolean isMaxed;
  float x, y;
  float opac = 0;
  float price;
  Tower tower;
  Upgrade upgrade;
  PImage image;
  
   TowerButton(float x, float y, float price, Tower t, Upgrade u, int i){
    this.x = x;
    this.y = y;
    this.price = price;
    isClicked = false;
    tower = t;
    id = i;
    upgrade = u;
    this.image = u.icon;
    if(clickedTower != null){
      if(id == 1){
        if(clickedTower.maxed1 == true){
          isMaxed = true;
        }else{
          isMaxed = false;
        }
      }else if(id == 2){
        if(clickedTower.maxed2 == true){
          isMaxed = true;
        }else{
          isMaxed = false;
        }
      }if(id == 3){
        if(clickedTower.maxed3 == true){
          isMaxed = true;
        }else{
          isMaxed = false;
        }
      }if(id == 4){
        if(clickedTower.maxed4 == true){
          isMaxed = true;
        }else{
          isMaxed = false;
        }
      }
    }
  }
  
  float getX(){ return x; }
  float getY(){ return y; }
  void setY(float yP){ y = yP; }
  void setX(float xP){ x = xP; }
  float getOpac(){ return opac; }
  void setOpac(float op){ opac = op; }
  
  boolean isHovered(){
    if (dist(mouseX,mouseY,x,y) < TOWER_BUTTON_SIZE / 2){ return true; }
    else{ return false; }
  }
  
  boolean hovered(){
    /*
    if(upgrade.maxed == false && millis() > upgradeCooldown && workerNum > price && mousePressed){
      upgrade.tower1 = tower;    //Apply upgrade
      workerNum -= price; 
      upgrade.applyUpgrade();
      upgradeCooldown = millis() + 500;
      clickedTower.towerUI.setUpgrade(upgrade);
      image = upgrade.icon;
      if(upgrade.nextUpgrade == null){
        upgrade.maxed = true;
      }else{
        println(upgrade.nextUpgrade.desc);
        upgrade = upgrade.nextUpgrade;
      }
      //drawTowerButton();x
      //print(upgrade.desc);
    }
    
    */
    
    if (dist(mouseX,mouseY,x,y) < TOWER_BUTTON_SIZE / 2){ 
      if(mousePressed){
        //Create new tower UI
      }
      return true; 
    }
    else{ return false; }
  }
  
  void isClicked(boolean b){
    isClicked = b;
    if(b == true && isMaxed == false && millis() > upgradeCooldown && workerNum >= price){
      upgrade.tower1 = tower;    //Apply upgrade
      workerNum -= price; 
      upgrade.applyUpgrade();
      upgradeCooldown = millis() + 10;
      clickedTower.towerUI.setUpgrade(upgrade);
      image = upgrade.icon;
        if(clickedTower.maxed1 == false && id == 1){
          if(upgrade.nextUpgrade == null){
            clickedTower.maxed1 = true;
            isMaxed = true;
          }else{
            upgrade = upgrade.nextUpgrade;
          }
        }else if(clickedTower.maxed2 == false && id == 2){
          if(upgrade.nextUpgrade == null){
            clickedTower.maxed2 = true;
            isMaxed = true;
          }else{
            upgrade = upgrade.nextUpgrade;
          }
        }if(clickedTower.maxed3 == false && id == 3){
          if(upgrade.nextUpgrade == null){
            isMaxed = true;
            clickedTower.maxed3 = true;
          }else{
            upgrade = upgrade.nextUpgrade;
          }
        }if(clickedTower.maxed4 == false && id == 4){
          if(upgrade.nextUpgrade == null){
            clickedTower.maxed4 = true;
            isMaxed = true;
          }else{
            upgrade = upgrade.nextUpgrade;
          }
        }
    }
  }
  
  void drawTowerButton(PImage newIcon){
    //Sets the fill depending if the button is highlighted
    if (isHovered()){
      fill(#3EF702,opac);
      isHovered = true;
    }
    else{
      fill(#75FF48,opac);
      isHovered = false;
    }
    ellipse(x, y, TOWER_BUTTON_SIZE, TOWER_BUTTON_SIZE);
    tint(255,opac + 25);
    
    if(isMaxed){
     tint(255,0,0,175);
    }
    image(newIcon,x-TOWER_BUTTON_SIZE/2+5,y-TOWER_BUTTON_SIZE/2+5);
    fill(0);
    textSize(14);
    text((int)price, x, y+TOWER_BUTTON_SIZE-7); 
  }
  
}

class Description{
  float x, y;
  String desc;
  float opac;
  float wid, hei;
    Upgrade upgrade;
  
  Description(float xP, float yP, String d, Upgrade u){
    x = xP;
    y = yP;
    desc = d;
    wid = 7;
    upgrade = u;
    for(int i = 0; i < desc.length(); i++){
      if(desc.charAt(i) == 'm' || desc.charAt(i) == 'w'){
        wid += 9;
      }else if(desc.charAt(i) == 't' ||desc.charAt(i) == 'y' || desc.charAt(i) == 'k'){
        wid += 9;
      }else if(desc.charAt(i) == 'A' ||desc.charAt(i) == 'S' || desc.charAt(i) == 'C'){
        wid += 9;
      }else{
        wid += 6;
      }
    }
    
    hei = 12;
  }
  
  void drawDescription(){
    if(x + textWidth(desc) + 6 >= width - 10){
      x = x - textWidth(desc) - 4;
    }
    textFont(smallFont);
    textAlign(LEFT);
    fill(255, 200);
    rect(x - 2, y - 22, textWidth(desc) + 6, 16, 3);
    fill(0);
    text(desc, x, y - 10);
    
  }
  void updateDescription(){
    
  }
}