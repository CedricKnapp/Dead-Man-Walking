import processing.sound.*;

//Quinton Rodriques
//Cedric Knapp 

final int TUTORIAL_MAX = 42;
PImage logo, play, rules, credits, menu;
SoundFile birthday, ambience;
float timeB, timeA;
float upgradeCooldown = 0;
boolean playing = false;
ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
int displayScreen = 0; 
boolean levelUpdated = false;
float darkness, zombieTiming;
float buttonLight = 0;
float arrowTimer = 0;
boolean glowing = true;
float timeDeploy = 0;
int tutorialStage = TUTORIAL_MAX;  //set to zero if starting tut
int familyCount = 0;
Level currentLevel = null;         //Holds the current level
boolean showStat = true;
int tutBotFrame;
float temptimer = 0;
float tutTimeAnim;
int wave = 1;
int levelNumber = 0;
boolean clearScreen = false;
int[] arrowParameters = new int[]{180, 230};
PImage[] rockets;
boolean nextWave = false;
boolean tutSpawn = false;
float amps = 1;
MenuButton playButton, helpButton, creditsButton, menuButton;

boolean gameOver = false;
int gameOverOpacity = 0;

int purchasedTower;
int gameView = 0;                                                                               //Set to one to start the game, zero for the menu
ArrayList<Grid> map1 = new ArrayList<Grid>();  //Store each map;
ArrayList<Grid> map2 = new ArrayList<Grid>();
ArrayList<Grid> map3 = new ArrayList<Grid>();
ArrayList<Moveable> zombies = new ArrayList<Moveable>();
ArrayList<Moveable> deadZombies = new ArrayList<Moveable>();
char gameMode = 'G';
int view = 0;
int population = 100;
boolean musicStarted = true, tutMusicStarted = false;
Stats curStats;
boolean removable;
Phone phone = new Phone();
Timer reset;
ArrayList<BuildIcon> towers = new ArrayList<BuildIcon>();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Tower> towersList = new ArrayList<Tower>();
ArrayList<Tower> homeTowers = new ArrayList<Tower>();
ArrayList<TowerUI> towerUI = new ArrayList<TowerUI>();
//ArrayList<Saw> saws = new ArrayList<Saw>();
ArrayList<SawBlade> sawBlades = new ArrayList<SawBlade>();
ArrayList<StuckSaw> stuck = new ArrayList<StuckSaw>();
ArrayList<Grenade> grenades = new ArrayList<Grenade>();
ArrayList<Bolt> bolts = new ArrayList<Bolt>();
ArrayList<Indicator> arrows = new ArrayList<Indicator>();
ArrayList<Item> potions = new ArrayList<Item>();
ArrayList<Panel> panels = new ArrayList<Panel>();
ArrayList<Tweet> tweets = new ArrayList<Tweet>(); 
int panel = 0;
int workerNum = 2000;
boolean purchasingTower = false;
boolean purchasingDeployable = false;  //If deploying a deployable
String deployableName;
Tower clickedTower;        //Is the current tower selected 
Tower prevTower;           //The tower selected before the clicked tower 

//Load sounds
SoundFile dayMusic, nightMusic, sparks;
SoundFile reload1, reload2, reload3;
SoundFile chainsawRev, chainsawRel;
SoundFile thunder1, thunder2, enteredIn, enteredIn2;
SoundFile screech1, guts1, roar1, chainsawRev2;
SoundFile shot1, shot2, shot3;
SoundFile inflate, bash, click1, click2, click3, tweet1, tweet2;
SoundFile notification, rumble, ding, levelEnd, advanceLevel, purchase;
SoundFile zombieGrunt1, zombieGrunt2, zombieGrunt3, zombieGrunt4, zombieGrunt5, zombieGrunt6, zombieGrunt7, zombieGrunt8, zombieGrunt9;
SoundFile innoGrunt1, innoGrunt2, innoGrunt3, innoGrunt4, innoGrunt5, innoGrunt6, innoGrunt7;
int lastUsedDeathSound = 1;
ArrayList<SoundFile> grunts = new ArrayList<SoundFile>();
ArrayList<SoundFile> innoGrunt = new ArrayList<SoundFile>();
//Load fonts
PFont largeFont, medFont, smallFont;

//Load images
PImage advance, trees, arrowLeft, arrowRight;

PImage help0, help1, help2, help3;

PImage buildIcon, recallIcon, splitterIcon, trashIcon, helpIcon;
PImage chainsawIcon, featherIcon, gunIcon, houseIcon;
PImage molotovIcon, freezeIcon, reinforceIcon;
PImage damageIcon, grenadeIcon, growIcon, heartbleedIcon, heartIcon;
PImage lessTimeIcon, gunsIcon, peopleIcon, rangeIcon, skullIcon;

PImage lockedIcon, unlockedIcon;

PImage damageAreaEffectIcon, bankruptIcon, chainsawBloodyIcon, doubleIcon, tripleIcon;
PImage eyeballIcon, globeIcon, lightningIcon, snowflakeIcon, doubleDamageIcon;

PImage terrain1, terrain2, terrain3;
PImage rocket1, rocket2, rocket3, chainsawImg;

PImage spin0, spin1, spin2, spin3, spin4, spin5, spin6;

PImage art1, art2, art3, art4, art5, art6, art7, art8;
PImage hos1, hos2, hos3, hos4, hos5, hos6, hos7, hos8;
PImage fac1, fac2, fac3, fac4, fac5, fac6, fac7, fac8;
PImage wri1, wri2, wri3, wri4, wri5, wri6;

PImage z1walk1, z1walk2, z1freeze, z1burn, z1attack, z1death;
PImage z2walk1, z2walk2, z2freeze, z2burn, z2attack, z2death;
PImage z3walk1, z3walk2, z3freeze, z3burn, z3attack, z3death;

PImage k1walk1, k1walk2, k1walk3, k1freeze, k1burn, k1death;
PImage k2walk1, k2walk2, k2walk3, k2freeze, k2burn, k2death;
PImage k3walk1, k3walk2, k3walk3, k3freeze, k3burn, k3death;

PImage tutReg, tutHappy, tutSword1, tutSword2, tutSword3, tutSword4, tutSword5, tutSword6, tutHacked, tutBoost, tutJet1, tutJet2, tutJet3;

PImage c1walk1, c1walk2, c1freeze, c1burn, c1death;
PImage c2walk1, c2walk2, c2freeze, c2burn, c2death;

PImage s1walk1, s1walk2, s1freeze, s1burn, s1attack, s1scream, s1death1, s1death2, s1death3, s1death4, s1death5;

PImage b1walk1, b1walk2, b1walk3, b1freeze, b1burn, b1attack1, b1attack2, b1attack3, b1death1, b1death2, b1death3, b1death4, b1death5;
PImage b1death6, b1death7, b1death8, b1death9, b1death10, b1death11, b1death12, b1death13, b1death14, b1death15, b1death16, b1death17;
PImage b1death18, b1death19, b1death20, b1death21;

void loadStat() {
  if (curStats == null) {
  } else {
    curStats.displayStats();
  }
}

void loadImages() {                              //Load every game image
  b1walk1 = loadImage("bossZombie00.png");      //Load Gutter Boss sprites
  b1walk2 = loadImage("bossZombie01.png");
  b1walk3 = loadImage("bossZombie02.png");
  b1attack1 = loadImage("bossZombie03.png");
  b1attack2 = loadImage("bossZombie04.png");
  b1attack3 = loadImage("bossZombie05.png");
  b1burn = loadImage("bossBurn.png");
  b1freeze = loadImage("bossFreeze.png");
  b1death1 = loadImage("bossZombie06.png");
  b1death2 = loadImage("bossZombie07.png");
  b1death3 = loadImage("bossZombie08.png");
  b1death4 = loadImage("bossZombie09.png");
  b1death5 = loadImage("bossZombie10.png");
  b1death6 = loadImage("bossZombie11.png");
  b1death7 = loadImage("bossZombie12.png");
  b1death8 = loadImage("bossZombie13.png");
  b1death9 = loadImage("bossZombie14.png");
  b1death10 = loadImage("bossZombie15.png");
  b1death11 = loadImage("bossZombie16.png");
  b1death12 = loadImage("bossZombie17.png");
  b1death13 = loadImage("bossZombie18.png");
  b1death14 = loadImage("bossZombie19.png");
  b1death15 = loadImage("bossZombie20.png");
  b1death16 = loadImage("bossZombie21.png");
  b1death17 = loadImage("bossZombie22.png");
  b1death18 = loadImage("bossZombie23.png");
  b1death19 = loadImage("bossZombie24.png");
  b1death20 = loadImage("bossZombie25.png");
  b1death21 = loadImage("bossZombie26.png");

  help0 = loadImage("help0.png");               //Load help signs
  help1 = loadImage("help1.png");               //Load help signs
  help2 = loadImage("help2.png");               //Load help signs
  help3 = loadImage("help3.png");               //Load help signs

  advance = loadImage("advance.png");           //Load arrows
  trees = loadImage("forest.png");              //Load tree background
  arrowLeft = loadImage("arrowLeft.png");       //Load arrow
  arrowRight = loadImage("arrowRight.png");     //Load arrow

  tutReg  = loadImage("tutorial00.png");        //Load tBot sprites
  tutHappy = loadImage("tutorial01.png");
  tutSword1 = loadImage("tutorial02.png");
  tutSword2 = loadImage("tutorial03.png");
  tutSword3 = loadImage("tutorial04.png");
  tutSword4 = loadImage("tutorial05.png");
  tutSword5 = loadImage("tutorial06.png");
  tutSword6 = loadImage("tutorial07.png");
  tutHacked = loadImage("tutorial08.png");
  tutBoost = loadImage("tutorial09.png");
  tutJet1 = loadImage("tutorial10.png");
  tutJet2 = loadImage("tutorial11.png");
  tutJet3 = loadImage("tutorial12.png");

  s1walk1 = loadImage("ScreamerWalk.png");      //Load Screamer sprites
  s1walk2 = loadImage("ScreamerWalk2.png");
  s1attack = loadImage("ScreamerAttack.png");
  s1scream = loadImage("ScreamerFreeze.png");
  s1burn = loadImage("ScreamerBurn.png");
  s1freeze = loadImage("ScreamerFreeze.png");
  s1death1 = loadImage("ScreamerDeath1.png");
  s1death2 = loadImage("ScreamerDeath2.png");
  s1death3 = loadImage("ScreamerDeath3.png");
  s1death4 = loadImage("ScreamerDeath4.png");
  s1death5 = loadImage("ScreamerDeath5.png");

  c1walk1 = loadImage("innocent1walk1.png");  //Load Innocent 1 sprites
  c1walk2 = loadImage("innocent1walk2.png");
  c1burn = loadImage("innocent1burn.png");
  c1freeze = loadImage("innocent1freeze.png");
  c1death = loadImage("innocent1death.png");

  c2walk1 = loadImage("innocent2walk1.png");  //Load Innocent 2 sprites
  c2walk2 = loadImage("innocent2walk2.png");
  c2burn = loadImage("innocent2burn.png");
  c2freeze = loadImage("innocent2freeze.png");
  c2death = loadImage("innocent2death.png");

  k1walk1 = loadImage("knight1walk1.png");    //Load Knight 1 sprites
  k1walk2 = loadImage("knight1walk2.png");
  k1walk3 = loadImage("knight1walk3.png");
  k1burn = loadImage("knight1Burn.png");
  k1freeze = loadImage("knight1Freeze.png");
  k1death = loadImage("knight1Death.png");

  k2walk1 = loadImage("knight2walk1.png");    //Load Knight 2 sprites
  k2walk2 = loadImage("knight2walk2.png");
  k2walk3 = loadImage("knight2walk3.png");
  k2burn = loadImage("knight2Burn.png");
  k2freeze = loadImage("knight2Freeze.png");
  k2death = loadImage("knight2Death.png");

  k3walk1 = loadImage("knight3walk1.png");    //Load Knight 3 sprites
  k3walk2 = loadImage("knight3walk2.png");
  k3walk3 = loadImage("knight3walk3.png");
  k3burn = loadImage("knight3Burn.png");
  k3freeze = loadImage("knight3Freeze.png");
  k3death = loadImage("knight3Death.png");

  z1walk1 = loadImage("zombie1walk1.png");    //Load Zombie 1 sprites
  z1walk2 = loadImage("zombie1walk2.png");
  z1attack = loadImage("zombie1attack.png");
  z1burn = loadImage("zombie1burn.png");
  z1freeze = loadImage("zombie1freeze.png");
  z1death = loadImage("zombie1death.png");

  z2walk1 = loadImage("zombie2walk1.png");    //Load Zombie 2 sprites
  z2walk2 = loadImage("zombie2walk2.png");
  z2attack = loadImage("zombie2attack.png");
  z2burn = loadImage("zombie2burn.png");
  z2freeze = loadImage("zombie2freeze.png");
  z2death = loadImage("zombie2death.png");

  z3walk1 = loadImage("zombie3walk1.png");    //Load Zombie 3 sprites
  z3walk2 = loadImage("zombie3walk2.png");
  z3attack = loadImage("zombie3attack.png");
  z3burn = loadImage("zombie3burn.png");
  z3freeze = loadImage("zombie3freeze.png");
  z3death = loadImage("zombie3death.png");

  buildIcon = loadImage("Build.png");        //Load phone icon sprites
  recallIcon = loadImage("Recall.png");
  splitterIcon = loadImage("Splitter.png");
  helpIcon = loadImage("Help.png");
  trashIcon = loadImage("Trash.png");

  lockedIcon = loadImage("lockTrue.png");          //Load lock icon sprites
  unlockedIcon = loadImage("lockFalse.png");      

  damageIcon = loadImage("damageIcon.png");          //Load upgrade icon sprites
  grenadeIcon = loadImage("grenadeIcon.png");
  growIcon = loadImage("growIcon.png");
  heartbleedIcon = loadImage("heartbleedIcon.png");
  heartIcon = loadImage("heartIcon.png");
  lessTimeIcon = loadImage("lessTimeIcon.png");
  gunsIcon = loadImage("moreGunsIcon.png");
  peopleIcon = loadImage("morePeopleIcon.png");
  rangeIcon = loadImage("rangeIcon.png");
  skullIcon = loadImage("skullIcon.png");
  damageAreaEffectIcon = loadImage("iconAreaEffect.png");
  bankruptIcon = loadImage("iconBankrupt.png");
  chainsawBloodyIcon = loadImage("iconChainsaw.png");
  doubleIcon = loadImage("iconDouble.png");
  tripleIcon = loadImage("iconTriple.png");
  eyeballIcon = loadImage("iconEyeball.png");
  globeIcon = loadImage("iconGlobe.png");
  lightningIcon = loadImage("iconLightning.png");
  snowflakeIcon = loadImage("iconSnowflake.png");
  doubleDamageIcon = loadImage("iconDoubleDamage.png");

  chainsawIcon = loadImage("Chainsaw.png");          //Load tower icon sprites
  featherIcon = loadImage("Feather.png");
  gunIcon = loadImage("Gun.png");
  houseIcon = loadImage("House.png");

  molotovIcon = loadImage("iconMolotov.png");        //Load deployable icons
  freezeIcon = loadImage("iconFreezeGrenade.png");
  reinforceIcon = loadImage("iconReinforce.png");

  terrain1 = loadImage("Terrain1.png");              //Load ground sprites
  terrain2 = loadImage("Terrain2.png");
  terrain3 = loadImage("Terrain3.png");

  chainsawImg = loadImage("ChainsawObject.png"); 
  
  rocket1 = loadImage("rocket0.png");              //Load rocket sprites
  rocket2 = loadImage("rocket1.png");
  rocket3 = loadImage("rocket2.png");
  
  spin0 = loadImage("spinning0.png"); 
  spin1 = loadImage("spinning1.png"); 
  spin2 = loadImage("spinning2.png"); 
  spin3 = loadImage("spinning3.png"); 
  spin4 = loadImage("spinning4.png"); 
  spin5 = loadImage("spinning5.png"); 
  spin6 = loadImage("spinning6.png"); 
  
  art1 = loadImage("a1.png");    //Load artillery tower animation sprites
  art2 = loadImage("a2.png");
  art3 = loadImage("a3.png");
  art4 = loadImage("a4.png");
  art5 = loadImage("a5.png");
  art6 = loadImage("a6.png");
  art7 = loadImage("a7.png");
  art8 = loadImage("a8Fire.png");

  wri1 = loadImage("t1.png");    //Load writers tent tower animation sprites
  wri2 = loadImage("t2.png");
  wri3 = loadImage("t3.png");
  wri4 = loadImage("t4.png");
  wri5 = loadImage("t5.png");
  wri6 = loadImage("t6.png");

  hos1 = loadImage("h1.png");    //Load hostel tower animation sprites
  hos2 = loadImage("h2.png");
  hos3 = loadImage("h3.png");
  hos4 = loadImage("h4.png");
  hos5 = loadImage("h5.png");
  hos6 = loadImage("h6.png");
  hos7 = loadImage("h7.png");
  hos8 = loadImage("h8.png");

  fac1 = loadImage("c1.png");    //Load factory tower animation sprites
  fac2 = loadImage("c2.png");
  fac3 = loadImage("c3.png");
  fac4 = loadImage("c4.png");
  fac5 = loadImage("c5.png");
  fac6 = loadImage("c6.png");
  fac7 = loadImage("c7.png");
  fac8 = loadImage("c8.png");
}

void loadSounds() {              //Load all ingame sounds
  dayMusic = new SoundFile(this, "dayMusic.mp3");
  nightMusic = new SoundFile(this, "nightMusic.mp3");
  sparks = new SoundFile(this, "sparks.mp3");
  reload1 = new SoundFile(this, "reload1.wav");  //Gun reload sounds
  reload2 = new SoundFile(this, "reload2.wav");
  reload3 = new SoundFile(this, "reload3.wav");
  rumble = new SoundFile(this, "rumble.wav");    //Hostel 
  notification = new SoundFile(this, "notification.mp3");
  advanceLevel = new SoundFile(this, "advanceLevel.mp3");
  tweet1 = new SoundFile(this, "tweet1.wav");
  tweet2 = new SoundFile(this, "tweet2.mp3");
  click1 = new SoundFile(this, "click.wav");
  click2 = new SoundFile(this, "click2.wav");
  click3 = new SoundFile(this, "click3.wav");
  chainsawRev2 = new SoundFile(this, "chainsawRev2.wav");
  purchase = new SoundFile(this, "correct.wav");
  roar1 = new SoundFile(this, "roar.wav");
  bash = new SoundFile(this, "bash.wav");
  enteredIn = new SoundFile(this, "entered.wav");
  enteredIn2 = new SoundFile(this, "entered2.wav");
  levelEnd = new SoundFile(this, "endOfLevel.mp3");
  ding = new SoundFile(this, "ding.wav");
  shot1 = new SoundFile(this, "shot1.wav");
  shot2 = new SoundFile(this, "shot2.wav");
  shot3 = new SoundFile(this, "shot3.wav");
  inflate = new SoundFile(this, "inflate.aiff");
  thunder1 = new SoundFile(this, "thunder1.aiff");
  thunder2 = new SoundFile(this, "thunder2.wav");
  zombieGrunt1 = new SoundFile(this, "zombieGrunt.wav");
  zombieGrunt2 = new SoundFile(this, "zombieGrunt1.wav");
  zombieGrunt3 = new SoundFile(this, "zombieGrunt2.wav");
  zombieGrunt4 = new SoundFile(this, "zombieGrunt3.wav");
  zombieGrunt5 = new SoundFile(this, "zombieGrunt4.mp3");
  zombieGrunt6 = new SoundFile(this, "zombieGrunt5.wav");
  zombieGrunt7 = new SoundFile(this, "zombieGrunt6.wav");
  zombieGrunt8 = new SoundFile(this, "zombieGrunt7.wav");
  zombieGrunt9 = new SoundFile(this, "zombieGrunt8.wav");
  screech1 = new SoundFile(this, "screech.wav");
  guts1 = new SoundFile(this, "guts1.aif");
  chainsawRev = new SoundFile(this, "chainsawRev.wav");
  chainsawRel = new SoundFile(this, "chainsawReload.wav");
  grunts.add(zombieGrunt1);
  grunts.add(zombieGrunt2);
  grunts.add(zombieGrunt3);
  grunts.add(zombieGrunt4);
  grunts.add(zombieGrunt5);
  grunts.add(zombieGrunt6);
  grunts.add(zombieGrunt7);
  grunts.add(zombieGrunt8);
  grunts.add(zombieGrunt9);

  innoGrunt1 = new SoundFile(this, "innocentDeathSound1.wav");
  innoGrunt2 = new SoundFile(this, "innocentDeathSound2.wav");
  innoGrunt3 = new SoundFile(this, "innocentDeathSound3.wav");
  innoGrunt4 = new SoundFile(this, "innocentDeathSound4.wav");
  innoGrunt5 = new SoundFile(this, "innocentDeathSound5.wav");
  innoGrunt6 = new SoundFile(this, "wilhelm.wav");
  innoGrunt7 = new SoundFile(this, "myLeg.mp3");
  innoGrunt.add(innoGrunt1);
  innoGrunt.add(innoGrunt2);
  innoGrunt.add(innoGrunt3);
  innoGrunt.add(innoGrunt4);
  innoGrunt.add(innoGrunt5);
  innoGrunt.add(innoGrunt6);
  innoGrunt.add(innoGrunt7);
}

void loadFonts() {      //Load fonts (in variety of sizes)
  largeFont = loadFont("CenturyGothic-48.vlw");
  medFont = loadFont("CenturyGothic-28.vlw");
  smallFont = loadFont("CenturyGothic-12.vlw");
}

void loadTowers() {    //Add towers to tower list, add icon, desc., and cost
  towers.add(new BuildIcon(gunIcon, "Shoot zombies with guns.\nIt's v effective for controlling\nbasic bitches.", 20));                                          //towers.get(0)
  towers.add(new BuildIcon(featherIcon, "Write off zombies that get in\nyour way. Takes a while\nbut it'll do the trick.", 25));                                 //towers.get(1)
  towers.add(new BuildIcon(houseIcon, "Non-hostile tower used to hold\naccidents until they can safe-\nly reach your worker roster.", 15));                      //towers.get(2)
  towers.add(new BuildIcon(chainsawIcon, "Construct a faulty chainsaw\nfactory that launches conviently\nplaced chainsaws above your\nenemies", 15));            //towers.get(3)
  towers.add(new BuildIcon(reinforceIcon, "Deploy one of your workers\nout on the field to fend\noff enemies. Don't expect\nthem to come back.", 3));            //towers.get(4)
  towers.add(new BuildIcon(freezeIcon, "Time to get Elsa on these\nbitches. Grab a freeze gre-\nnade and Let It Go on top of a\nclusterof zombies.", 5));        //towers.get(5)
  towers.add(new BuildIcon(molotovIcon, "Unleash Supa Hot Fire on\nthe field, burning all\nthe monsters under your\nMolotov.", 5));                              //towers.get(6)
}

void setCells() {    //Set 3 different maps of grid pieces
  for (int i = 0; i <= 15; i++) {
    for (int j = 0; j <= 7; j++) {
      Grid temp = new Grid((i * 50) + 50, (j * 50) + 50);
      map1.add(temp);
      temp = new Grid((i * 50) + 50, (j * 50) + 50);
      map2.add(temp);
    }
  }
  for (int i = 0; i< 10; i++) {
    // int rand = (int) random(8, map2.size());
    // map2.get(rand).hold = true;       //Be purchased
    // ArrayList<PImage> sprites = new ArrayList<PImage>();          //Add spawning animation
    //sprites.add(hos8);
    // Home newHostel = new Home(map2.get(rand).x, map2.get(rand).y + random(0, 50), hos8, map2.get(rand), false);                 //Create new Hostel at mouse location
    //homeTowers.add(newHostel);                                                    //Add to towers list
  }
}

void activate(int g) {    //Activate each map depending on the scrolling buttons
  for (int i = 0; i < map1.size(); i++) {  //Deactivate every map
    map1.get(i).setActive(false);
  }
  for (int i = 0; i < map2.size(); i++) {
    map2.get(i).setActive(false);
  }
  for (int i = 0; i < map3.size(); i++) {
    map3.get(i).setActive(false);
  }
  if (g == 0) {                            //Depending on what as passed in, activate that numbers map
    for (int i = 0; i < map1.size(); i++) {
      map1.get(i).setActive(true);
    }
  } else if (g == 1) {
    for (int i = 0; i < map2.size(); i++) {
      map2.get(i).setActive(true);
    }
  } else if (g == 2) {
    for (int i = 0; i < map3.size(); i++) {
      map3.get(i).setActive(true);
    }
  }
}

void drawHomeBase() {
  for (int i = 0; i < homeTowers.size(); i++) {
    homeTowers.get(i).update();
    homeTowers.get(i).drawTower();
  }
}

void updateParticles() {
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).drawParticle();
    particles.get(i).updateParticle();
  }
}
void updateLevel() {
  wave = levelNumber + 1;
  if (musicStarted) {
    dayMusic.stop();
    nightMusic.play();
    musicStarted = false;
  }
  if (currentLevel != null) {    //If the level exists
    //currentLevel.sendWave();
    currentLevel.playLevel();
  }
}

void updateItems() {      //Updates all items
  for (int i = 0; i < sawBlades.size(); i++) {    //updates Saw from factory
    sawBlades.get(i).update();
  }
  for (int i = 0; i < arrows.size(); i++) {    //updates the arrows at level transition!
    arrows.get(i).drawIndicator();
    arrows.get(i).updateIndicator();
  }
  for (int i = 0; i < stuck.size(); i++) {    //updates the arrows at level transition!
    stuck.get(i).drawSaw();
    stuck.get(i).updateSaw();
  }
  for (int i = 0; i < bolts.size(); i++) {    //updates the arrows at level transition!
    bolts.get(i).drawBolt();
    bolts.get(i).updateBolt();
  }
  for (int i = 0; i < potions.size(); i++) { //Updates potions, including molotov's and freeze grenades
    potions.get(i).drawItem();
    potions.get(i).updateItem();
  }
  for (int i = 0; i < grenades.size(); i++) { //Updates grenades
    grenades.get(i).update();
  }
}

void updateStats() {            //Updates the current stats card
  if (clickedTower != null) {

    curStats = clickedTower.stat;  //As long as there's a clicked tower, set the current stats card to be that tower's stats
    if (curStats != null) {        //If we have something to display
      if (showStat) {              //If the tutorials/other source allow for stats to be displayed
        curStats.displayStats();    //Show it
      }
    }
  } else {
    if (tutorialStage == 7) {
      tutorialStage++;
    }
  }
}

void setLevel() {                //Unleashes a wave of zombies specified by the for loop parameters
  removable = false;
  for (int i = 0; i < 8; i++) {          //Amount of zombies spawned
    getZombie();
  }
  for (int i = 0; i < 2; i++) {          //Amount of screamers spawned
    getScreamer();
  }
  for (int i = 0; i < 10; i++) {          //Amount of refugees spawned
    getRefugee();
  }
  getGutter();                        //One gutter (Boss) spawned
}

void loadMenuAssests() {                //Loads everything specifc to the loading menu
  birthday = new SoundFile(this, "musicBirthday.wav");
  ambience = new SoundFile(this, "ambience.wav");
  logo = loadImage("logo.png");
  play = loadImage("play.png");
  rules = loadImage("rules.png");
  menu = loadImage("menu.png");
  credits = loadImage("credits.png");
  size(900, 650);
  noStroke();
  frameRate(30);
  surface.setTitle("Dead Man Walking");
  noCursor();
  playButton = new MenuButton(width/2, height/2 + 70, 50, play, "play");
  buttons.add(playButton);
  helpButton = new MenuButton(width/2, height/2 + 120, 50, rules, "rules");
  buttons.add(helpButton);
  creditsButton = new MenuButton(width/2, height/2 + 170, 50, credits, "credits");
  menuButton = new MenuButton(width/2, height/2 + 170, 50, menu, "menu");
  buttons.add(creditsButton);
  birthday.amp(1);
  ambience.amp(1);
  birthday.loop();
  ambience.loop();
  timeA = millis() + (ambience.duration() * 1000);
  timeB = millis() + (birthday.duration() * 1000);
}

void setup() {
  size(900, 650);      //Set size
  noStroke();
  frameRate(30);        //30 fps
  surface.setTitle("Dead Man Walking");  //Set window title
  activate(0);                           //Activate first map
  setCells();    //Generate maps
  //setLevel();    //Generate maps   (uncomment to start zombie wave)
  loadFonts();    //Load game assests
  loadImages();
  loadSounds();
  loadUpgrades();  //Refers to the upgrade tab
  loadTowers();  //Load tower icons
  loadMenuAssests();
}

void draw() {
  if (gameView == 1) {  //If in the game (non loading screen)
    birthday.stop();    //Stop any music that could be playing from loading screen
    ambience.stop();
    cursor();                  //Reveal the cursor
    background(109, 135, 64);  //Set background to grass colour

    image(trees, 0, 0);     //Draw the forest
    tint(122, 178, 83, 255);

    tint(122, 178, 83, 255);
    image(trees, 0, 0);     //Draw the forest
    noTint();                  //Take off any tinting
    fill(30);                  //Fill for wall (grey)
    rect(0, 3 * (height / 4), width, 400);    //Draw wall bottom border
    fill(100);                                //Draw UI bubbles
    rect(width / 2 - 30, 500, 100, 140, 10);
    rect(width / 2 - 130, 500, 320, 140, 10);
    rect(width / 2 + 210, 500, 100, 60, 10);
    rect(width / 2 + 330, 500, 100, 60, 10);
    rect(width / 2 + 210, 580, 220, 60, 10);

    //Display player info
    textAlign(CENTER);
    textFont(medFont);                //Set to medium font
    textSize(20);                     //Size 20?? (ikr redundant)
    fill(255);                        //Set white
    text(population, width / 2 + 380, 545);    //Set population value (placeholder #)
    textSize(18);      
    fill(225);
    text("POP", width / 2 + 380, 525);   //Display population label

    textAlign(CENTER);
    textSize(20);
    fill(255);
    text(wave, width / 2 + 260, 545);    //Display wave # (placeholder #)
    textSize(18);
    fill(225);
    text("WAVE", width / 2 + 260, 525); //Display wave label

    textAlign(CENTER);
    textSize(20);
    fill(255);
    if (tutorialStage >= TUTORIAL_MAX || tutorialStage == 40) {
      text(workerNum, width / 2 + 320, 630);            //Display worker # (currency)
    } else {
      text("ON THE HOUSE", width / 2 + 320, 630);            //Display worker # (currency)
    }
    textSize(18);
    fill(225);
    text("WORKERS AVAILABLE", width / 2 + 320, 605);  //Display workers label

    activate(0);                              //Activate first map
    fill(200, 240, 255, 200);
    ellipse(25, height / 2, 30, 30);          //idk what this does but I'm scared to remove it
    ellipse(width - 25, height / 2, 30, 30);  //These circles will get overlayed by the floor pieces

    if (view == 0) {                            //If on map #1
      for (int i = 0; i < map1.size(); i++) {
        map1.get(i).updateCell(view);         //Update and draw each turf piece
        map1.get(i).drawCell();
      }
      updateDeadZombies();                      //Check for dead zombies before drawing towers
      for (int i = 0; i < towersList.size(); i++) {
        towersList.get(i).drawTower();          //Draw each tower
      }
    } else if (view == 1) {                     //If on map #2
      for (int i = 0; i < map2.size(); i++) {
        map2.get(i).updateCell(view);        //Update and draw each turf piece 
        map2.get(i).drawCell();
        drawHomeBase();
      }
    } else if (view == 2) {                    //If on map #3
      for (int i = 0; i < map3.size(); i++) {
        map3.get(i).updateCell(view);        //Update and draw each turf piece
        map3.get(i).drawCell();
      }
    }

    updateParticles();  //Update and draw every existing particle

    updateStats();      //update and draw the current stats card
    updateZombies();    //Update and draw every existing zombie
    updateTowers();     //Update and draw every existing tower
    updateItems();      //Update and draw every item
    if (nextWave) {
      updateLevel();                //If currently playing a level
    } else {                          //If building towers in between levels
      updateNextLevel();
    }
    updateDeployables();      //Update and draw every item
    updateTowerUI();    //Update and draw every tower upgrade interface


    phone.drawPhone();    //Draw the phone
    phone.updatePhone();  //Update the phone
    updateButtons();    //Update all tower UI buttons

    textSize(10);    //Display the mouse's X and Y value for testing
    fill(255, 60);

    //Add tutorials
    if (tutorialStage < TUTORIAL_MAX) {                                        //If the tutorial number is less than the last #
      runTutorial();                                                         //Run the tutorial
    } else if (tutorialStage == TUTORIAL_MAX) {                                 //Remove if the tutorial is complete
      tutorialStage++;
    } else if (tutorialStage == TUTORIAL_MAX + 1) {                                 //Remove if the tutorial is complete
      if (nextWave) {                                      //If the player has built towers and is ready for the next wave
        Level l1 = new Level(0, 15, 0, 0, 0);             //Create new level
        currentLevel = l1;                               //Set it to the current level
        panels.add(new Panel(help0, "1 DAMAGE\nLOW HEALTH\nSLOW SPEED\nINFECTS REFUGEES\nCAN GROUP INTO HOARDES"));
        panels.add(new Panel(help1, "NO DAMAGE\nLOW HEALTH\nIF UNMARKED, TARGETED\nCLICK TO MARK\nADDS TO WORKERS IF IN HOSTEL"));
        panels.add(new Panel(help2, "25 DAMAGE\nHIGH HEALTH\nVERY SLOW SPEED\nATTACK TOWERS\nHIGH WORKER REWARD"));
        panels.add(new Panel(help3, "5 DAMAGE\nLOW HEALTH\nAVERAGE SPEED\nSCREAMS APPLY SPEED BOOST\nTO ALL NEARBY ZOMBIES"));
        tutorialStage++;                                 //Move out of tutorial loop
      }
    }
  } else {                    //If on the OG loadout screen on start
    drawMenu();             //Draw the menu (using the setup's draw() method)
    noStroke();
    updateParticles();      //Update and draw particles
    if (millis() > timeA) {    //If the ambient music finishes
      ambience.play();         //Play it again
      timeA = millis() + (ambience.duration() * 1000);  //Reset the expiry time until one more loop
    }
    if (millis() > timeB) {      //If the birthday music finishes
      birthday.play();         //Play it again
      timeB = millis() + (birthday.duration() * 1000);  //Reset the expiry time until one more loop
    }
  }

  if (population <= 0) {
    gameOver = true;
  }
  if (gameOver == true) {
    drawGameOver();
  }
  fill(255, 255, 255, 255);
  if(currentLevel!= null){
  //text(levelNumber + ", ZOMB: " + currentLevel.numZombies + ", SCREAM: " + currentLevel.numScreamers  + ", CIV: " + currentLevel.numCivilians  + ", BLOAT: " + currentLevel.numBloaters, mouseX, mouseY);  //TESTING
}}

void drawGameOver() {

  int score = 0;
  for (int i = 0; i < towersList.size(); i++) {
    score += towersList.get(i).killCount;          //Draw each tower
  }

  fill(0, 0, 0, gameOverOpacity);
  rect(0, 0, 1000, 1000);
  fill(206, 26, 26, gameOverOpacity);
  textFont(largeFont);
  textSize(68);
  textAlign(CENTER);
  text("GAME OVER", width / 2, 250);
  textSize(30);
  text("Score: "+score, width / 2, 300);

  rect(width / 2 - 75, 320, 150, 50, 10);
  fill(0, 0, 0, gameOverOpacity);
  textSize(38);
  text("QUIT", width / 2, 357);
  if(gameOverOpacity == 0){
    roar1.play();
  }
  gameOverOpacity+=5;
  
}

void runTutorial() {      //Runs through every tutorial fragment before running the first level
  if (!tutMusicStarted) {
    tutMusicStarted = true;
    dayMusic.play();
  }
  fill(255);
  if (tutorialStage == 0) {
    tint(255, 255);
    image(tutReg, width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    //text(formatSpeech("TBOT:\nHoly shit was I asleep for a long time!?! Give me a second, feeling a little bit hungover.\n[click anywhere to continue]", 23), width / 2 + 20, 520); //If sword
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nHoly shit! Was I asleep for a long time or what..? Give me a second, feeling a little bit hungover... gotta love Thirsty Thursdays-am I right?\n[click anywhere to continue]", 33), width / 2 - 30, 520);
  } else if (tutorialStage == 1) {
    tint(255, 255);
    image(tutHappy, width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    //text(formatSpeech("TBOT:\nHoly shit was I asleep for a long time!?! Give me a second, feeling a little bit hungover.\n[click anywhere to continue]", 23), width / 2 + 20, 520); //If sword
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nIt looks like the sun will set any second now, I guess I'll show you how to defend your clan. Let's start by opening up your phone and clicking on the Build app.\n", 30), width / 2 - 30, 520);
    if (phone.stage == "build") {
      tutorialStage++;
      workerNum = 1000000;
    }
  } else if (tutorialStage == 2) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    fill(0, 255, 0, 100);
    rect(250, 265, width - 295, 50, 10);
    tint(0, 255, 0, 150);
    image(z1walk1, 20, 280);
    //text(formatSpeech("TBOT:\nHoly shit was I asleep for a long time!?! Give me a second, feeling a little bit hungover.\n[click anywhere to continue]", 23), width / 2 + 20, 520); //If sword
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nStill with me? Great. This app shows you all your available towers and if you have enough civilians, you can send them out to deploy that tower. Looks like there's a groaning pile of shit heading your way. Place an artillery tower down along that strip.", 30), width / 2 - 30, 520);
    //Tutorial is advance under the grid.updateCell() method
  } else if (tutorialStage == 3) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    image(z1walk1, 20, 280);
    //text(formatSpeech("TBOT:\nHoly shit was I asleep for a long time!?! Give me a second, feeling a little bit hungover.\n[click anywhere to continue]", 23), width / 2 + 20, 520); //If sword
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nThe artillery tower is great for spreading a little damage over a small range. You can upgrade it later to make it actually effective. Enough  talking, let's nail these bitches!\n[click anywhere to continue]", 30), width / 2 - 30, 520);
    //Tutorial is advanced under the mouseReleased() function
  } else if (tutorialStage == 4) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    getZombie(20, 280, 0.8, 4);
    tutorialStage++;
  } else if (tutorialStage == 5) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    //tutorial is advanced   
    if (zombies.size() == 0) {
      tutorialStage++;  //Advance the tutorial if the zombie is dead
      tutBotFrame = 0;
      tutTimeAnim = millis() + 50;
    }
  } else if (tutorialStage == 6) {
    PImage[] anim = new PImage[]{tutJet1, tutJet2, tutJet3}; 
    if (tutBotFrame == 0 && (millis() > tutTimeAnim)) {
      tutBotFrame = 1;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 1&& (millis() > tutTimeAnim)) {
      tutBotFrame = 2;
      tutTimeAnim = millis() + 150;
    }
    if (tutBotFrame == 2&& (millis() > tutTimeAnim)) {
      tutBotFrame = 0;
      tutTimeAnim = millis() + 150;
    }
    tint(255, 255);
    image(anim[tutBotFrame], width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nGood shit, mah dude!\nDon't get too comfy, that one was definitely dropped on the head... the others won't be as easy. Let's look at your towers stats. Click on your tower to grab its info, and when you're ready to continue click away.", 30), width / 2 - 30, 520);
    //Tutorial is advanced through activating the stats screen
  } else if (tutorialStage == 7) {
    tint(255, 255);
    //Tutorial is advanced through activating the stats screen
  } else if (tutorialStage == 8) {
    PImage[] anim = new PImage[]{tutJet1, tutJet2, tutJet3}; 
    if (tutBotFrame == 0 && (millis() > tutTimeAnim)) {
      tutBotFrame = 1;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 1&& (millis() > tutTimeAnim)) {
      tutBotFrame = 2;
      tutTimeAnim = millis() + 150;
    }
    if (tutBotFrame == 2&& (millis() > tutTimeAnim)) {
      tutBotFrame = 0;
      tutTimeAnim = millis() + 150;
    }
    tint(255, 255);
    image(anim[tutBotFrame], width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    fill(0, 255, 0, 100);
    showStat = false;
    rect(250, 115, width - 295, 50, 10);
    tint(0, 255, 0, 150);
    image(z1walk1, 20, 170);
    image(z1walk1, 20, 90);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nIsn't that neat?! Lets build another tower. Grab a writer's tent and place it above the other guy.", 30), width / 2 - 30, 520);
    //Tutorial is advanced through activating the stats screen
  } else if (tutorialStage == 9) {
    PImage[] anim = new PImage[]{tutJet1, tutJet2, tutJet3}; 
    if (tutBotFrame == 0 && (millis() > tutTimeAnim)) {
      tutBotFrame = 1;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 1&& (millis() > tutTimeAnim)) {
      tutBotFrame = 2;
      tutTimeAnim = millis() + 150;
    }
    if (tutBotFrame == 2&& (millis() > tutTimeAnim)) {
      tutBotFrame = 0;
      tutTimeAnim = millis() + 150;
    }
    tint(255, 255);
    image(anim[tutBotFrame], width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    fill(0, 255, 0, 100);
    showStat = false;
    rect(250, 115, width - 295, 50, 10);
    tint(0, 255, 0, 150);
    image(z1walk1, 20, 170);
    image(z1walk1, 20, 90);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nGreat! These tents are full of sub-par writers from the hottest zombie apocalypse shows. They have the ability to conviently write off zombies from this game. They deal a chunk of damage, but they take a while to come up with creative ways to justify the deaths.\n[click anywhere to continue]", 30), width / 2 - 30, 520);
    //Tutorial is advanced through mouseReleased() function IMPLEMENT
  } else if (tutorialStage == 10) {
    tint(255, 255);
    image(tutHappy, width / 2 - 170, 510); //tutSword, width / 2 - 130, 510 //for sword animation position | text format max = 23
    getZombie(20, 170, 1, 4);
    getZombie(20, 90, 1.3, 4);
    tutorialStage++;
  } else if (tutorialStage == 11) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nTheir range is much larger than the Artillery tower but they are are slow as shit when it comes to shooting.", 30), width / 2 - 30, 520);
    if (zombies.size() == 0) {
      tutorialStage++;  //Advance the tutorial if the zombies are dead
      tutBotFrame = 0;
      tutTimeAnim = millis() + 50;
    }
  } else if (tutorialStage == 12) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nSay you notice some zombies trying to relocate to a different area of the map. Let's try deleting a tower. Open the Recall app on your phone (via top right button), select the garbage button and click on a tower's square.", 30), width / 2 - 30, 520);
    if (towersList.size() <= 1) {
      removable = false;
      tutorialStage++;  //Advance the tutorial if one or less towers exist
    }
  } else if (tutorialStage == 13) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nEverytime you nail a zombie, someone will tweet about your successes and join your clan-adding one worker to your supply. Workers are used to deploy towers, add upgrades, develop deployables or even be sent out to fight on their own. [click]", 30), width / 2 - 30, 520);
  } else if (tutorialStage == 14) {
    fill(0, 255, 0, 100);
    rect(40, 315, width - 85, 50, 10);
    tint(255, 255);
    image(tutHappy, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nTo send out a worker, go to your build app and find the sword icon. This gets sends one of your workers off their ass and into a suicide misison. Let's deploy a worker.", 30), width / 2 - 30, 520);
    //Advanced in mouseclicked
  } else if (tutorialStage == 15) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    getZombie(20, 315, 2, 4);
    tutorialStage++;    
    zombieTiming = millis() + 3000;
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nHe had a family.", 30), width / 2 - 30, 520);
  } else if (tutorialStage == 16) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    if (millis() > zombieTiming) {
      getZombie(20, 315, 1.5, 4);
      tutorialStage++;
    }
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nHe had a family.", 30), width / 2 - 30, 520);
  } else if (tutorialStage == 17) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    familyCount = 0;
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nHe had a family.", 30), width / 2 - 30, 520);
    if (zombies.size() == 0) {    //If all zombies and reinforcement die
      tutorialStage++;
    }
  } else if (tutorialStage == 18) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nY'know what? If you keep his family around, they'll try to avenge him. Send them out to die too. There is a lock button in your build app-turn that on, purchase a reinforcement, and click 5 times anywhere on the screen.", 30), width / 2 - 30, 520);
    //Advances after five puchases
    if (familyCount >= 5) {
      tutorialStage++;
    }
  } else if (tutorialStage == 19) {
    tint(255, 255);
    phone.locked = false;
    purchasingDeployable = false;
    deployableName = "";
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    familyCount = 0;
    text(formatSpeech("TBOT:\nWe can check family slaughter-er off the tutorial checklist. Now that we're this far, we are nearly done. You can also spend workers to develop dropable items like Molotovs and Nitrogen Grenades. Don't ask where they disappear after. It's fairly unethical.", 30), width / 2 - 30, 520);
    if (zombies.size() == 0) {    //If all zombies and reinforcement die
      temptimer = millis() + 500;
      tutorialStage++;
    }
  } else if (tutorialStage == 20) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nFinally, the family died. Let's bring out these grenades. Find the Molotovs and Freeze Grenades and drop a couple on this incoming hoarde. I placed some Lego on the field, so trust me, it'll take awhile. [click]", 30), width / 2 - 30, 520);
    //advances in the mouseReleased function()
  } else if (tutorialStage == 21) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    for (int i = 0; i < 50; i++) {
      getZombie(20, random(40, height - 210), random(0.2, 0.4), 4, false);
    }
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nFind them by the Reinforcements in the Build app.", 30), width / 2 - 30, 520);
    tutorialStage++;
    //advances in the mouseReleased function()
  } else if (tutorialStage == 22) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced   
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nFind them by the Reinforcements in the Build app.", 30), width / 2 - 30, 520);
    if (zombies.size() == 0) {    //If all zombies die
      temptimer = millis() + 500;
      tutorialStage++;
    }
  } else if (tutorialStage == 23) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    //tutorial is advanced  
    phone.locked = false;        //phone has reset parameters
    purchasingDeployable = false;
    deployableName = "";
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nWell I hope you had your fun, that's the rest of it you'll be getting today. TBH I'm getting bored of telling you what to do, so I'll show you one last thing, the rest you'll have to figure on your own.\n[click]", 30), width / 2 - 30, 520);
    //Advances during mouseReleased
  } else if (tutorialStage == 24) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nI forgot to tell you about one more important tower. Sometimes, within waves of zombies, there will be innocent refugees fleeing from their surronding threat. Because it's dark, if your towers see a human they will shoot it down until it's dead. Oops.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased
  } else if (tutorialStage == 25) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nOne way to prevent this situation is by clicking on the human and marking them for all the world to see. Marked refugees don't get shot, and you don't want to kill off the refugees. (I know, very unpresidental...) Try marking these refugees.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased
  } else if (tutorialStage == 26) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    Refugee r1 = new Refugee(0, random(80, height - 250));  //Creates Refugee at random position on the left side of the screenS
    zombies.add(r1);                                        ///Add to zombies list
    r1 = new Refugee(0, random(80, height - 250));  //Creates Refugee at random position on the left side of the screenS
    zombies.add(r1);
    r1 = new Refugee(0, random(80, height - 250));  //Creates Refugee at random position on the left side of the screenS
    zombies.add(r1);
    text(formatSpeech("TBOT:\nI could make another Trump dig, but I won't.", 30), width / 2 - 30, 520);
    tutorialStage++;
    //Advances during mouseReleased
  } else if (tutorialStage == 27) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nI could make another Trump shot but I won't.", 30), width / 2 - 30, 520);
    if (zombies.size() == 0) {
      tutorialStage++;
    }
    //Advances during mouseReleased
  } else if (tutorialStage == 28) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    fill(0, 255, 0, 100);
    rect(290, 365, width - 335, 50, 10);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nThe Hostel tower takes in refugees (marked or not) that wander close to the tower. They'll take people in until it's full, and at the end of each round you'll have all the taken in refugees added to your worker count. Build a Hostel.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased
  } else if (tutorialStage == 29) {
    tint(255, 255);
    purchasingTower = false;
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nNotice how once the Hostel is full, the other Refugees will run to the door to see if there's room, and when declined the refugees smile from the window watching as the rejects continue running for their life.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased  
    if (millis() > zombieTiming) {
      getRefugee(20, 375);
      zombieTiming = millis() + random(500, 2500);
      tutorialStage++;
    }
  } else if (tutorialStage == 30) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nNotice how once the Hostel is full, the other Refugees will run to the door to see if there's room, and when declined the refugees smile from the window watching as the rejects continue running for their life.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased  
    if (millis() > zombieTiming) {
      getRefugee(20, 375);
      zombieTiming = millis() + random(500, 2500);
      tutorialStage++;
    }
  } else if (tutorialStage == 31) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nNotice how once the Hostel is full, the other Refugees will run to the door to see if there's room, and when declined the refugees smile from the window watching as the rejects continue running for their life.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased  
    if (millis() > zombieTiming) {
      getRefugee(20, 375);
      zombieTiming = millis() + random(500, 2500);
      tutorialStage++;
    }
  } else if (tutorialStage == 32) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nNotice how once the Hostel is full, the other Refugees will run to the door to see if there's room, and when declined the refugees smile from the window watching as the rejects continue running for their life.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased  
    if (millis() > zombieTiming) {
      getRefugee(20, 375);
      zombieTiming = millis() + random(500, 2500);
      tutorialStage++;
    }
  } else if (tutorialStage == 33) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nNotice how once the Hostel is full, the other Refugees will run to the door to see if there's room, and when declined the refugees smile from the window watching as the rejects continue running for their life.", 30), width / 2 - 30, 520);
    //Advances during mouseReleased  
    if (millis() > zombieTiming) {
      //getRefugee(20, 375);
      zombieTiming = millis() + random(500, 1000);
      tutorialStage++;
    }
  } else if (tutorialStage == 34) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nWow! Look at him run! He's going to die real soon.", 30), width / 2 - 30, 520);
    if (zombies.size() == 1) {
      zombieTiming = millis() + 2000;
      tutorialStage++;
    }
  } else if (tutorialStage == 35) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nWow! Look at him run! He's going to die real soon.", 30), width / 2 - 30, 520);
    if (millis() >= zombieTiming) {
      potions.add(new Molotov(zombies.get(0).getX() + 50, zombies.get(0).getY() + 10));  //Drop a molotov at last zombie location
      potions.add(new Molotov(zombies.get(0).getX() + 100, zombies.get(0).getY() + 5));  //Drop a molotov at last zombie location
      potions.add(new Molotov(zombies.get(0).getX() + 200, zombies.get(0).getY() + 10));  //Drop a molotov at last zombie locationpotions.add(new Molotov(zombies.get(0).getX() + 50, zombies.get(0).getY() + 10));  //Drop a molotov at last zombie location
      potions.add(new Molotov(zombies.get(0).getX() + 150, zombies.get(0).getY() + 15));  //Drop a molotov at last zombie location
      potions.add(new Molotov(zombies.get(0).getX() + 250, zombies.get(0).getY() + 10));  //Drop a molotov at last zombie location
      tutorialStage++;
    }
  } else if (tutorialStage == 36) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nShit! Honestly, I slipped-swear to God.", 30), width / 2 - 30, 520);
    if (zombies.size() == 0) {
      tutorialStage++;
      temptimer = millis() + 500;
    }
  } else if (tutorialStage == 37) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nWell, natural selection I suppose. Let's end on that high note. Some other things you can figure out on your own; check your Splitter for helpful tweets, upgrade your towers to increase their effectiveness...\n[click]", 30), width / 2 - 30, 520);
    //Advanced through the
  } else if (tutorialStage == 38) {
    tint(255, 255);
    image(tutBoost, width / 2 - 170, 510);
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);                                 ///Add to zombies list
    text(formatSpeech("TBOT:\nAnd now ", 30), width / 2 - 30, 520);
    //Advanced through the 
    tutBotFrame = 0;
    tutorialStage++;
    temptimer = millis() + 500;
  } else if (tutorialStage == 39) {
    PImage[] anim = new PImage[]{tutSword1, tutSword2, tutSword3, tutSword4, tutSword5, tutSword6}; 
    if (tutBotFrame == 0 && (millis() > tutTimeAnim)) {
      tutBotFrame = 1;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 1 && (millis() > tutTimeAnim)) {
      tutBotFrame = 2;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 2 && (millis() > tutTimeAnim)) {
      tutBotFrame = 3;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 3 && (millis() > tutTimeAnim)) {
      tutBotFrame = 4;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 4 && (millis() > tutTimeAnim)) {
      tutBotFrame = 5;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 5 && (millis() > tutTimeAnim)) {
      tutBotFrame = 0;
      tutTimeAnim = millis() + 150;
    }
    tint(255, 255);
    image(anim[tutBotFrame], width / 2 - 130, 510); //tutSword,  //for sword animation position | text format max = 23
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nBefore I go I'll give you the ultimate tool if things get too hot to handle. \n[click]", 23), width / 2 + 20, 520);
    //Tutorial is advanced through activating the stats screen
    workerNum = 0;
  } else if (tutorialStage == 40) {
    PImage[] anim = new PImage[]{tutSword1, tutSword2, tutSword3, tutSword4, tutSword5, tutSword6}; 
    if (tutBotFrame == 0 && (millis() > tutTimeAnim)) {
      tutBotFrame = 1;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 1 && (millis() > tutTimeAnim)) {
      tutBotFrame = 2;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 2 && (millis() > tutTimeAnim)) {
      tutBotFrame = 3;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 3 && (millis() > tutTimeAnim)) {
      tutBotFrame = 4;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 4 && (millis() > tutTimeAnim)) {
      tutBotFrame = 5;
      tutTimeAnim = millis() + 150;
    } else if (tutBotFrame == 5 && (millis() > tutTimeAnim)) {
      tutBotFrame = 0;
      tutTimeAnim = millis() + 150;
    }
    if (workerNum <= 100) {
      workerNum++;
    } else {
      tutorialStage++;
      temptimer = millis() + 500;
    }
    tint(255, 255);
    image(anim[tutBotFrame], width / 2 - 130, 510); //tutSword,  //for sword animation position | text format max = 23
    textFont(smallFont);
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nYou'll need some cash to buy this upgrade, let me help you out here...", 23), width / 2 + 20, 520);
    //Tutorial is advanced through activating the stats screen
  } else if (tutorialStage == 41) {

    tint(255, 255);
    image(tutHacked, width / 2 - 170, 510); //tutSword,  //for sword animation position | text format max = 23
    textFont(smallFont);
    workerNum = 100;
    fill(255);
    textAlign(LEFT);
    text(formatSpeech("TBOT:\nUh oh... Th" + char((int)random(0, 60)) + "re s" + char((int)random(0, 60)) + "ems t" + char((int)random(0, 60)) + " " + char((int)random(0, 60)) + "e a l" + char((int)random(0, 60)) + "ttle c" + char((int)random(0, 60)) + "mplic" + char((int)random(0, 60)) + "ti" + char((int)random(0, 60)) + "n...\n[click to terminate TBOT]", 23), width / 2 - 30, 520);
    //Tutorial is advanced through activating the stats screen
  }
}

String formatSpeech(String t, int max) {
  String s = "";
  int j = 0;
  boolean canBreak = false;
  for (int i = 0; i < t.length(); i++) {
    if (t.substring(i, i+1).equals("\n")) {
      s += "\n"; 
      canBreak = false;
      j = 0;
    } else {
      j++;
      if (j >= max) {
        canBreak = true;
      }
      if (canBreak) {
        if (t.substring(i, i+1).equals(" ")) {
          s += "\n";
          canBreak = false;
          j = 0;
          i++;
        }
      }
      s += t.substring(i, i+1);
      if (j >= max + 3) {
        s+= "-";
        s += "\n";
        canBreak = false;
        j = 0;
      }
    }
  }
  return s;
}

void updateDeployables() {
  if (purchasingDeployable) {
    if (deployableName == "reinforce") {

      if ((mouseY >= 60) && (mouseY <= 440)) {
        tint(255, 100);
      } else {
        tint(255, 0, 0, 100);
      }
      if (mouseY < 452) {
        fill(#C3FF12, 10);
        rect(width - 80, mouseY + 18, 60, 10);
        rect(width - 70, mouseY + 18, 45, 10);
        rect(width - 60, mouseY + 18, 32, 10);
        rect(width - 55, mouseY + 18, 25, 10);
        rect(width - 50, mouseY + 18, 18, 10);
        rect(width - 48, mouseY + 18, 14, 10);
        image(k1walk1, width - 40, mouseY);
      } else {
        image(k1walk1, width - 40, 452);
      }
      tint(255, 100);
    }
  }
}

void updateButtons() {
  if (clickedTower != null) {
    for (int i = 0; i < clickedTower.towerUI.numBubbles; i++) {
      if (clickedTower.towerUI.towerButtons.get(i).hovered()) {  //If the button is hovered over
        Description d = new Description(mouseX, mouseY, clickedTower.towerUI.towerButtons.get(i).upgrade.description, clickedTower.towerUI.towerButtons.get(i).upgrade);
        d.drawDescription();
      }
    }
  }
}

void updateNextLevel() {
  wave = levelNumber + 1;
  if (tutorialStage >= TUTORIAL_MAX) {  //not in tut
    if (levelUpdated) {      //change the current level int #
      levelNumber++;      //set next level
      if (levelNumber == 1) {
        Level l2 = new Level(1, 15, 0, 5, 0);             //Create new level 2
        currentLevel = l2;                               //Set it to the current level
      }
      if (levelNumber == 2) {
        Level l3 = new Level(2, 15, 0, 5, 0);             //Create new level 3
        currentLevel = l3;                               //Set it to the current level
        arrowParameters[0] = 60;
        arrowParameters[1] = 120;
      }
      if (levelNumber == 3) {
        Level l4 = new Level(3, 35, 2, 5, 0);             //Create new level 4
        currentLevel = l4;                               //Set it to the current level
        arrowParameters[0] = 80;
        arrowParameters[1] = 140;
      }
      if (levelNumber == 4) {
        Level l5 = new Level(4, 35, 5, 5, 1);             //Create new level 5
        currentLevel = l5;                               //Set it to the current level
        arrowParameters[0] = 160;
        arrowParameters[1] = 200;
      }
      if (levelNumber == 5) {
        Level l6 = new Level(5, 60, 7, 10, 2);             //Create new level 5
        currentLevel = l6;                               //Set it to the current level
        arrowParameters[0] = 100;
        arrowParameters[1] = 290;
      }

      dayMusic.play();
      nightMusic.stop();
      musicStarted = true;
      levelUpdated = false;
    }
    fill(#00FF79, 100);          //Indicator slice (shows where zombies most frequently spawn)
    rect(0, arrowParameters[0] - 10, width, (arrowParameters[1] - arrowParameters[0]) + 30);
    if (millis() >= arrowTimer) {
      int temp = (int)random(1, 4);
      for (int i = 0; i < temp; i++) {
        arrows.add(new Indicator(random(0, width), random(arrowParameters[0], arrowParameters[1])));
      }
      arrowTimer = millis() + random(500, 1500);
    }
    fill(#13EA72, 200);
    rect(width - 150, 10, 140, 30, 15);  //Green shape

    if (glowing == true) {                   //Glowing mechanic
      if (buttonLight < 2) {
        buttonLight = 2;
      }
      if (buttonLight > 255) {
        glowing = false;
      } else {
        buttonLight *= 1.05;
      }
    } else {
      if (buttonLight < 1) {
        glowing = true;
      } else {
        buttonLight *= 0.95;
      }
    } 
    fill(255, buttonLight);
    rect(width - 150, 10, 140, 30, 15);

    fill(255);                            //Text
    textFont(medFont);
    textSize(20);
    if (towersList.size() == 0) {
      text("PLACE TOWERS", width / 2 + 30, 530);
      rect(width / 2 - 50, 550, 160, 1);
      textSize(15);
      text("THE GREEN LINE INDICATES WHERE THE\nZOMBIES WILL SPAWN INITIALLY", width / 2 + 30, 590);
    }
    textSize(20);
    text("START WAVE", width - 80, 33);
  }
}

void updateTowerUI() {    //Cedrics code
  //Update TowerUI Menu
  if (clickedTower != null) {
    if (towerUI.size() == 0 || (prevTower != null && prevTower != clickedTower)) { 
      if (clickedTower.towerUI.icon3 == null && clickedTower.towerUI.icon4 == null) {
        clickedTower.towerUI = new TowerUI(clickedTower, clickedTower.numUpgrades, clickedTower.towerUI.icon1, clickedTower.towerUI.upgrade1, clickedTower.towerUI.icon2, clickedTower.towerUI.upgrade2);
      } else if (clickedTower.towerUI.icon4 == null) {
        clickedTower.towerUI = new TowerUI(clickedTower, clickedTower.numUpgrades, clickedTower.towerUI.icon1, clickedTower.towerUI.upgrade1, clickedTower.towerUI.icon2, clickedTower.towerUI.upgrade2, clickedTower.towerUI.icon3, clickedTower.towerUI.upgrade3);
      } else {
        clickedTower.towerUI = new TowerUI(clickedTower, clickedTower.numUpgrades, clickedTower.towerUI.icon1, clickedTower.towerUI.upgrade1, clickedTower.towerUI.icon2, clickedTower.towerUI.upgrade2, clickedTower.towerUI.icon3, clickedTower.towerUI.upgrade3, clickedTower.towerUI.icon4, clickedTower.towerUI.upgrade4);
      }
      if (towerUI.size() > 0) {
        towerUI.remove(0);
        towerUI.add(clickedTower.towerUI);
      } else {
        towerUI.add(0, clickedTower.towerUI);
      }

      clickedTower.towerUI.updateTowerUI();
    }
  } else {
    if (towerUI.size() > 0 ) {
      towerUI.remove(0);
    }
  }

  for (int i = 0; i < towerUI.size(); i++) {
    towerUI.get(i).updateTowerUI();
  }

  if (clickedTower != null) {
    prevTower = clickedTower;
  }
}

void updateTowers() {  //Update every existing tower
  for (int i = 0; i < towersList.size(); i++) {
    towersList.get(i).update();
  }
}

void getZombie() {                                        //Adds a new zombie 
  Zombie z1 = new Zombie(0, random(40, height - 210));   //Creates zombie at random position on the left side of the screen
  zombies.add(z1);                                       //Add to zombies list
}

void getZombie(float x, float y) {                        //Adds a new zombie at given point
  Zombie z1 = new Zombie(x, y);                          //Creates zombie at random position on the left side of the screen
  zombies.add(z1);                                       //Add to zombies list
}

void getZombie(float x, float y, float s) {               //Adds a new zombie at given point and sets speed
  Zombie z1 = new Zombie(x, y);                          //Creates zombie at random position on the left side of the screen
  z1.setXVelo(s);
  zombies.add(z1);                                       //Add to zombies list
}

void getZombie(float x, float y, float s, float h) {      //Adds a new zombie at given point and sets speed and health
  Zombie z1 = new Zombie(x, y);                          //Creates zombie at random position on the left side of the screen
  z1.setXVelo(s);                                        //Sets speed
  z1.setHealth(h);                                       //Set health
  z1.setInitialHealth(h);                                //Set initial health
  zombies.add(z1);                                       //Add to zombies list
}

void getZombie(float x, float y, float s, float h, boolean b) {      //Adds a new zombie at given point and sets speed and health
  Zombie z1 = new Zombie(x, y, s, h, b);                          //Creates zombie at random position on the left side of the screen
  //z1.setXVelo(s);                                        //Sets speed
  //z1.setHealth(h);                                       //Set health
  //z1.setInitialHealth(h);                                //Set initial health
  //z1.setHoarder(b);                                      //Set initial hoarder status
  zombies.add(z1);                                       //Add to zombies list
}

void getScreamer() {                                          //Adds a new Screamer
  Screamer s1 = new Screamer(0, random(80, height - 250));   //Creates screamer at random position on the left side of the screen
  zombies.add(s1);                                           //Add to zombies list
}

void getGutter() {                                        //Adds a new Gutter (Boss Zombie)
  Gutter g1 = new Gutter(0, random(80, height - 250));   //Creates Gutter at random position on the left side of the screenS
  zombies.add(g1);                                       //Add to zombies list
}

void getRefugee() {                                        //Adds a new Refugee
  Refugee r1 = new Refugee(0, random(80, height - 250));  //Creates Refugee at random position on the left side of the screenS
  zombies.add(r1);                                        ///Add to zombies list
}

void getRefugee(float x, float y) {                                        //Adds a new Refugee
  Refugee r1 = new Refugee(x, y);  //Creates Refugee at random position on the left side of the screenS
  zombies.add(r1);                                        ///Add to zombies list
}

void updateZombies() {  //Update and draw every zombie
  for (int i = 0; i < zombies.size(); i++) {  //Go through every existing zombie
    if (view == 0) {
      zombies.get(i).drawZombie();            //Cycles through the walking animation of current zombie
      zombies.get(i).display();               //Draw the zombie image and health bar
    }
    for (int j = 0; j < towersList.size(); j++) {  //Update each exisitng towers
      towersList.get(j).update();
    }

    zombies.get(i).update();    //Update that zombie
    zombies.get(i).dead();      //See if that zombie is dead
  }
}

void updateDeadZombies() {      //Updates and draws every dead corpse
  for (int i = 0; i < deadZombies.size(); i++) {  //For every existing dead zombie
    if (deadZombies.get(i).getFire()) {
    }
    if (view == 0) {                      //If the view is in the game
      deadZombies.get(i).drawZombie();    //Draw the corpse
    }
    deadZombies.get(i).display();       //Display the corpse
    deadZombies.get(i).update();        //Update the corpse | not really nessecary, also scared to remove
  }
}


void keyPressed() {
  switch (keyCode) {
  case 'D':          //iF D key pressed
    gameMode = 'D';    //Enter debug mode
    break;
  case 'R':          //iF R key pressed
    gameMode = 'R';    //Enter grenade mode
    break;
  case 'G':          //If G key pressed
    gameMode = 'G';    //Enter regular game mode
    break;
  }
}
void mouseReleased() {    //If there is a mouse click (technically release, acts more efficent)
  if (gameOver == true) {
    if (mouseX >= 385 && mouseX <= 385+150 && mouseY >= 320 && mouseY <= 320+50) {
      exit();
    }
  }

  if (gameView == 0) {                                                //If in the menu
    if (get(mouseX, mouseY) == -8445920) {                                  //If mouse is on the red color of the zombie logo
      for (int i = 0; i < (int) random(5, 10); i++) {                                      //Create a random # of blood particles
        particles.add(new Particle(mouseX, mouseY, random(6, 9), new int[]{112, 0, 0}));
      }
    }
    for (int i = 0; i < buttons.size(); i++) {                  //For every existing button
      if (buttons.get(i).isClicked() && clearScreen == false) {  //See if that button was clicked and the screen is in a place where it can progress to a different view
        if (buttons.get(i).name == "play") {          //If the play button is pressed
          displayScreen = 1;                        //Switch to the playing game loadout
        } else if (buttons.get(i).name == "rules") {   //If the rules button is pressed
          displayScreen = 2;                        //Switch to the rules game loadout
        } else if (buttons.get(i).name == "back") {    //If the back button is pressed
          displayScreen = 0;                        //Switch to the back to previous screen loadout
        } else if (buttons.get(i).name == "credits") { //If the credits button is pressed
          displayScreen = 3;                        //Switch to the credits loadout
        }
        clearScreen = true;                       //Reset variable to incidate another button switch
      }
    }
  } else                                                  //If the game view is not in the menu
  if (dist(25, height/2, mouseX, mouseY) < 30) {          //If the mousebutton is clicked on left button
    if (view == 0) {
      view = 1;                                          //Scroll to the left pane (reset if the pane displayed is the first one)
    } else {
      view--;
    }
  }
  if (dist(width - 25, height/2, mouseX, mouseY) < 30) {  //If the mousebutton is clicked on right button
    if (view == 1) {
      view = 0;                                          //Scroll to the right pane (reset if the pane displayed is the last one)
    } else {
      view++;
    }
  }

  for (int i = 0; i < zombies.size(); i++) {        //Go through every zombie
    if (zombies.get(i) instanceof Refugee) {        //If it's a human
      ((Refugee)zombies.get(i)).marked();         //Mark refugees as humans (if mouse is clicked on them), towers will not attack
    }
  }
  if (nextWave == false) {                                                                                  //If in between levels
    if (mouseX >= width - 150 && mouseX <= width - 10 && mouseY >= 10 && mouseY <= 45) {    //If user clicks on the next wave button
      for (int i = 0; i < 10; i++) {
        arrows.add(new Indicator(random(0, 20), random(arrowParameters[0], arrowParameters[1])));
      }
      advanceLevel.play();
      nextWave = true;                                                                                    //Turn on next wave
    }
  }

  if (tutorialStage == 0 || (tutorialStage == 9 && millis() > temptimer)|| (tutorialStage == 41 && millis() > temptimer) || (tutorialStage == 39 && millis() > temptimer)|| (tutorialStage == 37 && millis() > temptimer) ||(tutorialStage == 24 && millis() > temptimer) || (tutorialStage == 25 && millis() > temptimer) || (tutorialStage == 23 && millis() > temptimer) || (tutorialStage == 20 && millis() > temptimer) || (tutorialStage == 15 && millis() > temptimer) || (tutorialStage == 3 && millis() > temptimer) || (tutorialStage == 13 && millis() > temptimer)) {       //Advance to the first stage in the tutorial
    tutorialStage++;                                                //Advance tutorial
    temptimer = millis() + 100;                                     //Increase wait time
  }

  phone.phoneClick();                                    //Tell the phone there was a click
  boolean clicked = false;
  for (int i = 0; i < towersList.size(); i++) {            //For every tower displayed
    if (towersList.get(i).clicked() == true) {             //If that tower is clicked
      clicked = true;
      //check and see if that tower is covered over top an active tower
      if (clickedTower != null) {                                                                    //If there is an active tower 
        if (dist(towersList.get(i).x, towersList.get(i).y, clickedTower.x, clickedTower.y) <= 30) {  //If there distance between that one and this one is < 50
          if (!clickedTower.equals(towersList.get(i))) {                                           //And this towers is not analyzing itself
            towersList.get(i).isCovered = true;                                                  //Set this tower to covered
          }
        }
      } else {
        towersList.get(i).isCovered = false;                                                       //Otherwise do not cover this tower
      }
    } else {
      towersList.get(i).isCovered = false;                                                         //Also, do not cover this tower ^^
    }
  }

  if (clicked == false) {             //Not clicking on anything important
    if (purchasingDeployable && (millis() > timeDeploy) && (mouseY >= 60) && (mouseY <= 440) && (!((mouseX >= 70) && (mouseX <= 290) && (mouseY >= phone.y) && (mouseY <= phone.y + 400)))) {      //landing a deployable, and mouse is not on the phone, and mouse y is within range
      if (tutorialStage >= 0 && tutorialStage <= TUTORIAL_MAX) {        //If in tutorial
        if ((tutorialStage == 14 || tutorialStage == 18 ) && (mouseY >= 315 && mouseY <= 365)) {        //If clicking within tutorial box
          if (deployableName == "reinforce" && tutorialStage == 14) {                                //If reinforcement was bought
            Reinforcement temp = new Reinforcement(width - 40, mouseY);
            zombies.add(temp);
            tutorialStage++;
          } else if (deployableName == "freeze") {                             //If freeze grenade was bought
            potions.add(new FreezeBottle(mouseX, mouseY));  //Drop a freeze grenade at mouse location
          } else if (deployableName == "molotov") {                             //If freeze grenade was bought
            potions.add(new Molotov(mouseX, mouseY));  //Drop a molotov at mouse location
          }
          if (phone.locked == true) {          //if you can afford it
            if (workerNum - towers.get(phone.towersCycle).getPrice() < 0) {
              phone.locked = false;
              purchasingDeployable = false;
              deployableName = "";
            } else {
              purchasingDeployable = true;    //If phone is locked indicate we still want to make another drop
              workerNum -= towers.get(phone.towersCycle).getPrice();
            }
          } else {
            purchasingDeployable = false;
            deployableName = "";
          }
        }
        if (tutorialStage == 18 || tutorialStage == 22) {        //If clicking within tutorial box
          if (tutorialStage == 18) {
            if (deployableName == "reinforce") {                                //If reinforcement was bought
              Reinforcement temp = new Reinforcement(width - 40, mouseY);
              if (phone.locked) {
                zombies.add(temp);
                familyCount++;
              }
            }
          }
          if (deployableName == "freeze") {                             //If freeze grenade was bought
            potions.add(new FreezeBottle(mouseX, mouseY));  //Drop a freeze grenade at mouse location
          } else if (deployableName == "molotov") {                             //If freeze grenade was bought
            potions.add(new Molotov(mouseX, mouseY));  //Drop a molotov at mouse location
          }

          if (phone.locked == true) {          //if you can afford it
            if (workerNum - towers.get(phone.towersCycle).getPrice() < 0) {
              phone.locked = false;
              purchasingDeployable = false;
              deployableName = "";
            } else {
              purchasingDeployable = true;    //If phone is locked indicate we still want to make another drop
              workerNum -= towers.get(phone.towersCycle).getPrice();
            }
          } else {
            purchasingDeployable = false;
            deployableName = "";
          }
        }
      } else {    //not in tutorial
        if (deployableName == "reinforce") {                                //If reinforcement was bought
          Reinforcement temp = new Reinforcement(width - 40, mouseY);
          zombies.add(temp);
        } else if (deployableName == "freeze") {                             //If freeze grenade was bought
          potions.add(new FreezeBottle(mouseX, mouseY));  //Drop a freeze grenade at mouse location
        } else if (deployableName == "molotov") {                             //If freeze grenade was bought
          potions.add(new Molotov(mouseX, mouseY));  //Drop a molotov at mouse location
        }

        if (phone.locked == true) {          //if you can afford it
          if (workerNum - towers.get(phone.towersCycle).getPrice() < 0) {
            phone.locked = false;
            purchasingDeployable = false;
            deployableName = "";
          } else {
            purchasingDeployable = true;    //If phone is locked indicate we still want to make another drop
            workerNum -= towers.get(phone.towersCycle).getPrice();
          }
        } else {
          purchasingDeployable = false;
          deployableName = "";
        }
      }
    }



    clickedTower = null;            //If there is click and it is not on a tower,  run whatever is inside here

    if (gameMode == 'D') {                          //if in debug mode, 
      if (mouseButton == RIGHT) {                     //If right-clicked
        zombies.add(new Zombie(mouseX, mouseY));    //Drop a zombie @ mouse location
      } else if (mouseButton == LEFT) {                     //If right-clicked
        zombies.add(new Refugee(mouseX, mouseY));    //Drop a zombie @ mouse location
      } else if (mouseButton == CENTER) {                     //If right-clicked
        zombies.add(new Gutter(mouseX, mouseY));    //Drop a zombie @ mouse location
      }
    }
    if (gameMode == 'R') {                         //if in items mode,
      if (mouseButton == RIGHT) {                     //If right-clicked
        potions.add(new Molotov(mouseX, mouseY));   //Drop a molotov at the mouse location
      }
      if (mouseButton == LEFT) {                     //If left-clicked
        potions.add(new FreezeBottle(mouseX, mouseY));  //Drop a freeze grenade at mouse location
      }
    }
  }

  if (clickedTower != null) {          //If there is a clicked tower, cover the ones in it's vicinity 
    for (int i = 0; i < towersList.size(); i++) {
      if (dist(towersList.get(i).x, towersList.get(i).y, clickedTower.x, clickedTower.y) <= 25) {
        if (!clickedTower.equals(towersList.get(i))) {
          towersList.get(i).isCovered = true;
        }
      }
      for (int j = 0; j < clickedTower.towerUI.towerButtons.size(); j++) {
        if (dist(towersList.get(i).x, towersList.get(i).y, clickedTower.towerUI.towerButtons.get(j).x, clickedTower.towerUI.towerButtons.get(j).y) <= clickedTower.towerUI.towerButtons.get(j).TOWER_BUTTON_SIZE/2) {
          towersList.get(i).isCovered = true;
        }
      }
    }
  }

  //For the TowerUI Class
  if (clickedTower != null) {
    if (clickedTower.towerUI != null) {
      for (int i = 0; i < clickedTower.towerUI.towerButtons.size(); i++) {
        if (clickedTower.towerUI.towerButtons.get(i).isHovered) {
          clickedTower.towerUI.towerButtons.get(i).isClicked(true);
        }
      }
    }
  }
}