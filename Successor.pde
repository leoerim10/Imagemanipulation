public class successorParticle implements part{
 int ix, iy;
 float iSpeed;
 float x, y;
 float xn, yn;
 int amount;
 float limit;
 float chance;
 float direction, directionMod;
 float strength;
 successorParticle(int x, int y, float speed, int ix, int iy, float successorLimit, float successorChance, float direction, float directionMod, float strength, float colorShift, float saturation, float brightness){
   this.x=x;
   this.y=y;
   this.ix = x;
   this.iy = y;
   this.strength = strength;
   this.limit = random(successorLimit);
   iSpeed = speed;
   this.chance = successorChance;
   if(dist(ix,iy,x,y)<50){this.amount=4;}
   else if(dist(ix,iy,x,y)<100){this.amount=3;}
   else if(dist(ix,iy,x,y)<160){this.amount=2;}
   else if(dist(ix,iy,x,y)<220){this.amount=1;}
   this.direction = direction+random(radians(50-directionMod))-random(radians(50-directionMod));
   this.directionMod = directionMod+2;
   xn = cos(this.direction)*iSpeed;
   yn = sin(this.direction)*iSpeed;
   
   this.colorShift = colorShift;
   this.saturation = saturation;
   this.brightness = brightness;
   
   setColor();
 }
 
 float colorShift, saturation, brightness;
 color c;
 
 void setColor(){
   color d = image.pixels[int(x)+int(y)*width];
   color d2 = pixels[int(x)+int(y)*width];
   
   float h = random(hue(d-1),hue(d+1));
   float s = saturation(d)*saturation;
   float b = brightness(d)*brightness;
   
   colorShift = h;

   
   c = color(h,s,b);
 }
 
 void show(){
  pixels[int(x)+int(y)*width] = c;
 }
 
 void move(){
  x = x + xn;
  y = y + yn;
  
  if(checkBounds()){
    removeFountain(this);
  }
  else{
    if(dist(ix,iy,x,y)>random(10*strength*2,50*strength*2)){
      removeFountain(this);
      if(random(1)<=chance){ createSuccessor(int(x),int(y),iSpeed/1.05,random(1,limit)/this.amount, ix, iy, limit, chance/1.1, direction, directionMod, strength, colorShift,saturation,brightness); }
    }
  }
 }
 
 boolean checkBounds(){
   return y<=0 || y>=height || x<=0 || x>=width;
 } 
} 
