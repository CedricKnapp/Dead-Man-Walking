final float BUTTON_LENGTH = 40;
//Button for menu
class MenuButton{
  String name;
  float x, y;
  PImage label;
  float size;
  int[] colour;
  float maxSize = size + 100;
  float minColour, ogColour, ogSize;
  float opac = 255;
  
  MenuButton(float xP, float yP, float s){
    x= xP;
    y = yP;
    size = s;
    ogSize = size;
    colour = new int[]{105, 0, 0};
    ogColour = colour[0];
    minColour = colour[0] - 50;
  }
  
  MenuButton(float xP, float yP, float s, PImage p, String n){
    this(xP, yP, s);
    label = p;
    name = n;
  }
  
  void removeSelf(){
    opac *= 0.95;
  }
  
  void drawMenuButton(){
    noStroke();
    fill(colour[0], colour[1], colour[2], opac);
    tint(255, opac);
    ellipse(x - size / 2, y, BUTTON_LENGTH, BUTTON_LENGTH);
    rect(x - size / 2, y - BUTTON_LENGTH / 2, size, BUTTON_LENGTH);
    ellipse(x + size / 2, y, BUTTON_LENGTH, BUTTON_LENGTH);
    imageMode(CENTER);
    image(label, x, y);
  }
  
  void updateMenuButton(){
    if(opac <= 5){
      buttons.remove(this);
    }else if(mouseX >= x - size - BUTTON_LENGTH / 2 && mouseX <= x + size + BUTTON_LENGTH / 2 && mouseY >= y - BUTTON_LENGTH / 2 && mouseY <= y + BUTTON_LENGTH / 2){
      if(size < maxSize){
        size *= 1.05;
      }
      if(colour[0] >= minColour){
        colour[0] *= 0.985;
      }
    }else{
      if(size > ogSize){
        size *= 0.95;
      }if(colour[0] < ogColour){
        colour[0] *= 1.025;
      }
    }
  }
  
  boolean isClicked(){
    if(mouseX >= x - size - BUTTON_LENGTH / 2 && mouseX <= x + size + BUTTON_LENGTH / 2 && mouseY >= y - BUTTON_LENGTH / 2 && mouseY <= y + BUTTON_LENGTH / 2){
      return true;
    }
    return false;
  }
}

class Indicator{
  float x, y;
  float initX;
  float opac;
  float velo;
  float limit;
  
  Indicator(float xP, float yP){
    x= xP;
    initX = x;
    y = yP;
    limit = random(50, 200);
    opac = 10;
    velo = random(0.4, 1);
  }
  
  void drawIndicator(){
    tint(255, opac);
    image(advance, x, y);
  }
  
  void updateIndicator(){
    if(x > initX + limit){
      opac *= 0.8;
      velo *= 0.9;
    }else{
      opac *= 1.2;
      velo *= 1.1;
    }
    x += velo;
    if(x > initX + (limit * 2)){
      arrows.remove(this);
    }
  }
  
}