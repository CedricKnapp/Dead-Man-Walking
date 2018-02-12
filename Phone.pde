//Create a dynamic phone that the user can interact with
class Phone{
  boolean visible;
  float y;
  float x = 70;
  float lowestPoint = 580;
  String stage; 
  int towersCycle;
  boolean locked = false;
  float buttonXx;
  float buttonXy;
  
  float button1x;
  float button1y;
  float button2x;
  float button2y;
  float button3x;
  float button3y;
  float button4x;
  float button4y;
  float buttonDelX;
  float buttonDelY;
  float buttonWidth = 40;
  float buttonExit = 20;
  float highestPoint = 360;
  
  float buttonBuildLeftX = 107;
  float buttonBuildLeftY = y + 120;
  float buttonBuildRightX = 253;
  float buttonBuildRightY = y + 120;
  
  Phone(){      //Create the phone and initalize values
    y = 360;
    visible = false;
    stage = "main";
    button1x = 120;
    button2x = 240;
    button3x = 120;
    button4x = 240;
    button1y = y + 90;
    button2y = y + 90;
    button3y = y + 190;
    button4y = y + 190;
    buttonXx = 260;
    buttonXy = y + 70;
    buttonDelX = 180;
    buttonDelY = y + 120;
    
    buttonBuildLeftX = 107;
    buttonBuildLeftY = y + 120;
    buttonBuildRightX = 253;
    buttonBuildRightY = y + 120;
    
    towersCycle = 0;
  }
  
  void drawPhone(){
    tint(255, 255);
    fill(#70A579);
    rect(70, y, 220, 420);
    ellipse(70 + 20, y, 40, 40);
    ellipse(270, y, 40, 40);
    rect(70 + 20, y - 20, 180, 30);
    fill(25);
    rect(80, y + 50, 200, 400);
    fill(40);
    triangle(280, y + 50, 280, y + 400, 90, y + 300);
    if(stage == "main"){      //home screen
      fill(50, 210, 50);
      button1x = 120;
      button1y = y + 90;
      ellipse(button1x, button1y,buttonWidth, buttonWidth);
      image(buildIcon, button1x - 20, button1y - 20);
      fill(210, 50, 50);
      button2x = 240;
      button2y = y + 90;
      ellipse(button2x, button2y, buttonWidth, buttonWidth);
      image(recallIcon, button2x - 20, button2y - 20);
      fill(210, 210, 50);
      button3x = 120;
      button3y = y + 190;
      ellipse(button3x, button3y, buttonWidth, buttonWidth);
      image(helpIcon, button3x - 20, button3y - 17);
      fill(50, 210, 210);
      button4x = 240;
      button4y = y + 190;
      ellipse(button4x, button4y, buttonWidth, buttonWidth);
      image(splitterIcon, button4x - 20, button4y - 20);
      if(tweets.size() > 0){
        fill(#FA0000);
        ellipse(button4x + 16, button4y - 16, 18, 18);
        fill(255);
        textSize(14);
        textAlign(CENTER);
        if(tweets.size() <= 99){
          text(tweets.size(), button4x + 15, button4y - 10);
        }else{
          text("99+", button4x + 15, button4y - 10);
        }
      }
    }else if(stage == "build"){      //build screen
      fill(210, 50, 50);
      buttonXx = 260;
      buttonXy = y + 70;
      buttonBuildLeftX = 107;
      buttonBuildLeftY = y + 120;
      buttonBuildRightX = 253;
      buttonBuildRightY = y + 120;
      ellipse(buttonXx, buttonXy, buttonExit, buttonExit);
      
      if(purchasingTower || purchasingDeployable){
        fill(#85FF64);
        rect(90, y + 60, 50, 20, 30);
        fill(255);
        textSize(14);
        textAlign(CENTER);
        text("PLACE", 115, y + 75);
      }
      fill(90);                      //Draw Build Menu UI
      rect(90, y + 190, 180, 95, 5);
      fill(#D8D13D);
      ellipse(180, y + 120, 90, 90);  //Draw Outer Circle
      fill(#C1821B);
      ellipse(180, y + 120, 80, 80);  //Draw Inner Circle
      
      if(locked){
        fill(#2EFF8A);                  //Draw lock button true
      }else{
        fill(#8E0005);                  //Draw lock button false
      }
      ellipse(180, y + 62, 20, 20);    //Lock button (draw lock image)
      if(locked){
        image(lockedIcon, 170, y + 52);
      }else{
        image(unlockedIcon, 170, y + 52);                  //Draw lock button false
      }
      image(towers.get(towersCycle).getIcon(), 135, y + 76);
      textSize(16);
    if(workerNum >= towers.get(towersCycle).getPrice()){
      fill(#34E505);
    }else{
      fill(#FF0818);
    }
    if(towersCycle >= 4){  //If we are not looking at a tower, display the cost lower
      text(towers.get(towersCycle).getPrice(), 180, y + 185);    //Get icon for tower
    }else{
      text(towers.get(towersCycle).getPrice(), 180, y + 150);    //Get icon for tower
    }
      fill(#D8D13D);
      ellipse(buttonBuildLeftX, buttonBuildLeftY, 40, 40);  //Left button
      ellipse(buttonBuildRightX, buttonBuildRightY, 40, 40);  //Right button
      textFont(medFont);
      String name;
      if(towersCycle == 0){
        name = "ARTILLERY";
      }else if(towersCycle == 1){
        name = "WRITER'S TENT";
      }else if(towersCycle == 2){
        name = "HOSTEL";
      }else if(towersCycle == 3){
        name = "CHAINSAW FACTORY";
      }else if(towersCycle == 4){
        name = "REINFORCEMENTS";
      }else if(towersCycle == 5){
        name = "FREEZE GRENADE";
      }else{
        name = "MOLOTOV";
      }
      fill(255);
      textSize(15);
      textAlign(CENTER);
      text(name, 180, y + 205);
      rect(100, y + 210, 160, 1);
      fill(255);
      triangle(114, y + 130, 114, y + 110, 97, y + 120);
      triangle(246, y + 130, 246, y + 110, 263, y + 120);
      
    }else if(stage == "destroy"){      //home screen
      fill(210, 50, 50);
      buttonXx = 260;
      buttonXy = y + 70;
      buttonDelX = 180;
      buttonDelY = y + 120;
      ellipse(buttonXx, buttonXy, buttonExit, buttonExit);
      fill(#98201A);
      ellipse(buttonDelX, buttonDelY, 90, 90);  //Draw Outer Circle
      if(removable == false){
        fill(#620F0C);
      }else{
        fill(#F5251E);
      }
      ellipse(buttonDelX, buttonDelY, 80, 80);  //Draw Inner Circle
      image(trashIcon, buttonDelX - 45, buttonDelY - 45);
      
    }else if(stage == "splitter"){      //home screen
      fill(210, 50, 50);
      buttonXx = 260;
      buttonXy = y + 70;
      ellipse(buttonXx, buttonXy, buttonExit, buttonExit);
      
      displayTweet();
    }else if(stage == "help"){      //home screen
      fill(210, 50, 50);
      buttonXx = 260;
      buttonXy = y + 70;
      ellipse(buttonXx, buttonXy, buttonExit, buttonExit);
      if(panels.size() > 0){                                              //If there is something to display
        fill(255, 50);                                                    //Create faded square
        rect(buttonXx - 120, buttonXy + 20, 80, 80, 4);
        ellipse(buttonXx - 10, buttonXy + 60, 20, 20);                    //As well as cycle left and right buttons
        ellipse(buttonXx - 150, buttonXy + 60, 20, 20);    
        image(arrowRight, buttonXx - 20, buttonXy + 51);
        image(arrowLeft, buttonXx - 160, buttonXy + 51);
        image(panels.get(panel).display, buttonXx - 120, buttonXy + 20);  //Place the current help panel image
        textAlign(CENTER);
        //textSize(10);
        textFont(smallFont);  
        textSize(12);
        fill(255);
        text(panels.get(panel).desc, buttonXx - 80, buttonXy + 130);      //Place the current help information
        textAlign(LEFT);
      }
    }
  }
  
  void updateBuild(){
    fill(255);
    textSize(12);
    fill(255);
    text(towers.get(towersCycle).getInfo(), 180, y + 224);    //Get icon for tower
     
  }
  
  int getTowerCycle() { return towersCycle; }
  
  void updatePhone(){
    button1x = 120;
    button2x = 240;
    button3x = 120;
    button4x = 240;
    button1y = y + 90;
    button2y = y + 90;
    button3y = y + 190;
    button4y = y + 190;
    buttonXx = 260;
    buttonXy = y + 70;
    
    if((mouseX >= 70) && (mouseX <= 290) && (mouseY >= y) && (mouseY <= y + 400)){
      if(removable == true){
        if(y <= highestPoint){
          y = y * 1.02;
        }
      }else if(y >= highestPoint){
        y = y * 0.97;
      }
    }else if((y <= lowestPoint) && (removable == false)){
        y = y * 1.02;
        if(y >= 578){    //If phone reaches the bottom
          removable = false;
          highestPoint = 360;
        }
    }
    if(stage == "build"){
      updateBuild();
    }
  }
  
  void phoneClick(){
    if(dist(mouseX, mouseY, button1x, button1y) <= (buttonWidth / 2) && (stage == "main")){
      click2.play();
      stage = "build";
    }else if(dist(mouseX, mouseY, button2x, button2y) <= (buttonWidth / 2) && (stage == "main")){
      click2.play();
      stage = "destroy";
    }else if(dist(mouseX, mouseY, button3x, button3y) <= (buttonWidth / 2) && (stage == "main")){
      click2.play();
      stage = "help";
    }else if(dist(mouseX, mouseY, button4x, button4y) <= (buttonWidth / 2) && (stage == "main")){
      click2.play();
      stage = "splitter";
    }
    if(dist(mouseX, mouseY, buttonXx, buttonXy) <= (buttonWidth / 2) && (stage == "build")){
      click3.play();
      stage = "main";
      locked = false;
    }else if(dist(mouseX, mouseY, buttonXx, buttonXy) <= (buttonWidth / 2) && (stage == "destroy")){
      click2.play();
      removable = false;
      highestPoint = 360;
      stage = "main";
    }else if(dist(mouseX, mouseY, buttonXx, buttonXy) <= (buttonWidth / 2) && (stage == "help")){
      click3.play();
      stage = "main"; 
      //ellipse(buttonXx - 10, buttonXy + 60, 20, 20);                    //As well as cycle left and right buttons
      //  ellipse(buttonXx - 150, buttonXy + 60, 20, 20);  
    }else if(dist(mouseX, mouseY, buttonXx - 10,  buttonXy + 60) <= (10) && (stage == "help")){  //If cycling left
      click1.play();
      if(panel == 0){
        panel = panels.size() - 1;
      }else{
        panel--;
      }
    }else if(dist(mouseX, mouseY, buttonXx - 150,  buttonXy + 60) <= (10) && (stage == "help")){  //If cycling right
      click1.play();
      if(panel == panels.size() - 1){
        panel = 0;
      }else{
        panel++;
      }
    }else if(dist(mouseX, mouseY, buttonXx, buttonXy) <= (buttonWidth / 2) && (stage == "splitter")){
      click3.play();
      stage = "main";
    }
    
    //build menu
    if(dist(mouseX, mouseY, buttonBuildLeftX, buttonBuildLeftY) <= (40 / 2) && (stage == "build")){
      locked = false;  //unlock the phone
      click1.play();
      if(towersCycle == 0){
        if(!(locked == false && (purchasingTower == true || purchasingDeployable == true))){
        towersCycle = towers.size() - 1;
        }
      }else{
        if(!(locked == false && (purchasingTower == true || purchasingDeployable == true))){
          towersCycle--;
        }
      }
    }else if(dist(mouseX, mouseY, buttonBuildRightX, buttonBuildRightY) <= (40 / 2) && (stage == "build")){  //Cycle towers right (100, y + 70, 20, 20)
      locked = false; //unlock the phone
      click1.play();
      if(towersCycle == towers.size() - 1){
        if(!(locked == false && (purchasingTower == true || purchasingDeployable == true))){
          towersCycle = 0;
        }
        
      }else{
        if(!(locked == false && (purchasingTower == true || purchasingDeployable == true))){
          towersCycle++;
        }
      }
    }else if(dist(mouseX, mouseY, 180, y + 62) <= 10 && (stage == "build")){  //Cycle towers right if clicking on lock button
      if(!(tutorialStage >= 0 && tutorialStage <= TUTORIAL_MAX) || tutorialStage == 18 || tutorialStage == 22){    //If in the tutorial
        click1.play();
        if(locked){
          locked = false;
        }else{
          locked = true;
        }
      }
    }else if(dist(mouseX, mouseY, 180, y + 120) <= (90 / 2) && (stage == "build") && (purchasingTower == false) && (purchasingDeployable == false) && (workerNum >= towers.get(towersCycle).getPrice())){              //If buying a tower
      if(tutorialStage >= 0 && tutorialStage <= TUTORIAL_MAX){    //If in the tutorial
        //If in the tutorial stage
         if(tutorialStage == 2){                                  //Build one artillery tower anywhere along the line in tutorial
          if(towersCycle == 0){
          workerNum -= towers.get(towersCycle).getPrice();
          notification.play();
          purchasedTower = towersCycle;
          if(towersCycle == 0){    ///If it was an artillery tower
            //build artillery
            ArrayList<PImage> sprites = new ArrayList<PImage>();
            sprites.add(art1);
            sprites.add(art2);
            sprites.add(art3);
            sprites.add(art4);
            sprites.add(art5);
            sprites.add(art6);
            sprites.add(art7);
            sprites.add(art8);
            purchasingTower = true;
          }
          }
      }else if(tutorialStage == 8){                            //Build one artillery tower anywhere along the line in tutorial
          if(towersCycle == 1){
          workerNum -= towers.get(towersCycle).getPrice();
          notification.play();
          purchasedTower = towersCycle;
          if(towersCycle == 1){    ///If it was an artillery tower
            //build writers tent
                ArrayList<PImage> sprites = new ArrayList<PImage>();
                sprites.add(wri1);
                sprites.add(wri2);
                sprites.add(wri3);
                sprites.add(wri4);
                sprites.add(wri5);
                sprites.add(wri6);
                purchasingTower = true;
          }
          }
      }else if(tutorialStage == 14){                            //Build one reinforcement anywhere along the line in tutorial
          if(towersCycle == 4){
          workerNum -= towers.get(towersCycle).getPrice();
          notification.play();
          purchasedTower = towersCycle;
          if(towersCycle == 4){    ///If it was an artillery tower
            //drop reinforcment
            timeDeploy = millis() + 100;
            deployableName = "reinforce";
            purchasingDeployable = true;
          }
          }
      }else if(tutorialStage == 18){                            //Build one reinforcement anywhere along the line in tutorial
          if(towersCycle == 4){
          workerNum -= towers.get(towersCycle).getPrice();
          notification.play();
          purchasedTower = towersCycle;
          if(towersCycle == 4){    ///If it was an artillery tower
            //drop reinforcment
            timeDeploy = millis() + 100;
            deployableName = "reinforce";
            purchasingDeployable = true;
          }
          }
      }else if(tutorialStage == 22){                            //Build one reinforcement anywhere along the line in tutorial
          if(towersCycle == 5){
          workerNum -= towers.get(towersCycle).getPrice();
          notification.play();
          purchasedTower = towersCycle;
          if(towersCycle == 5){    ///If it was an freeze grenade
            //drop reinforcment
            timeDeploy = millis() + 100;
            deployableName = "freeze";
            purchasingDeployable = true;
          }
          }else if(towersCycle == 6){
          workerNum -= towers.get(towersCycle).getPrice();
          notification.play();
          purchasedTower = towersCycle;
          if(towersCycle == 6){    ///If it was an molotov
            //drop reinforcment
            timeDeploy = millis() + 100;
            deployableName = "molotov";
            purchasingDeployable = true;
          }
          }
      }else if(tutorialStage == 28){                            //Build one artillery tower anywhere along the line in tutorial
          if(towersCycle == 2){
          workerNum -= towers.get(towersCycle).getPrice();
          notification.play();
          purchasedTower = towersCycle;
          if(towersCycle == 2){    ///If it was an artillery tower
            //build hostel
                ArrayList<PImage> sprites = new ArrayList<PImage>();
                sprites.add(hos1);
                sprites.add(hos2);
                sprites.add(hos3);
                sprites.add(hos4);
                sprites.add(hos5);
                sprites.add(hos6);
                sprites.add(hos7);
                sprites.add(hos8);
                purchasingTower = true;
          }
          }
      }
      }else{                                                //If not in the tutorial
        workerNum -= towers.get(towersCycle).getPrice();
        notification.play();
        purchasedTower = towersCycle;
        if(towersCycle == 0){    ///If it was an artillery tower
          //build artillery
          ArrayList<PImage> sprites = new ArrayList<PImage>();
          sprites.add(art1);
          sprites.add(art2);
          sprites.add(art3);
          sprites.add(art4);
          sprites.add(art5);
          sprites.add(art6);
          sprites.add(art7);
          sprites.add(art8);
          //Tower newArtillery = new Tower(mouseX, mouseY, sprites);
          //towersList.add(newArtillery);
          purchasingTower = true;
        }else if( phone.getTowerCycle() == 1){    ///If it was an writers tower
                //build writers tent
                ArrayList<PImage> sprites = new ArrayList<PImage>();
                sprites.add(wri1);
                sprites.add(wri2);
                sprites.add(wri3);
                sprites.add(wri4);
                sprites.add(wri5);
                sprites.add(wri6);
                //Tower newWriter = new Tower(mouseX, mouseY, sprites);
                //towersList.add(newWriter);
                purchasingTower = true;
        }else if( phone.getTowerCycle() == 2){    ///If it was an writers tower
                //build hostel
                ArrayList<PImage> sprites = new ArrayList<PImage>();
                sprites.add(hos1);
                sprites.add(hos2);
                sprites.add(hos3);
                sprites.add(hos4);
                sprites.add(hos5);
                sprites.add(hos6);
                sprites.add(hos7);
                sprites.add(hos8);
                //Tower newHostel = new Tower(mouseX, mouseY, sprites);
                //towersList.add(newHostel);
                purchasingTower = true;
         }else if( phone.getTowerCycle() == 3){    ///If it was an writers tower
                //build factory
                ArrayList<PImage> sprites = new ArrayList<PImage>();
                sprites.add(fac1);
                sprites.add(fac2);
                sprites.add(fac3);
                sprites.add(fac4);
                sprites.add(fac5);
                sprites.add(fac6);
                sprites.add(fac7);
                sprites.add(fac8);
                //Tower newFactory = new Tower(mouseX, mouseY, sprites);
                //towersList.add(newFactory);
                purchasingTower = true;
         }else if(phone.getTowerCycle() == 4){    ///If it was a reinforcement
                //drop reinforcment
                timeDeploy = millis() + 100;
                deployableName = "reinforce";
                purchasingDeployable = true;
         }else if( phone.getTowerCycle() == 5){    ///If it was a freeze grenade
                //drop freeze grenade
                timeDeploy = millis() + 100;
                deployableName = "freeze";
                purchasingDeployable = true;
         }else if( phone.getTowerCycle() == 6){    ///If it was a freeze grenade
                //drop molotov
                timeDeploy = millis() + 100;
                deployableName = "molotov";
                purchasingDeployable = true;
         }
      }
    }
    //remove menu
    if(dist(mouseX, mouseY, buttonDelX, buttonDelY) <= (90 / 2) && (stage == "destroy")){
      if(!(tutorialStage >= 0 && tutorialStage <= TUTORIAL_MAX) || (tutorialStage == 12)){    //Only run if we ae not in the tutorial or we are at stage 12
      if(removable == true){
        removable = false;
        highestPoint = 360;
      }else{
        removable = true;
        highestPoint = 460;
      }
      }
    }
    
    //Splitter menu
    if(dist(mouseX, mouseY, buttonDelX, buttonDelY) <= (90 / 2) && (stage == "splitter")){ 
      if(tweets.size() > 0){
        tweets.get(0).deleted = true;
      }
    }
  }
}