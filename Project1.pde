PImage image;

float amount;

void setup(){
  size(933,620);
  image = loadImage("test.jpg");
  image.loadPixels();
  loadPixels();
  amount = 50;
  colorMode(HSB);
}

void draw(){
  queue = new ArrayList();
  successors = new ArrayList();
  for(part particle : fountain){
    particle.show();
    particle.move();
  }
  updatePixels();
  workQueue();
  workSuccessors();
}


ArrayList<part> fountain = new ArrayList();                                                  // color should shift based on the change of frequency from the last fame,
void createFountain(int x, int y, float speed, float successorChance, float strength,                float colorShift, float saturation, float brightness){
  for(int i=0; i<amount; i++){
    fountain.add(new particle(x,y,speed,successorChance,strength,            colorShift,saturation,brightness));
  }
}

ArrayList<part> successors;
void createSuccessor(int x, int y, float speed, float amount, int ix, int iy, float f, float chance, float direction, float directionMod, float strength, float colorShift, float saturation, float brightness ){
  for(int i=0; i<amount; i++){
    successors.add(new successorParticle(x,y,speed,ix,iy,f,chance,direction, directionMod, strength, colorShift,saturation,brightness));
  }
}
void workSuccessors(){
 for(part particle : successors){
   fountain.add(particle); 
  }
}

ArrayList<part> queue;
void removeFountain(part particle){
  queue.add(particle);
}
void workQueue(){
  for(part particle : queue){
   fountain.remove(particle); 
  }
}

void mousePressed(){
 createFountain(mouseX,mouseY,random(0.5,5),random(0.2,2),random(0.5,2), random(0.5,20),random(0.7,1.5),random(0.8,1.5)); 
 amount = random(50,150);
}
