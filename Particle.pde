class Particle{
  float initialX, initialY;
  float x, y, vx, vy;
  boolean cont = true;
  
  Particle(int x, int y, float speedMod){
    this.x=x; initialX=x;
    this.y=y; initialY=y;
    float a = random(TWO_PI);
    vx = cos(a)*speedMod;
    vy = sin(a)*speedMod;
  }
  
  void display(){
    noStroke();
   
   /* //<>//
    try{
    float r = red(image.pixels[int(x+y*image.width)]);
    float g = green(image.pixels[int(x+y*image.width)]);
    float b = blue(image.pixels[int(x+y*image.width)]);
    //color c = color(r*1.5,g*1.1,b*1.1);
    color c = color(255,0,0);
    imagecopy.pixels[int(x+y*image.width)] = c;
    }catch(ArrayIndexOutOfBoundsException e){}
    */
    color d = color(0,0,0);
    try{  
      color a = image.get(int(x),int(y));
      float r = red(a);
      float g = green(a);
      float b = blue(a);
      if(r>g){
        if(r>b) d = color(r*1.1,g,b);
        else d = color(r,g,b*1.1);
      } //<>//
      else if(b>g) d = color(r,g,b*1.1);
      else d = color(r,g*1.1,b);
    }catch(ArrayIndexOutOfBoundsException e){}
    
    
    //color c = image.get(int(x),int(y));
    //color d = color(255,0,0);
    fill(d);
    
    ellipse(x,y,1,1);
  }
  
  void move(){
    
    if(cont){
      x = x+vx;
      y = y+vy;
      if(y<0+1 || y>height-1 || x<0+1 || x>width){
        cont = !cont;
      } 
    }
    
  }
  
}
