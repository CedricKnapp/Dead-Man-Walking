class Particle{
  float rad;
  int[] colour;
  float x;
  float y;
  float xDir;
  float ySpeed;
  char type;
  float opacity;
  
  Particle(float xP, float yP, float r, int[] c){
    colour = c;
    rad = r;
    x = xP;
    y = yP;
    ySpeed = random(1, 2);
    xDir = random(-1, 1);
    opacity = random(220, 240);
  }
  
  Particle(float xP, float yP, float r, int[] c, float y1, float y2, float x1, float x2){
    colour = c;
    rad = r;
    x = xP;
    y = yP;
    ySpeed = random(y1, y2);
    xDir = random(x1, x2);
    opacity = random(220, 240);
  }
  
  Particle(float xP, float yP, char b){
    if(b == 'S'){
      colour = new int[] {(int)random(200, 210), (int)random(240, 255), (int)random(200, 210)};
      rad = (int) random(1, 3);
      x = xP;
      y = yP;
      ySpeed = random(-0.2, 0.2);
      xDir = random(-1, -2);
      opacity = random(220, 240);
    }else if(b == 'P'){
      type = b;
      colour = new int[] {(int)random(80, 100), (int)random(150, 160), (int)random(240, 250)};
      rad = (int) random(3, 4);
      x = xP;
      y = yP;
      ySpeed = random(-0.2, 0.2);
      xDir = random(-3, 3);
      opacity = random(220, 240);
    }else if(b == 'F'){      //Freeze Particle
      type = b;
      colour = new int[] {(int)random(150, 170), (int)random(190, 200), (int)random(240, 250)};
      rad = (int) random(1, 2);
      x = xP;
      y = yP;
      ySpeed = random(0.3, 3.9);
      xDir = random(-2, 2);
      opacity = random(220, 240);
    }else if(b == 'N'){      //Flame Particle
      type = b;
      colour = new int[] {(int)random(250, 255), (int)random(100, 160), (int)random(0, 5)};
      rad = (int) random(5, 6);
      x = xP;
      y = yP;
      ySpeed = random(0.3, 2);
      xDir = random(-1, 1);
      opacity = random(220, 240);
    }else if(b == 'Y'){      //Flame Spread Particle
      type = b;
      colour = new int[] {(int)random(250, 255), (int)random(120, 180), (int)random(20, 25)};
      rad = (int) random(1, 2);
      x = xP;
      y = yP;
      ySpeed = random(0.1, 0.15);
      xDir = random(-1.7, 1.7);
      opacity = random(220, 240);
    }else if(b == 'T'){      //Sut Particle
      type = b;
      colour = new int[] {0, 0, 0};
      rad = (int) random(1, 2);
      x = xP;
      y = yP + 7.5;
      ySpeed = 0;
      xDir = 0;
      opacity = random(240, 255);
    }
  }
  
  void drawParticle(){
    if(view == 0){
    fill(colour[0], colour[1], colour[2], opacity);
    ellipse(x, y, rad, rad);
    }
  }
  
  void updateParticle(){
    if(type == 'N'){
      rad *= 0.93;
    }else if(type == 'Y'){
      ySpeed *= 1.09;
    }
    x += (xDir * 0.98);
    y -= (ySpeed * 0.98);
    if(type == 'T'){
      opacity -= 2;
    }else{
      opacity -= 5;
    }
    if(opacity <= 0){
      particles.remove(this);
    }
    
  }
}