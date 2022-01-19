import processing.sound.*;
import controlP5.*;
PImage image;

String[] images = new String[9];
String[] soundfiles = new String[21];

ControlP5 slider1;
ControlP5 slider2;
ControlP5 slider3;
ControlP5 slider4;
ControlP5 slider5;
ControlP5 slider6;
ControlP5 slider7;
ControlP5 slider8;
ControlP5 button;
ControlP5 button2;
ControlP5 button3;
ControlP5 button4;

float amount;
int capacity;
int x,y;

void setup(){
  size(1250,800);
  initRest();
  imagePath = images[0];
  soundPath = soundfiles[0];
  initPicture();
  initAudio();
  init();
}


int bands = 128;
float[] values;
float[] spectrum = new float[bands];
SoundFile file;
FFT fft;
Amplitude amp;
BeatDetector beat;
float strength;
float ampness;
float sizeAmp;

float speedMod, colorMod, saturationMod, brightnessMod, particleMod;

int beats;
int method;

void draw(){
  if(!stopped){
    thread("checkExtend");
    if(file.isPlaying()) { 
      thread("analyzeFFT"); thread("analyzeAmp"); 
      if(beat.isBeat()) beats++;
    }
    if(frameCount % capacity == 0) {  
      for(int x = 0; x<values.length; x++){
       strength = strength + values[x];
      }
      if(beats>8) method = 1;
      strength = strength / values.length;
      createFountain(x,y,random(ampness+(sizeAmp*1-1),3+ampness)*speedMod,random(1,1+ampness)*5,strength*particleMod+beats, 0+colorMod,random(0+saturationMod,0.2+saturationMod),random(0+brightnessMod,0.2+brightnessMod), 1+method*random(-beats,beats));
      values = new float[bands];
      strength = 0;
      ampness = 0;
      beats = 0;
      method = 0;
    }
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
} //<>//

void analyzeFFT(){
  fft.analyze(spectrum);
  for( int i = 0; i < bands; i++ ){
    values[i] += spectrum[i];
  }
}
void analyzeAmp(){
  ampness += amp.analyze();
  ampness = ampness / 2;
}

void checkExtend(){
 if(fountain.size()>80000){
   println("Mandatory Reset");
   fountain = new ArrayList();
   queue = new ArrayList();
   successors = new ArrayList();
 }
}


ArrayList<part> fountain = new ArrayList(); 
void createFountain(int x, int y, float speed, float successorChance, float strength, float colorShift, float saturation, float brightness, float ampness){
  for(int i=0; i<amount; i++){
    fountain.add(new particle(x,y,speed,successorChance,strength,colorShift,saturation,brightness,ampness));
  }
}
ArrayList<part> successors;
void createSuccessor(int x, int y, float speed, float amount, float f, float chance, float strength, float colorShift, float saturation, float brightness, float ampness ){
  for(int i=0; i<amount; i++){
    successors.add(new successorParticle(x,y,speed,f,chance,strength, colorShift,saturation,brightness,ampness));
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


boolean stopped;
void keyPressed(){
 stopped = !stopped;
 if(file.isPlaying()) file.pause();
 else{
  file.play(); 
 }
}

void mousePressed(){
  if(!checkBounds()){ //<>//
    x = mouseX; 
    y = mouseY;
  }
}

int Nimage = 1;
void getNextImage(){
  imagePath = images[Nimage];
  Nimage++;
  if(Nimage==images.length) Nimage = 0;
  initPicture();
}

int Nsample = 1;
void getNextSample(){
  file.stop();
  file.removeFromCache();
  soundPath = soundfiles[Nsample];
  Nsample++;
  if(Nsample==soundfiles.length) Nsample = 0;
  initAudio();
}

boolean checkBounds(){
   return mouseY<=0 || mouseY>=image.height || mouseX<=0 || mouseX>=image.width;
 }
 String soundPath;
void initAudio(){
  values = new float[bands];
  file = new SoundFile(this,soundPath);
  fft = new FFT(this,bands);
  fft.input(file);
  amp = new Amplitude(this);
  amp.input(file);
  
  beat = new BeatDetector(this);
  beat.input(file);
  
  if(!stopped){
    file.play();
  }
  file.loop();
  colorMode(RGB);
  slider3 = new ControlP5(this);
  slider3.addSlider("Amplitude").setPosition(950,140).setSize(150,50).setRange(0.2,1).setValue(1).setColorForeground(color(219, 30, 232)).setColorValue(color(36, 225, 23)).setColorActive(color(219, 30, 232)).setColorLabel(color(219, 30, 232)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      file.amp(slider3.getController("Amplitude").getValue());
    }
  });
  slider4 = new ControlP5(this);
  slider4.addSlider("Playrate").setPosition(950,200).setSize(150,50).setRange(0.5,2).setValue(1).setColorForeground(color(6, 225, 198)).setColorValue(color(249, 30, 57)).setColorActive(color(214, 199, 30)).setColorLabel(color(6, 225, 198)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      file.rate(slider4.getController("Playrate").getValue());
    }
  });
 
  beats = 0;
  
  colorMode(HSB,360,1,1);
}

String imagePath;
void initPicture(){
  background(30);
  image = loadImage(imagePath);
  image.resize(900,800);
  image.loadPixels();
  loadPixels();
  colorMode(RGB,256,256,256);
  slider1 = new ControlP5(this);
  slider1.addSlider("Particle Multiplier").setPosition(950,20).setSize(150,50).setRange(0.2,3).setValue(1).setColorForeground(color(160,0,0)).setColorValue(color(95,255,255)).setColorActive(color(160,0,0)).setColorLabel(color(160,0,0)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      particleMod = slider1.getController("Particle Multiplier").getValue();
      amount = 142*particleMod;
    }
  });
  slider2 = new ControlP5(this);
  slider2.addSlider("Frequency").setPosition(950,80).setSize(150,50).setRange(10,190).setValue(50).setColorForeground(color(25, 197, 49)).setColorValue(color(230, 58, 206)).setColorActive(color(172, 175, 194)).setColorLabel(color(25, 197, 49)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      capacity = int(slider2.getController("Frequency").getValue());
    }
  });
  button = new ControlP5(this);
  button.addButton("Destroy Particles").setPosition(980,260).setSize(100,25).setColorBackground(color(255, 0, 0)).setColorForeground(color(120, 2, 2)).onPress(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      fountain = new ArrayList();
      queue = new ArrayList();
      successors = new ArrayList();
      try{
      for(int x=0; x<pixels.length; x++){
        pixels[x] = 30;
      }
      }catch(ArrayIndexOutOfBoundsException e){}
      background(30);
    }
  });
  slider5 = new ControlP5(this);
  slider5.addSlider("Speed Multiplier").setPosition(950,350).setSize(150,50).setRange(0.1,5).setValue(1).setColorForeground(color(0, 2, 255)).setColorValue(color(255, 235, 0)).setColorActive(color(0, 2, 255)).setColorLabel(color(0, 2, 255)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      speedMod = slider5.getController("Speed Multiplier").getValue();
    }
  });
  slider6 = new ControlP5(this);
  slider6.addSlider("Color Modification").setPosition(950,410).setSize(150,50).setRange(-200,200).setValue(0).setColorForeground(color(128, 0, 255)).setColorValue(color(127, 255, 0)).setColorActive(color(128, 0, 255)).setColorLabel(color(128, 0, 255)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      colorMod = 0;
      colorMod = slider6.getController("Color Modification").getValue();
    }
  });
  slider7 = new ControlP5(this);
  slider7.addSlider("Saturation Modification").setPosition(950,470).setSize(150,50).setRange(-1,1).setValue(0).setColorForeground(color(32, 34, 189)).setColorValue(color(223, 221, 66)).setColorActive(color(32, 34, 189)).setColorLabel(color(32, 34, 189)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      saturationMod = slider7.getController("Saturation Modification").getValue();
    }
  });
  slider8 = new ControlP5(this);
  slider8.addSlider("Brightness Modification").setPosition(950,530).setSize(150,50).setRange(-1,1).setValue(0).setColorForeground(color(248, 249, 255)).setColorValue(color(7, 6, 0)).setColorActive(color(248, 249, 255)).setColorLabel(color(248, 249, 255)).onDrag(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      brightnessMod = slider8.getController("Brightness Modification").getValue();
    }
  });
  button2 = new ControlP5(this);
  button2.addButton("Randomize Hue").setPosition(980,590).setSize(100,25).setColorBackground(color(0, 255, 195)).setColorForeground(color(2, 66, 51)).setColorLabel(color(0)).onPress(new CallbackListener(){
    public void controlEvent(CallbackEvent theEvent){
      colorMod = random(-200,200);
      slider6.getController("Color Modification").setValue(0);
    }
  });
  x = image.width/2;
  y = image.height/2;

  
  sizeAmp = 1;
  
  if(image.width*image.height>1000000) sizeAmp=3.5;
  else if(image.width*image.height>700000) sizeAmp=3;
  else if(image.width*image.height>500000) sizeAmp=2.5;
  
  x = image.width/2;
  y = image.height/2;
  strength = 0;
  ampness = 0;
  amount = 100;
  capacity = 30;
  method = 0;

  speedMod=1; colorMod=0; saturationMod=0; brightnessMod=0; particleMod=1;
  
  colorMode(HSB,360,1,1);
}

void init(){
  colorMode(RGB);
  button3 = new ControlP5(this);
  button3.addButton("Next image").setPosition(980,700).setSize(100,25).setColorBackground(color(0, 255, 195)).setColorForeground(color(2, 66, 51)).setColorLabel(color(0)).onPress(new CallbackListener(){
   public void controlEvent(CallbackEvent theEvent){
    getNextImage(); 
   }
  });
  button4 = new ControlP5(this);
  button4.addButton("Next Sound").setPosition(980,750).setSize(100,25).setColorBackground(color(0, 255, 195)).setColorForeground(color(2, 66, 51)).setColorLabel(color(0)).onPress(new CallbackListener(){
   public void controlEvent(CallbackEvent theEvent){
    getNextSample(); 
   }
  });
  colorMode(HSB,360,1,1);
}
void initRest(){
  images[0] = "test.jpg";
  images[1] = "test2.png";
  images[2] = "test4.png";
  soundfiles[0] = "test_track19.mp3";
  soundfiles[1] = "test_track12.mp3";
  soundfiles[2] = "test_track20.mp3";
}
