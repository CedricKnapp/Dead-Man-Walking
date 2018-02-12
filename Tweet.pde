class Tweet{
 int ping;
 String selTweet;
 String name;
 String at;
 boolean first;
 boolean deleted;
 int opacity;
 int r, g, b;
 int inc;
 String[] tweetListZombie = {
   "lit clan took down a\n zombie #takeMeIn",
   "omw to this new clan,\nthey've got a good rep i hear", // Note that the \n is due to the fact that the line is slightly long for the string. If you make additions that are around the same length as this, please add the \n
   "#wow i can't wait to move in.",
   "mom kicked me out",
   "looking for a new spot,\n any takers??",
   "somebody turn off that cellphone \n please!",
   "cash me insside how bow\n dah??",
   "quinton4sexiestman\nalive 2k16",
   "my #daddy just got\n #eaten, be right there",
   "got wisdom teeth out,\nlet's #party",
 };
 
  String[] tweetListScreamer = {
   "honestly that screamer would-\nn't shut it's goddamn mouth",
   "silence in the hood\ntime for me to move in!", // Note that the \n is due to the fact that the line is slightly long for the string. If you make additions that are around the same length as this, please add the \n
   "i scream u scream except\nfor the screamer cuz she gone",
   "me and my family are moving\nin #screamIsOverParty",
   "my band is looking for a\n#safeSpace, found one here",
   "think i found a\nsafe spot!",
 };
  
  String[] tweetListGutter = {
   "that Gutter was gutty",
   "my village is moving in!", // Note that the \n is due to the fact that the line is slightly long for the string. If you make additions that are around the same length as this, please add the \n
   "my 24 kids can't wait\nto live here!",
   "that gutter was huge\nbut not as big as my entourage",
 };
 
 String[] nameList = {
 "1501MemeSquad",
 "Quinto",
 "CeddyWap",
 "NGUYEN",
 "LifeHAX",
 "DefNotAZombie",
 "CloroxShots",
 };
 String[] atList = {
 "@R.Collier",
 "@JavaFXEndMe",
 "@LanthierStop",
 "@DiscreteMemes",
 "@W0tInTarnation",
 "@vLoudCellPhone",
 "@Processing3"
 };
 
  
  Tweet(int price){
    if(price == 1){
    selTweet = tweetListZombie[(int)random(0, tweetListZombie.length)];
    }else if(price == 5){
    selTweet = tweetListScreamer[(int)random(0, tweetListScreamer.length)];
    }else if(price == 25){
    selTweet = tweetListGutter[(int)random(0, tweetListGutter.length)];
    }
    name = nameList[(int)random(0, nameList.length)];
    at = atList[(int)random(0, atList.length )];
    
    ping = 0;
    first = false;
    deleted = false;
    opacity = 255;
    inc = 0;
    r = (int)random(0, 255);
    g = (int)random(0, 255);
    b = (int)random(0, 255);
    
  }
}

void displayTweet(){
  
  float y = phone.y;
  int inct = 0;
  
  
  
  for(int i = 0; i < tweets.size(); i++){
        String msg = tweets.get(i).selTweet;
        String msg1 = tweets.get(i).name + "   " + tweets.get(i).at;
        
        if(tweets.get(0).deleted == true){
          tweets.get(0).opacity-=10;
          inct+=10;
        }
        
        
          fill(255,255,255, tweets.get(i).opacity);
          rect(95, y+(90)+(60*i) - inct , 170, 55, 7);
          fill(tweets.get(i).r,tweets.get(i).g,tweets.get(i).b, tweets.get(i).opacity);
          rect(100, y+(92)+(60*i) - inct , 20, 20, 7);
          fill(0,0,0, tweets.get(i).opacity);
          textSize(11);
          textAlign(LEFT);
          text(msg, 100, y+(128)+(60*i) - inct );
          textSize(8);
          text(msg1, 127, y+(112)+(60*i) - inct );
        
          if(tweets.size() > 0){
            if(tweets.get(0).opacity < 0)
            tweets.remove(0);
          }
        }
        //incTwt +=10;
        
        
  


}