Particle[] p = new Particle[10000];
int particles = 150;
float speed = 0;
void setup(){
  size(500,500);
  for (int i = 0; i< particles; i++){
    p[i] = new Particle(i,true);
  }
}

void draw(){
  background(0);
  if (Math.random()*speed > Math.sqrt(speed)){
    for (int i = 0; i < 1 + speed/25; i++){
      p[particles] = new Particle(particles, false);
      particles++;
    }
  }
  
  if (Math.random()*1000 > 995){
    p[particles] = new Ship(particles);
    particles++;
  }
  
  for (int i = 0; i < particles; i++){
    p[i].move();
    p[i].show();
  }
  if (speed < 50){
    speed+=0.05;
  }
}

class Particle{
  int myIndex;
  float x, y;
  float angle;
  float distance;
  
  Particle(){
    
  }
  
  Particle(int i,boolean random){
    distance = 0.1+(float)(Math.random()*10);
    if (random == true){
      x = (float)(Math.random()*501);
      y = (float)(Math.random()*501);
      myIndex = particles;
    }
    else{
      float a = (float)(Math.random()*PI*2);
      x = 250;
      y = 250;
      x += 25/Math.sqrt(speed)*cos(a);
      y += 25/Math.sqrt(speed)*sin(a);
    }

    myIndex = i;
  }
  
  
  void move(){
    angle = atan2(250-y,250-x);
    x -= speed*cos(angle)*(dist(x,y,250,250)/1000)/distance;
    y -= speed*sin(angle)*(dist(x,y,250,250)/1000)/distance;
    
  }
  
  void show(){
    noStroke();
    fill(255);
    pushMatrix();
    translate(x,y);
    rotate(angle);
    ellipse(0,0, (dist(x,y,250,250)/(75/(1+(speed/15)))/distance) , (dist(x,y,250,250)/(75*(1+(speed/50)))/distance) );
    popMatrix();
    if (x > 505 || x < -5 || y > 505 || y < -5){
      deleteParticle(myIndex);
    }
  }
}//particle class

class Ship extends Particle{
  Ship(int i){
    float a = (float)(Math.random()*PI*2);
    x = 250;
    y = 250;
    x += 1000*cos(a);
    y += 1000*sin(a);
    distance = 2+(float)(Math.random()*9);
    myIndex = i;
  }
  
  void move(){
    angle = atan2(250-y,250-x);
    x += 2*(75+speed)*cos(angle)*(dist(x,y,250,250)/1000)/distance;
    y += 2*(75+speed)*sin(angle)*(dist(x,y,250,250)/1000)/distance;
  }
  
  void show(){
    noStroke();
    fill(255);
    pushMatrix();
    translate(x,y);
    rotate(angle);
    ellipse(0,0, (dist(x,y,250,250)/(75/(1+(speed/15)))/distance*50) , (dist(x,y,250,250)/(75*(1+(speed/50)))/distance*100));
    popMatrix();
    if ((dist(x,y,250,250) < 5)){
      deleteParticle(myIndex);
    }
  }
}//ship class

void deleteParticle(int index){
  p[index] = null;
  
  for (int i = index; i < particles; i++){
    if (p[i + 1] != null){
      p[i] = p[i + 1];
      p[i].myIndex = i;
    }
    else
      p[i] = null;
  }
  particles -= 1;
}

