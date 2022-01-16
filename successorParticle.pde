public class successorParticle implements part{
 int ix, iy;
 float iSpeed;
 float x, y;
 float xn, yn;
 int f;
 int amount;
 float limit;
 float chance;
 float direction;
 float strength;
 successorParticle(int x, int y, float speed, int ix, int iy, float successorLimit, float successorChance, float direction, float strength){
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
   f = int(random(1,6));
   this.direction = direction+random(radians(60))-random(radians(60));
   xn = cos(this.direction)*iSpeed;
   yn = sin(this.direction)*iSpeed;
   
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
    if(dist(ix,iy,x,y)>random(10*strength,50*strength/2)){
      removeFountain(this);
      if(f<=chance){ createSuccessor(int(x),int(y),iSpeed/1.05,random(1,limit)/this.amount, ix, iy, limit, chance/1.2, direction, strength); }
    }
  }
 }
 
 boolean checkBounds(){
   return y<=0 || y>=height || x<=0 || x>=width;
 } 
} 
