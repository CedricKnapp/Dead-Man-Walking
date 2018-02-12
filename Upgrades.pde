class Upgrade{
  String desc, description;
  float amount1;
  Tower tower1;
  PImage icon;
  int price;
  boolean maxed;
  Upgrade nextUpgrade = null;
  Upgrade extraUpgrade = null;
  
  Upgrade(String d){
    desc = d;
    maxed = false;
  }
  
  Upgrade(String d, float a1, Tower t1, PImage i){
    this(d);
    icon = i;
    desc = d;
    amount1 = a1;
    tower1 = t1;
    maxed = false;
  }                                                                //new Upgrade("Increase Damage", )
  
  Upgrade(String d, float a1, Tower t1, PImage i, String d2, int p){
    this(d);
    icon = i;
    desc = d;
    description = d2;
    amount1 = a1;
    price = p;
    tower1 = t1;
    maxed = false;
  }  
  
  void nextUpgrade(Upgrade n){
    nextUpgrade = n;
  }
  
  void nextUpgrade(Upgrade n, Upgrade a){
    nextUpgrade = n;
    extraUpgrade = a;
  }
  
  void applyUpgrade(){
    //Add particles on tower Particle(float xP, float yP, float r, int[] c, float y1, float y2, float x1, float x2){
    purchase.play();
   for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
      if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
        for(int p = 0; p < 15; p++){
          int[] col = new int[] {255, 251, (int)random(5, 250)};
          Particle temp = new Particle(towersList.get(i).x + random(-15, 15), towersList.get(i).y + random(-15, 8), random(1, 5), col, 0.2, 2, 0, 0);
          particles.add(temp);

        }
      }
    }
    
    if(desc == "Increase Damage"){                      //If it is a damage upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Writer){            //If it is a writers tent
            ((Writer)towersList.get(i)).dmg += amount1;
          }else if(towersList.get(i) instanceof Artillery){  //If it is an artillery tower
            ((Artillery)towersList.get(i)).dmg += amount1;
          }else if(towersList.get(i) instanceof Chainsaw){  //If it is a chainsaw factory
            ((Chainsaw)towersList.get(i)).dmg += amount1;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Increase Damage Ex"){                      //If it is a damage upgrade and expanding
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Writer){            //If it is a writers tent
            ((Writer)towersList.get(i)).dmg += amount1;
          }else if(towersList.get(i) instanceof Artillery){  //If it is an artillery tower
           ((Artillery)towersList.get(i)).dmg += amount1;
           clickedTower.numUpgrades = 3;
           clickedTower.towerUI.setUpgrade(artDamageI);
           ((Artillery)clickedTower).towerUI.addUpgrade(artDamageII.icon, artDamageII );
           clickedTower.numUpgrades = 2;
        }else if(towersList.get(i) instanceof Chainsaw){  //If it is a chainsaw factory
            ((Chainsaw)towersList.get(i)).dmg += amount1;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Increase Range"){                      //If it is a range upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Writer){            //If it is a writers tent
            ((Writer)towersList.get(i)).range += amount1;
          }else if(towersList.get(i) instanceof Artillery){  //If it is an artillery tower
            ((Artillery)towersList.get(i)).range += amount1;
          }else if(towersList.get(i) instanceof Chainsaw){  //If it is a chainsaw factory
            ((Chainsaw)towersList.get(i)).range += amount1;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Cooldown"){                      //If it reduce the cooldown
      for(int i = 0; i < towersList.size(); i++){        //Go through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Writer){            //If it is a writers tent
            ((Writer)towersList.get(i)).rOF -= amount1;
          }else if(towersList.get(i) instanceof Artillery){  //If it is an artillery tower
            ((Artillery)towersList.get(i)).rOF -= amount1;
          }else if(towersList.get(i) instanceof Chainsaw){  //If it is a chainsaw factory
            ((Chainsaw)towersList.get(i)).rOF -= amount1;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Poison"){                      //If it is a poison upgrade (writers tent)
      for(int i = 0; i < towersList.size(); i++){        //Go through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Writer){            //If it is a writers tent
            ((Writer)towersList.get(i)).poison = true;    //Activate the poison shot on the tower
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Lightning"){                      //If it is a lightning upgrade (writers tent)
      for(int i = 0; i < towersList.size(); i++){        //Go through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Writer){            //If it is a lightning tent
            ((Writer)towersList.get(i)).lightning = true;    //Activate the poison shot on the tower
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Slow"){                      //If it is a poison upgrade (writers tent)
      for(int i = 0; i < towersList.size(); i++){        //Go through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Writer){            //If it is a writers tent
            ((Writer)towersList.get(i)).slow += amount1;    //Activate the poison shot on the tower
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Dual Guns"){                      //If it is a double gun upgrade (artillery)
      for(int i = 0; i < towersList.size(); i++){        //Go through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Artillery){            //If it is an artillery
            ((Artillery)towersList.get(i)).dualGuns = true;    //Activate the double guns
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Grenade Launcher"){                      //If it is a Grenade Launcher upgrade (artillery)
      for(int i = 0; i < towersList.size(); i++){        //Go through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Artillery){            //If it is an artillery
            ((Artillery)towersList.get(i)).molotov = true;    //Activate the Grenade Launcher
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "50 Cal"){                      //If it is a Grenade Launcher upgrade (artillery)
      for(int i = 0; i < towersList.size(); i++){        //Go through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Artillery){            //If it is an artillery
            ((Artillery)towersList.get(i)).barrage = true;    //Activate the Barrage
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Increase Capacity"){                      //If it is a range upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Hostel){            //If it is a writers tent
            ((Hostel)towersList.get(i)).capacity += amount1;
            ((Hostel)towersList.get(i)).full = false;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Breed"){                      //If it is a Breed upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Hostel){            //If it is a writers tent
            ((Hostel)towersList.get(i)).breed = true;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Beacon Range"){                      //If it is a range upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Hostel){            //If it is a writers tent
            for(Tower t: towersList){
              if(dist(towersList.get(i).x, towersList.get(i).y, t.x, t.y) <= 80){      //Find all towers within a range of 80 pixels
                if(t instanceof Writer){            //If it is a writers tent
                  ((Writer)t).range += ((Writer)t).range / 100 * amount1;
                }else if(t instanceof Artillery){  //If it is an artillery tower
                  ((Artillery)t).range += ((Artillery)t).range / 100 * amount1;
                }else if(t instanceof Chainsaw){  //If it is a chainsaw factory
                  ((Chainsaw)t).range +=  ((Chainsaw)t).range / 100 * amount1;
                }
                if(t instanceof Hostel){
                    //Do nothing
                }else{
                  for(int p = 0; p < 15; p++){
                    int[] col = new int[] {255, 251, (int)random(5, 250)};
                    Particle temp = new Particle(t.x + random(-15, 15), t.y + random(-15, 8), random(1, 5), col, 0.2, 2, 0, 0);
                    particles.add(temp);
                  }
                }
                t.stat.updateStats();
              }
            }
          }
        }
      }
    }else if(desc == "Civilian Range"){                      //If it is a Range upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Hostel){            //If it is a Chainsaw Factory
            ((Hostel)towersList.get(i)).addedRange += amount1;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Freeze Grenades"){                      //If it is a Freeze upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Chainsaw){            //If it is a Chainsaw Factory
            ((Chainsaw)towersList.get(i)).freeze = true;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Double Saw"){                      //If it is a Saw upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Chainsaw){            //If it is a Chainsaw Factory
            ((Chainsaw)towersList.get(i)).twoSaws = true;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Triple Saw"){                      //If it is a Breed upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Chainsaw){            //If it is a Chainsaw Factory
            ((Chainsaw)towersList.get(i)).threeSaws = true;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Burst"){                      //If it is a Burst upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Chainsaw){            //If it is a Chainsaw Factory
            ((Chainsaw)towersList.get(i)).hail = true;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }else if(desc == "Revved Up"){                      //If it is a Burst upgrade
      for(int i = 0; i < towersList.size(); i++){        //GO through every existing tower
        if(towersList.get(i).equals(tower1)){              //Find the matching tower (target)
          if(towersList.get(i) instanceof Chainsaw){            //If it is a Chainsaw Factory
            ((Chainsaw)towersList.get(i)).workingChainsaw = true;
          }
          towersList.get(i).stat.updateStats();
        }
      }
    }
  }
}

Upgrade artDamageI;          //Increase the damage by 0.5 a shot
Upgrade artDamageII;         //Increases the damage by 0.5 a shot
Upgrade artRangeI;           //Increase the range by 25 pixels
Upgrade artRangeII;          //Increase the range by 50 pixels
Upgrade artDualGuns;         //Adds another gun to arsenal
Upgrade artGrenadeLauncher;  //Throws the occasional molotov
Upgrade art50Cal;            //Special: Fires volley of rounds with knockback

Upgrade wriDamageI;          //Increase the damage by 2 a shot
Upgrade wriDamageII;         //Increase the damage by 5 a shot
Upgrade wriPoison;           //Poison effect its zombie after inital shot
Upgrade wriCooldown;         //Reduces reload time
Upgrade wriCripplingBlowsI;  //Slows target on impact
Upgrade wriCripplingBlowsII; //Slows target on impact
Upgrade wriLightning;        //Splash damages area (through chain effect), high damages and slows targets.

Upgrade hosCapI;             //Increases the amount of people allowed by 4
Upgrade hosCapII;            //Increases the amount of people allowed by 5
Upgrade hosBreed;            //Adds chance of multiplication at the end of the round
Upgrade hosBeaconI;          //Increases the range of other towers by 10
Upgrade hosBeaconII;         //Increases the range of other towers by 25
Upgrade hosSecurity;         //Adds small area effect damage to zombies nearby
Upgrade hosRangeI;           //Increases the civilian searching distance for hostel by 25
Upgrade hosRangeII;          //Increases the civilian searching distance for hostel by 50
Upgrade hosRangeIII;         //Civilians can see the whole map

Upgrade facCooldownI;        //Decreases Cooldown by 100 ms
Upgrade facCooldownII;       //Decreases Cooldown by 300 ms
Upgrade facFreeze;           //Adds freeze grenades
Upgrade facDamageI;          //Increases the damage of each chainsaw by 3
Upgrade facDamageII;         //Increases the damage of each chainsaw by 4
Upgrade facDamageIII;        //Increases the damage of each chainsaw by 7
Upgrade facRangeI;           //Increases the range by 10
Upgrade facRangeII;          //Increases the range by 15
Upgrade facWorkingChainsaw;  //Landed chainsaw do additional damage
Upgrade facSawsII;           //Adds a second chainsaw
Upgrade facSawsIII;          //Adds a third chainsaw
Upgrade facSawsBurst;        //Factory goes temporarily bankrupt, spits out a flurry of chainsaws

Upgrade maxed;


void loadUpgrades(){                                                        //Load every upgrade and make an upgrade tree for each tower
  maxed = new Upgrade("Maxed", 0, null, null, "maxed", 0);
  
  facCooldownI = new Upgrade("Cooldown", 100, null, lessTimeIcon, "Shittier Management I: Increase production management.", 20);          //Create each upgrade
  facCooldownII = new Upgrade("Cooldown", 300, null, lessTimeIcon, "Shittier Management II: Increase production management.", 30);
  facFreeze = new Upgrade("Freeze Grenades", 0, null, snowflakeIcon, "NitroBuzz: Sometimes your saws will freeze zombies. Sometimes.", 10);     
  facDamageI = new Upgrade("Increase Damage", 3, null, damageIcon, "Painsaw I: Make them hurt, more.", 20);     
  facDamageII = new Upgrade("Increase Damage", 4, null, doubleDamageIcon, "Painsaw II: Make them hurt, a lot more.", 25);      
  facDamageIII = new Upgrade("Increase Damage", 7, null, skullIcon, "Painsaw III: Health and Safety won't hear about this one.", 35);    
  facRangeI = new Upgrade("Increase Range", 10, null, growIcon, "Timber I: Expand your sights.", 20);
  facRangeII = new Upgrade("Increase Range", 15, null, growIcon, "Timber II: See further onto the field.", 20);
  facWorkingChainsaw = new Upgrade("Revved Up", 15, null, chainsawBloodyIcon, "Working: As the chainsaw land, expect a little more bang for your buck.", 40);
  facSawsII = new Upgrade("Double Saw", 1, null, doubleIcon, "Lumberjacked I: Throw twice as many saws.", 30);
  facSawsIII = new Upgrade("Triple Saw", 1, null, tripleIcon, "Lumberjacked II: Add a third chainsaw.", 35);
  facSawsBurst = new Upgrade("Burst", 0, null, bankruptIcon, "Bankrupt: Every minute expect a hailstorm of sharp things that cut.", 35);
  
  
  facCooldownI.nextUpgrade(facCooldownII);             //Add to upgrade tree
  facCooldownII.nextUpgrade(facFreeze);
  facDamageI.nextUpgrade(facDamageII);
  facDamageII.nextUpgrade(facDamageIII);
  facRangeI.nextUpgrade(facRangeII);
  facRangeII.nextUpgrade(facWorkingChainsaw);
  facSawsII.nextUpgrade(facSawsIII);
  facSawsIII.nextUpgrade(facSawsBurst);
  
  
  hosCapI = new Upgrade("Increase Capacity", 4, null, peopleIcon, "Family Fun: Add four to your max capacity.", 20);          //Create each upgrade
  hosCapII = new Upgrade("Increase Capacity", 5, null, peopleIcon, "It's A Crowd: Make room for five more refugees.", 20);
  hosBreed = new Upgrade("Breed", 0, null, heartIcon, "Love Shack: There's a 50% chance for every two refugees you'll get one more at the end of the round.", 25);
  hosBeaconI = new Upgrade("Beacon Range", 5, null, rangeIcon, "Range Boost I: Increase the sight of all nearby towers by 5%", 30);
  hosBeaconII = new Upgrade("Beacon Range", 10, null, rangeIcon, "Range Boost II: Increase the sight of all nearby towers by 10%", 40);
  hosSecurity = new Upgrade("Security", 0, null, damageAreaEffectIcon, "Security: Zombies that walk near the doors of your tower will recieve a lil' damage.", 40);
  hosRangeI = new Upgrade("Civilian Range", 25, null, eyeballIcon, "Three Star: Refugees can now see this tower from 25 more meters away.", 25);
  hosRangeII = new Upgrade("Civilian Range", 50, null, eyeballIcon, "Four Star: Refugees can now see this tower from 50 more meters away.", 35);
  hosRangeIII = new Upgrade("Civilian Range", 5000, null, globeIcon, "Five Star: Refugees can now see this tower from anywhere on the map.", 40);
  hosCapI.nextUpgrade(hosCapII);             //Add to upgrade tree
  hosCapII.nextUpgrade(hosBreed);
  hosBeaconI.nextUpgrade(hosBeaconII);
  hosBeaconII.nextUpgrade(hosSecurity);
  hosRangeI.nextUpgrade(hosRangeII);
  hosRangeII.nextUpgrade(hosRangeIII);
  
  
  wriDamageI = new Upgrade("Increase Damage", 2, null, damageIcon, "Season Two: Writers become less inspired and add 2 damage to each shot.", 15);          //Create each upgrade
  wriDamageII = new Upgrade("Increase Damage", 5, null, doubleDamageIcon, "Season Four: Writers get sloppier with an additional 5 damage to each shot.", 20);    
  wriPoison = new Upgrade("Poison", 0.5, null, skullIcon, "Lost: When the writers hit a zombie, it takes poison damage over a short period of time.", 25);    
  wriCooldown = new Upgrade("Cooldown", 600, null, lessTimeIcon, "Reboot: The writers attack zombies half a second quicker.", 30);    
  wriCripplingBlowsI = new Upgrade("Slow", 0.2, null, heartbleedIcon, "Writer's Block I: Permanently slows enemies on impact.", 30);    
  wriCripplingBlowsII = new Upgrade("Slow", 0.4, null, heartbleedIcon, "Writer's Block II: Brings 'em to a crawl.", 40);  
  wriLightning = new Upgrade("Lightning", 0.4, null, lightningIcon, "Write Away: Every 20 seconds strike a crowd of zombies with a lightning burst. ", 50);
  wriDamageI.nextUpgrade(wriDamageII);             //Add to upgrade tree
  wriDamageII.nextUpgrade(wriPoison);
  wriCripplingBlowsI.nextUpgrade(wriCripplingBlowsII);
  wriCripplingBlowsII.nextUpgrade(wriLightning);
  
  
  artDamageI = new Upgrade("Increase Damage Ex", 0.5, null, damageIcon, "Glock I: Add a little punch to each bullet.", 25);        //Create each upgrade
  artDamageII = new Upgrade("Increase Damage", 1.0, null, doubleDamageIcon, "Glock II: They won't be eating lead-free after this.", 30);
  artRangeI = new Upgrade("Increase Range", 25, null, growIcon, "Sights I: Add 25 meters to your sharpshooters scopes.", 10);
  artRangeII = new Upgrade("Increase Range", 50, null, growIcon, "Sights II: Add 50 meters to your sharpshooters scopes.", 20);
  artDualGuns = new Upgrade("Dual Guns", 0, null, gunsIcon, "Double Brratt: Double fist it with another gun added to your arsenal.", 45);
  artGrenadeLauncher = new Upgrade("Grenade Launcher", 0, null, grenadeIcon, "n00bt00b: Hurl an explosive every 5 seconds at crowds of zombies.", 40);
  art50Cal = new Upgrade("50 Cal", 0, null, gunsIcon, "Unleash a hailstorm of bullets 2 times a minute, knocking back dem hoes.", 50);
  artDamageI.nextUpgrade(artDualGuns, artDamageII);             //Add to upgrade tree
  artDamageII.nextUpgrade(artGrenadeLauncher);
  artRangeI.nextUpgrade(artRangeII);
  artRangeII.nextUpgrade(art50Cal);
}