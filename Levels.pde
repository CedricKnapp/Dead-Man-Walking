class Level{
  int numZombies; 
  int numScreamers;
  int numCivilians;
  int numBloaters;
  boolean levelDone;
  float yPos;
  float waitTime = 0;
  int level = 0;
  
  Level(int l, int z, int s, int c, int b){
    levelDone = false;
    level = l;
    numZombies = z; 
    numScreamers = s;
    numCivilians = c;
    numBloaters = b;
  }
  
  //(y position, moveable)
  void sendEntity(float y, Moveable m){
    m.setY(y);
    zombies.add(m);                                           //Add to zombies list 
  }
  
  void sendWave(){
    if(level == 0){                                                                                                //Level One
      //yPos = 200;
      yPos = arrowParameters[0] + ((arrowParameters[1] - arrowParameters[0]) / 2);
        if(numZombies >= 10 && millis() >= waitTime){                                           // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 800);
          if(numZombies == 10){
            waitTime = millis() + 5000;
          }
        }else if(numZombies >= 5 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 800);
          if(numZombies == 5){
            waitTime = millis() + 4000;
          }
        }else if(numZombies >= 1 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 800);
        }else{
          //levelUpdated = true;
          float reward = 50;
          if(zombies.size() == 0 && numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
            levelDone = true;
            rect(0, 0, width, height);
            levelEnd.play();
            workerNum += reward;
            levelUpdated = true;
          }
          if(numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
           boolean justReinforcements = true;
            for(int i = 0; i < zombies.size(); i++){
              if(!(zombies.get(i) instanceof Reinforcement)){
                justReinforcements = false;
              }
            }
            if(justReinforcements){
                levelDone = true;
                levelEnd.play();
                //workerNum += reward;
                levelUpdated = true;
                for(int i = 0; i < zombies.size(); i++){
                  for(int f = 0; f <= 6; f++){
                    Particle temp = new Particle(zombies.get(i).getX() + random(3, 10), zombies.get(i).getY() + random(3, 10), 'Y');
                    particles.add(temp);
                  }
                    zombies.get(i).setHealth(-1);
                  }
                //remove reinforcements
              } 
          }
        }
    }else if(level == 1){      
      yPos = arrowParameters[0] + ((arrowParameters[1] - arrowParameters[0]) / 2);
        if(numZombies >= 10 && millis() >= waitTime){                                           // Spawns 5 zombies, low health, low speed (chance for higher spped
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
          zombies.add(temp);
          numZombies--;
          if((numZombies == 12 || numZombies == 14 ) && numCivilians >= 0){
            Refugee temp1 = new Refugee(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          
          waitTime = millis() + random(200, 800);
          if(numZombies == 10){
            waitTime = millis() + 4000;
          }
        }else if(numZombies >= 5 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 800);
          if((numZombies == 6 || numZombies == 7 || numZombies == 8) && numCivilians >= 0){
            Refugee temp1 = new Refugee(0, yPos + random(-20, 20), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          if(numZombies == 5){
            waitTime = millis() + 3000;
          }
        }else if(numZombies > 0 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 800);
        }else{
          //levelUpdated = true;
          float reward = 60;
          if(zombies.size() == 0 && numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
            levelDone = true;
            levelEnd.play();
            workerNum += reward;
            levelUpdated = true;
          }
          if(numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
           boolean justReinforcements = true;
            for(int i = 0; i < zombies.size(); i++){
              if(!(zombies.get(i) instanceof Reinforcement)){
                justReinforcements = false;
              }
            }
            if(justReinforcements){
                levelDone = true;
                levelEnd.play();
                //workerNum += reward;
                levelUpdated = true;
                for(int i = 0; i < zombies.size(); i++){
                  for(int f = 0; f <= 6; f++){
                    Particle temp = new Particle(zombies.get(i).getX() + random(3, 10), zombies.get(i).getY() + random(3, 10), 'Y');
                    particles.add(temp);
                  }
                    zombies.get(i).setHealth(-1);
                  }
                //remove reinforcements
              } 
          }
        }
    }else if(level == 2){                                                                                                //Level Two
      yPos = arrowParameters[0] + ((arrowParameters[1] - arrowParameters[0]) / 2);
        if(numZombies >= 10 && millis() >= waitTime){                                           // Spawns 5 zombies, low health, low speed (chance for higher spped
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
          zombies.add(temp);
          numZombies--;
          if((numZombies == 12 || numZombies == 14 ) && numCivilians >= 0){
            Refugee temp1 = new Refugee(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          
          waitTime = millis() + random(200, 800);
          if(numZombies == 10){
            waitTime = millis() + 4000;
          }
        }else if(numZombies >= 5 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 800);
          if((numZombies == 6 || numZombies == 7 || numZombies == 8) && numCivilians >= 0){
            Refugee temp1 = new Refugee(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          if(numZombies == 5){
            waitTime = millis() + 3000;
          }
        }else if(numZombies > 0 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 800);
        }else{
          //levelUpdated = true;
          float reward = 70;
          if(zombies.size() == 0 && numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
            levelDone = true;
            levelEnd.play();
            workerNum += reward;
            levelUpdated = true;
          }
          if(numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
           boolean justReinforcements = true;
            for(int i = 0; i < zombies.size(); i++){
              if(!(zombies.get(i) instanceof Reinforcement)){
                justReinforcements = false;
              }
            }
            if(justReinforcements){
                levelDone = true;
                levelEnd.play();
                //workerNum += reward;
                levelUpdated = true;
                for(int i = 0; i < zombies.size(); i++){
                  for(int f = 0; f <= 6; f++){
                    Particle temp = new Particle(zombies.get(i).getX() + random(3, 10), zombies.get(i).getY() + random(3, 10), 'Y');
                    particles.add(temp);
                  }
                    zombies.get(i).setHealth(-1);
                  }
                //remove reinforcements
              } 
          }
        }
    }else if(level == 3){                                                                                                //Level Three
      yPos = arrowParameters[0] + ((arrowParameters[1] - arrowParameters[0]) / 2);
        if(numZombies >= 15 && millis() >= waitTime){                                           // Spawns 25 zombies, low health, low speed (chance for higher spped
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
          zombies.add(temp);
          numZombies--;
          if(numCivilians > 0){ //(numZombies == 12 ||numZombies == 10||numZombies == 15 ||numZombies == 11 || numZombies == 14 ) && 
            rect(0,0, 200, 200);
            Refugee temp1 = new Refugee(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          
          waitTime = millis() + random(300, 500);
          if(numZombies == 10){
            waitTime = millis() + 4000;
          }
        }else if(numZombies > 0 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 500);
          if((numZombies == 12 ||numZombies == 10 ) && numScreamers >= 0){
            Screamer temp1 = new Screamer(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)));
            zombies.add(temp1);
            numScreamers--;
          }
        }else{
          //levelUpdated = true;
          float reward = 80;
          if(zombies.size() == 0 && numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
            levelDone = true;
            levelEnd.play();
            workerNum += reward;
            levelUpdated = true;
          }
          if(numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
           boolean justReinforcements = true;
            for(int i = 0; i < zombies.size(); i++){
              if(!(zombies.get(i) instanceof Reinforcement)){
                justReinforcements = false;
              }
            }
            if(justReinforcements){
                levelDone = true;
                levelEnd.play();
                //workerNum += reward;
                levelUpdated = true;
                for(int i = 0; i < zombies.size(); i++){
                  for(int f = 0; f <= 6; f++){
                    Particle temp = new Particle(zombies.get(i).getX() + random(3, 10), zombies.get(i).getY() + random(3, 10), 'Y');
                    particles.add(temp);
                  }
                    zombies.get(i).setHealth(-1);
                  }
                //remove reinforcements
              } 
          }
        }
    }else if(level == 4){                                                                                                //Level Four
      yPos = arrowParameters[0] + ((arrowParameters[1] - arrowParameters[0]) / 2);
        if(numZombies >= 20 && millis() >= waitTime){                                           // Spawns 5 zombies, low health, low speed (chance for higher spped
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
          zombies.add(temp);
          numZombies--;
          if(numCivilians >= 0){ //(numZombies == 22 ||numZombies == 23||numZombies == 25 ||numZombies == 24 || numZombies == 26 ) && 
            Refugee temp1 = new Refugee(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          
          waitTime = millis() + random(300, 500);
          if(numZombies == 10){
            waitTime = millis() + 4000;
          }
        }else if(numZombies > 0 && millis() >= waitTime){                                      // Spawns 5 zombies, low health, low speed
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 500);
          if((numZombies == 9 ) && numBloaters >= 0){
            Gutter temp1 = new Gutter(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)));
            zombies.add(temp1);
            numBloaters--;
          }
          if((numZombies == 12 ||numZombies == 10 ) && numScreamers >= 0){
            Screamer temp1 = new Screamer(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)));
            zombies.add(temp1);
            numScreamers--;
          }
        }else{
          //levelUpdated = true;
          float reward = 90;
          if(zombies.size() == 0 && numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
            levelDone = true;
            levelEnd.play();
            workerNum += reward;
            levelUpdated = true;
          }
          if(numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
           boolean justReinforcements = true;
            for(int i = 0; i < zombies.size(); i++){
              if(!(zombies.get(i) instanceof Reinforcement)){
                justReinforcements = false;
              }
            }
            if(justReinforcements){
                levelDone = true;
                levelEnd.play();
                //workerNum += reward;
                levelUpdated = true;
                for(int i = 0; i < zombies.size(); i++){
                  for(int f = 0; f <= 6; f++){
                    Particle temp = new Particle(zombies.get(i).getX() + random(3, 10), zombies.get(i).getY() + random(3, 10), 'Y');
                    particles.add(temp);
                  }
                    zombies.get(i).setHealth(-1);
                  }
                //remove reinforcements
              } 
          } 
        }
    }else if(level == 5){                                                                                                //Level Five
      yPos = arrowParameters[0] + ((arrowParameters[1] - arrowParameters[0]) / 2);
        if(numZombies >= 20 && millis() >= waitTime){                                           // Spawns 5 zombies, low health, low speed (chance for higher spped
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
          zombies.add(temp);
          numZombies--;
          if((numZombies == 55) && numBloaters >= 0){
            Gutter temp1 = new Gutter(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)));
            zombies.add(temp1);
            numBloaters--;
          }
          if((numZombies == 35 ||numZombies == 30||numZombies == 45 ||numZombies == 41 || numZombies == 34 ) && numCivilians >= 0){
            Refugee temp1 = new Refugee(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          
          waitTime = millis() + random(300, 500);
          if(numZombies == 10){
            waitTime = millis() + 4000;
          }
        }else if(numZombies > 0 && millis() >= waitTime){                                      //wave 2
          Zombie temp = new Zombie(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 2), random(5, 7));
          zombies.add(temp);
          numZombies--;
          waitTime = millis() + random(200, 500);
          if((numZombies == 9 ) && numBloaters >= 0){
            Gutter temp1 = new Gutter(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)));
            zombies.add(temp1);
            numBloaters--;
          }
          if((numZombies == 15 ||numZombies == 10||numZombies == 5 ||numZombies == 11 || numZombies == 4 ) && numCivilians >= 0){
            Refugee temp1 = new Refugee(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)), random(1, 3), random(5, 7));
            zombies.add(temp1);
            numCivilians--;
          }
          if((numZombies == 12 ||numZombies == 10 ) && numScreamers >= 0){
            Screamer temp1 = new Screamer(0, yPos + random(-((arrowParameters[1] - arrowParameters[0]) / 2), ((arrowParameters[1] - arrowParameters[0]) / 2)));
            zombies.add(temp1);
            numScreamers--;
          }
        }else{
          //levelUpdated = true;
          float reward = 90;
          if(zombies.size() == 0 && numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
            levelDone = true;
            levelEnd.play();
            workerNum += reward;
            levelUpdated = true;
          }
          if(numZombies == 0 && numScreamers == 0 && numCivilians == 0 && numBloaters == 0){
           boolean justReinforcements = true;
            for(int i = 0; i < zombies.size(); i++){
              if(!(zombies.get(i) instanceof Reinforcement)){
                justReinforcements = false;
              }
            }
            if(justReinforcements){
                levelDone = true;
                levelEnd.play();
                //workerNum += reward;
                levelUpdated = true;
                for(int i = 0; i < zombies.size(); i++){
                  for(int f = 0; f <= 6; f++){
                    Particle temp = new Particle(zombies.get(i).getX() + random(3, 10), zombies.get(i).getY() + random(3, 10), 'Y');
                    particles.add(temp);
                  }
                    zombies.get(i).setHealth(-1);
                  }
                //remove reinforcements
              } 
          } 
        }
    }
  }
  
  void playLevel(){
    if(nightOpac < 50){
      nightOpac++;
    }
    fill(#011E64, nightOpac);
    rect(0, 0, width, height - 165);
    sendWave();
    fill(255);
    textSize(10);
    if(levelDone){
    }else{
    }
    if(zombies.size() == 0 && levelDone){
      currentLevel = null;
      nightOpac = 0;
      nextWave = false;
    }
  }
  
}

float nightOpac = 0;