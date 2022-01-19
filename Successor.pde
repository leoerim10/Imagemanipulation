public class successorParticle implements part{
 int ix, iy;
 float iSpeed;
 float x, y;
 float xn, yn;
 int number;
 float limit;
 float chance;
 float direction, directionMod;
 float strength;
 float ampness;
 color c;
 float colorShift, saturation, brightness;
 successorParticle(int x, int y, float speed, float successorLimit, float successorChance, float strength, float colorShift, float saturation, float brightness, float ampness){
   this.x=x;
   this.y=y;
   this.ix = x;
   this.iy = y;
   this.strength = strength;
   this.ampness = ampness;
   this.limit = random(successorLimit);
   iSpeed = speed;
   this.chance = successorChance;
   direction = random(radians(360));
   xn = cos(this.direction)*iSpeed;
   yn = sin(this.direction)*iSpeed;
   this.colorShift = colorShift;
   this.saturation = saturation;
   this.brightness = brightness;
 }
 void setColor(){
   color d = image.pixels[int(x)+int(y)*image.width];
   c = color((hue(d)/ampness)+colorShift,saturation(d)+saturation,brightness(d)+brightness);
 }
 
 void show(){
  setColor();
  //try{
  pixels[int(x)+int(y)*width] = c;
  //}catch(ArrayIndexOutOfBoundsException e){}
 }
 
 void move(){
  this.x = this.x + xn;
  this.y = this.y + yn;
  if(checkBounds()){
    removeFountain(this);
  }
  else{
    if(dist(x,y,this.x,this.y)>dist(x,y,this.ix,this.iy)){
      removeFountain(this);
      if(random(1)<=chance){ createSuccessor(int(x),int(y),iSpeed,random(1,limit)/3, limit, chance/(100/amount), strength, -this.colorShift,this.saturation,this.brightness,this.ampness); }
    }
  }
 }
 
 boolean checkBounds(){
   return y<=0 || y>=image.height || x<=0 || x>=image.width;
 } 
} 
