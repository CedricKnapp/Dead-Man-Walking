//Holds tower preview for build app
class BuildIcon{
  PImage icon;        //Holds the tower icon
  String description; //Holds tower desc.
  int price;          //Holds cost of workers
  
  BuildIcon(PImage i, String d, int p){
    icon = i;
    description = d;
    price = p;
  }
  
  PImage getIcon() { return icon; }
  String getInfo() { return description; }
  int getPrice() { return price; }
}