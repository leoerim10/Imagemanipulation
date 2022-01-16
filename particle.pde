public class particle implements part{
 int ix, iy;
 float iSpeed;
 float speed;
 float x, y;
 float xn, yn;
 int f;
 float limit;
 float chance;
 float direction;
 float strength;
 particle(int x, int y, float speed, float successorChance, float strength){
       // successorChance is a value between <1> and <10> where it increases with increasing amplitude
   this.x=x;
   this.y=y;
   ix = x;
   iy = y;
   iSpeed = speed;
   this.chance = successorChance;
   this.strength = strength;
   f = int(random(1,10));
   limit = random(25);
   direction = random(TWO_PI);
   xn = cos(direction)*speed;
   yn = sin(direction)*speed;
   setColor();
 }
 
 color c;
 
 void setColor(){
   color d = image.pixels[int(x)+int(y)*width];
   c = d;
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
    if(dist(ix,iy,x,y)>random(5*strength,10*strength/2)){
      removeFountain(this);
      if(f<=chance){ createSuccessor(int(x),int(y),iSpeed/1.05,10, ix, iy, limit, chance/1.2, direction,strength); }
    }
  }
 }
 
 boolean checkBounds(){
   return y<=0 || y>=height || x<=0 || x>=width;
 }
}
