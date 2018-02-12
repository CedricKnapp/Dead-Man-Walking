import processing.sound.*;

//Shape graphic by <a href="http://www.flaticon.com/authors/freepik">Freepik</a> from <a href="http://www.flaticon.com/">Flaticon</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a>. Made with <a href="http://logomakr.com" title="Logo Maker">Logo Maker</a>


void updateMenuButtons(){
  for(int i = 0; i < buttons.size(); i++){
    buttons.get(i).drawMenuButton();
    buttons.get(i).updateMenuButton();
  }
}



void drawMenu(){
  if(clearScreen){
    if(displayScreen == 0){
      for(int i = 0; i < buttons.size(); i++){
        buttons.get(i).removeSelf();
      }
      if(buttons.size() == 0){
        buttons.add(playButton);
        buttons.add(helpButton);
        buttons.add(creditsButton);
        buttons.get(0).opac = 255;
        buttons.get(0).y = height/2 + 70;
        buttons.get(0).name = "play";
        buttons.get(1).opac = 255;
        buttons.get(1).y = height/2 + 120;
        buttons.get(1).name = "rules";
        buttons.get(1).label = rules;
        buttons.get(2).opac = 255;
        buttons.get(2).y = height/2 + 170;
        buttons.get(2).name = "credits";
        buttons.get(2).label = credits;
        clearScreen = false;
      }
    }
    if(displayScreen == 1){
      for(int i = 0; i < buttons.size(); i++){
        buttons.get(i).removeSelf();
      }
      if(buttons.size() == 0){
        clearScreen = false;
        buttons.add(helpButton);
        buttons.get(0).y = height - 60;
      }
    }else if(displayScreen == 2){
      for(int i = 0; i < buttons.size(); i++){
        buttons.get(i).removeSelf();
      }
      if(buttons.size() == 0){
        buttons.add(helpButton);
        buttons.get(0).y = height - 60;
        buttons.get(0).opac = 255;
        buttons.get(0).label = menu;
        buttons.get(0).name = "back";
        clearScreen = false;
      }
    }else if(displayScreen == 3){
      for(int i = 0; i < buttons.size(); i++){
        buttons.get(i).removeSelf();
      }
      if(buttons.size() == 0){
        buttons.add(menuButton);
        buttons.get(0).y = height - 60;
        buttons.get(0).opac = 255;
        buttons.get(0).label = menu;
        buttons.get(0).name = "back";
        clearScreen = false;
      }
    }else if(displayScreen == 5){
      gameView = 1;
    }
  }
  background(#0E0C2C);
  imageMode(CENTER);
  if(displayScreen == 0 && clearScreen == false){    //if on main screen
  int temp = (int) random(0, 51);
  if(temp == 10){
    image(logo, width/2 + random(-50, 50), height/2 - 50 + random(-50, 50));  //Display logo
  }else{
    image(logo, width/2, height/2 - 50);  //Display logo
  }
    temp = (int)random(0, 20);
    if(temp == 5){
      darkness = random(0, 50);
      if(playing == false){
        playing = true;
      }
      stroke(255);
      strokeWeight(random(1, 4));
      float origin = random(0, width);
      float[] point1 = new float[] { random(origin - 20, origin + 20), random(100, 300)};
      float[] point2 = new float[] { random(point1[0] - 20, point1[1]  + 20), random(250, 450)};
      line(origin, 0, point1[0], point1[1]);
      line(point1[0], point1[1], point2[0], point2[1]);
      line(point2[0], point2[1], (origin + random(-50, 50)), height);
      strokeWeight(1);
      noStroke();
    }else{
      darkness = 0;
    }
    fill(255, darkness);
    noStroke();
    rect(0, 0, width, height);
    
  }else if(displayScreen == 1 && clearScreen == false){    //if on play screen
    image(logo, width/2, height/2 - 50);  //Display logo
    if(amps > 0 ){
      amps -= 0.01;
      birthday.amp(amps);
      birthday.rate(amps);
      ambience.rate(amps);
      ambience.amp(amps);
      noStroke();
      fill(0, abs(amps - 1) * 255 );
      rect(0, 0, width, height);
    }else if(amps <= 0){
      noStroke();
      fill(0);
      rect(0, 0, width, height);
      birthday.stop();
      ambience.stop();
      displayScreen = 5;
      cursor();
      imageMode(CORNER);
      gameView = 1;
    }
  }else if(displayScreen == 2 && clearScreen == false){    //if on help screen
    image(logo, width/2, height/2 - 200);  //Display logo
    fill(105, 0, 0);
    textAlign(CENTER);
    textSize(15);
    text("\nUse your phone to build towers.\nTo explore more zombie mechanics, press d to enter debug mode; left clicking will spawn more zombies.\nHave fun!", width/ 2, height / 2 );
  }else if(displayScreen == 3 && clearScreen == false){    //if on credits screen
    image(logo, width/2, height/2 - 200);  //Display logo
    fill(105, 0, 0);
    textAlign(CENTER);
    textSize(15);
    text("Quinton Rodriques\nCedric Knapp\nDavid Nguyen", width/ 2, height / 2 );
  }
  
  updateParticles();
  updateMenuButtons();
  
  noFill();        //Create crosshair cursor
  stroke(255);
  ellipse(mouseX, mouseY, 10, 10);
  ellipse(mouseX, mouseY, 2, 2);
  line(mouseX - 7, mouseY, mouseX - 3, mouseY);
  line(mouseX + 7, mouseY, mouseX + 3, mouseY);
  line(mouseX, mouseY - 7, mouseX, mouseY - 3);
  line(mouseX, mouseY + 7, mouseX, mouseY + 3);
}