class Wave{
 Particle[] particles;
 int speedOfWave;
 Wave(int x, int y, int amount, float gap, int speed){
  particles = new Particle[amount];
  speedOfWave = speed;
  for( int i = 0; i < particles.length; i++){
   particles[i] = new Particle(x,y,gap); 
  }
 }
 
 void moveWave(){
   for(int x=0; x<speedOfWave; x++){
      for(int i=0; i < particles.length; i++){
        particles[i].display();
        particles[i].move();
      } 
   }
}
}
