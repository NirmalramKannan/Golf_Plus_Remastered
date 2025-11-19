int ballx = 625;
int bally = 375;
int level = 1;
int score = 5000;
float incrx;
float incry;
float ax;
float ay;
float timer = 5;
float holex = random(50,1200);
float holey = random(50,100);
boolean motion = false;
boolean game = false;
PImage image1; PImage image2;PImage image3; PImage image5; PImage image6;
void setup(){
  size(1250,750);
  incrx = 0;
  incry = 0;
  ballx = 625;
  bally = 375;
  motion = false;
  holex = random(50,1200);
  holey = random(150,700);
  image1 = loadImage("game.png");image2 = loadImage("level.png");image3 = loadImage("score.png"); image5 = loadImage("title.png"); image6 = loadImage("play.png");
}
void draw(){
  background(#898989);
  image(image1, 0,0);
  fill(0);
  textSize(12);
  text("x: "+ballx+" y: "+bally, 0, 10); 
  text("incrx: "+incrx, 0, 30);
  text("incry: "+incry, 0, 50);
  ellipse(holex, holey, 60,60);
  fill(#FFFFFF);
  if(motion == false){
    line(ballx,bally, ballx+(ballx-mouseX), bally+(bally-mouseY));
  }
  ellipse(ballx,bally,50,50);
  if(incrx == 0 && incry == 0){
    motion = false; 
  }
  image(image2, 25,25);
  image(image3, 1070,25);
  textSize(50);
  text(level, 90,95);
  text(score, 1100,95);
  if(level != 18 && game == true && score>0){
    score--; 
  }
  if(level == 18 && timer > 0){
    motion = true;
    timer -= 0.016;
    text("Returning to menu in ... "+timer, 275, 100);
    if(timer <= 0){
      game = false;
      timer = 5;
      score = 5000;
      level = 0;
    }
  }
  if(game == false){
    image(image5, 0, 0);
    if(mouseX >= 535 && mouseX <= 735 && mouseY >= 612 && mouseY <= 712){
      rect(525, 602, 220, 120);
    }
    image(image6,535,612);
  }
//---------------------------------------------------------------------------- Ball Physics
  if (motion == true){
    ballx += incrx;
    bally += incry;
    if(incrx < 0){
      incrx += ax;
    }
    else{
      incrx -= ax;  
    }
    if(incry < 0){
      incry += ay;
    }
    else{
      incry -= ay;  
    }
    if(incrx >= -0.2 && incrx <= 0.2){
      incrx = 0;
    }
    if(incry >= -0.2 && incry <= 0.2){
      incry = 0;
    }
    if( (abs(ballx - holex)) <= 25  && (abs(bally - holey)) <= 25 ){
      setup();
      level+=1;
    } 
  }
//---------------------------------------------------------------------------- Wall collision
  if((ballx+25) >= 1250 || (ballx-25) <=0){
    incrx = -incrx;
    if((ballx+25) >= 1250){
      ballx -= 1;
    }
    if((ballx-25) <= 0 ){
      ballx += 1;
    }
  }
  
  if((bally+25) >= 750 || (bally-25) <= 0){
    incry = -incry;
    if((bally+25) >= 750){
      bally -= 1;
    }
    if((bally-25) <= 0 ){
      bally += 1;
    }
  }
}
//----------------------------------------------------------------------------
void mouseClicked(){
  if (motion == false && game == true){
    incrx = ((ballx+(ballx-mouseX)) - ballx)*0.1;
    incry = ((bally+(bally-mouseY)) - bally)*0.1;
    ax = abs(incrx/300);
    ay = abs(incry/300);
    motion = true;
  }
  if(game == false && mouseX >= 535 && mouseX <= 735 && mouseY >= 612 && mouseY <= 712){
     game = true; 
  }
}
