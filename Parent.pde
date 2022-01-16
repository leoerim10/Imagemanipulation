public class particle implements part{
 int ix, iy;
 float speed;
 float x, y;
 float xn, yn;
 float limit;
 float successorChance;
 float direction;
 float strength;
 
 particle(int x, int y, float speed, float successorChance, float strength, float colorShift, float saturation, float brightness){
   this.x=x;
   this.y=y;
   ix = x;
   iy = y;
   this.speed = speed;
   this.successorChance = successorChance;
   this.strength = strength;
   limit = random(25);
   direction = random(TWO_PI);
   xn = cos(direction)*speed;
   yn = sin(direction)*speed;
   setColor();
   
   this.colorShift = colorShift;
   this.saturation = saturation;
   this.brightness = brightness;
 }
 
 color c;
 
 float colorShift, saturation, brightness;
 
 void setColor(){
   color d = image.pixels[int(x)+int(y)*width];

   float h = hue(d) * colorShift;
   colorShift = h;
   float s = saturation(d) * saturation;
   float b = brightness(d) * brightness;
   
   c = color(h,s,b);
 }
 

 void show(){
  pixels[int(x)+int(y)*width] = c;
 }
 
 void move(){
  x = x + xn;
  y = y + yn;
  
  if(!checkBounds()){
      if(random(1)<=successorChance){ createSuccessor(int(x),int(y),(speed/1.05),10*strength, ix, iy, limit, successorChance/1.1, direction, 2, strength, colorShift, saturation, brightness); }
    }
  removeFountain(this);
 }
 
 boolean checkBounds(){
   return y<=0 || y>=height || x<=0 || x>=width;
 }
}
