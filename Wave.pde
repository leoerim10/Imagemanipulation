class Wave{
 Particle[] particles;
 Wave(int x, int y, int amount, float speed){
  particles = new Particle[amount];
  for( int i = 0; i < particles.length; i++){
   particles[i] = new Particle(x,y,speed); 
  }
 }
 
 void moveWave(){
  for(int i=0; i < particles.length; i++){
    particles[i].display();
    particles[i].move();
  } 
}

/*void fillParticles(int x, int y, int amount){
  particles = new Particle[amount];
  for( int i = 0; i < particles.length; i++){
   particles[i] = new Particle(x,y); 
  }
}*/
  
}
