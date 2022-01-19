public class particle implements part{
 int ix, iy;
 float speed;
 float x, y;
 float xn, yn;
 float limit;
 float successorChance;
 float direction;
 float strength;
 float ampness;
 color c;
 float colorShift, saturation, brightness;
 
 particle(int x, int y, float speed, float successorChance, float strength, float colorShift, float saturation, float brightness, float ampness){
   this.x=x;
   this.y=y;
   ix = x;
   iy = y;
   this.speed = speed;
   this.successorChance = successorChance;
   this.strength = strength;
   this.ampness=ampness;
   limit = random(strength);
   direction = random(TWO_PI);
   xn = cos(direction)*speed;
   yn = sin(direction)*speed;
   this.colorShift = colorShift;
   this.saturation = saturation;
   this.brightness = brightness;
 }
 void setColor(){
   color d = image.pixels[int(x)+int(y)*image.width];
   c = color(hue(d)/ampness+colorShift,saturation(d)+saturation,brightness(d)+brightness);
 }
 

 void show(){
   setColor();
   pixels[int(x)+int(y)*width] = c;
 }
 
 void move(){
  x = x + xn;
  y = y + yn;
  
  if(!checkBounds()){
      if(random(1)<=successorChance) createSuccessor(int(x),int(y),speed,10*strength,limit,(successorChance/(100/amount)),strength,-this.colorShift,this.saturation,this.brightness,this.ampness); 
      removeFountain(this);
    }

 }
 
 boolean checkBounds(){
   return y<=0 || y>=image.height || x<=0 || x>=image.width;
 }
}
