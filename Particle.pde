class Particle{
  float x, y, vx, vy;
  boolean cont = true;
  
  Particle(int x, int y, float gap){
    this.x=x;
    this.y=y;
    float a = random(TWO_PI);
    vx = cos(a)*gap;
    vy = sin(a)*gap;
  }
  
  void display(){
    try{
    color d = image.get(int(x),int(y));
    float r = red(d);
    float g = green(d);
    float b = blue(d);
    color a = color(r*1.5,g*1.1,b*1.1);
    imagecopy.set(int(x),int(y),a);
    }catch(ArrayIndexOutOfBoundsException e){} 
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
