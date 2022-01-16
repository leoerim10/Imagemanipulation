PImage image;

int amount;

void setup(){
  size(933,620);
  image = loadImage("test.jpg");
  image.loadPixels();
  loadPixels();
  amount = 50;
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


ArrayList<part> fountain = new ArrayList();
void createFountain(int x, int y, float speed){
  for(int i=0; i<amount; i++){
    fountain.add(new particle(x,y,1.1,10,2));
  }
}

ArrayList<part> successors;
void createSuccessor(int x, int y, float speed, float amount, int ix, int iy, float f, float chance, float direction, float strength){
  for(int i=0; i<amount; i++){
    successors.add(new successorParticle(x,y,speed,ix,iy,f,chance,direction,strength));
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
 createFountain(mouseX,mouseY,1); 
}
