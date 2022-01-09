ArrayList<Wave> waveList = new ArrayList<>();

int waveAmount;

PImage image;
PImage imagecopy;

void setup(){
  size(933,620);
  image = loadImage("test.jpg");
  imagecopy = createImage(image.width,image.height,RGB);
  for(int x=0; x<image.width; x++){
   for(int y=0; y<image.height; y++){
    imagecopy.pixels[x+y*width] = image.pixels[x+y*width];
   }
  }
  waveAmount = 5000;
  image.loadPixels();
  imagecopy.loadPixels();
  image(imagecopy,0,0);
}

void draw(){
  moveWaves(); moveWaves(); moveWaves();

  imagecopy.updatePixels();
  image(imagecopy,0,0);
  
}

void moveWaves(){
  for(int x=0;x<waveList.size();x++){
    waveList.get(x).moveWave();
  }
}

void mouseClicked(){
  if(isInBounds(mouseX,mouseY)){
    waveList.add(new Wave(mouseX,mouseY,waveAmount,0.5,5));
  }
}

public boolean isInBounds(int X, int Y){return X>=(0) && X<((0)+image.width) && Y>=(0) && Y<((0)+image.height); }
