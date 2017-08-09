PVector pos=new PVector();
int scl=33;
int xmargin;
float score=0;
PImage img, speed;

Obstacle[] obstacles;

void setup() {
  //size(350, 660);
 fullScreen();//size(1350/33*scl,20*scl);

  xmargin =width/10;
  //resize()
  pos.x = width/2;
  pos.y =  height/2;

  img = loadImage("xtraining.PNG");
  img.resize(width-2*xmargin, 486*height/660);
  speed = loadImage("speed.PNG");
  speed.resize(speed.width*width/1350, 0);

  obstacles = new Obstacle[ceil(50*width*height/(1350*660))];
  for (int i = 0; i<obstacles.length; i++) {
    obstacles[i] = new Obstacle();
  }
}



int pause=2;//2: predraw, 1: mid-game pause, 0: not paused, 4: game over

void draw() {

  if (pause==0) {
    background(0);
    pos.x=int(limit( pos.x, xmargin, width - xmargin));
    pos.y=int(limit( pos.y, scl/3, height - scl/3));

    fill(255, 0, 0);
    rectMode(CENTER);
    rect( pos.x, pos.y, scl/2, scl/2);


    //stroke(255);
    //line(xmargin, 0, xmargin, height );
    //line(width-xmargin, 0, width-xmargin, height );
    //line(0, scl/3, width, scl/3 );
    //line(0, height-scl/3, width, height-scl/3 );
    //noStroke();


    for (Obstacle obst : obstacles) {
      obst.update();
      obst.show();
      gameOver(obst);
    }

    for (int i = obstacles.length-1; i>=0; i--) {
      if (obstacles[i].offscreen()) {
        obstacles[i].renew();
      }
    }
    score+=0.1;
  } else if (pause == 2 ) {
    predraw();
    boolean bool = mouseX>984*width/1366 && mouseX<1111*width/1366 && mouseY>690*height/768 && mouseY<749*height/768;
    if (bool) {
      fill(0, 100);
      rectMode(CORNER);
      rect(984*width/1366, 690*height/768, 127*width/1366, 59*height/768);
      //quad(984*width/1366, 690*height/768, 984*width/1366, 749*height/768, 1111*width/1366, 749*height/768, 1111*width/1366, 690*height/768);
    }
  } else if (pause==4) {
    fill(200); 
    textSize(38*width/1350);
    rectMode(CORNER);
    text("Replay", 984*width/1366, 690*height/768, 127*width/1366, 59*height/768);

    boolean boole = mouseX>984*width/1366 && mouseX<1111*width/1366 && mouseY>690*height/768 && mouseY<740*height/768;

    if (boole) {
      fill(0, 50);
      rect(984*width/1366, 690*height/768, 127*width/1366, 50*height/768);
    }
  }
}


void predraw() {
  background(0);
  int animationspeed = 60;
  image(img, xmargin, height-486*height/660);
  image(speed, map(frameCount % animationspeed, 0, animationspeed, 245*width/1366, 480*width/1366 ), map(frameCount%animationspeed, 0, animationspeed, 265*height/768, 340*height/768 ));
  //stroke(255);
  //strokeWeight(10);
  textSize(70*width/1350);
  fill(100+155*abs(sin(PI*frameCount/100)), 100);
  text("X-TRAINING I", 430*width/1350, 4*scl*height/660+2*scl*sin(PI*frameCount/100));
  fill(255);  
  textSize(50*width/1350);
  text("X-TRAINING I", 500*width/1350, 4*scl*height/660);
}

void gameOver(Obstacle obst) {
  if (abs(obst.obs.x-pos.x)<obst.dia/2 + scl/(3*2) && abs(obst.obs.y-pos.y)< obst.dia/2+scl/(3*2)) {
    textSize(100*width/1350); 
    text("GAME OVER", 215*width/1350, 350*height/660 );
    fill(random(255), random(255), random(255));
    textSize(50*width/1350); 
    text("SCORE:" + round(score), 225*width/1350, 400*height/660);

    pause=4; 
    score=0;
    redraw();
  }
}

float limit(float x, int lower, int upper) {
  if (x<lower)return lower;
  if (x>upper)return upper;
  return x;
}

void keyPressed(KeyEvent k) {
  //k.isAltDown();
  if (key == CODED) {
    if (keyCode == UP) {
      pos.y-=scl/5;
    } else if (keyCode == DOWN) {
      pos.y+=scl/5;
    } else if (keyCode == RIGHT) {
      pos.x+=scl/5;
    } else if (keyCode == LEFT) {
      pos.x-=scl/5;
    }
  } else if (key == 'p' || key == 'P') {
    if (pause==1)pause=0;
    else if (pause==0)pause=1;
  } else if (keyCode==ENTER) {
    if (pause==4)setup(); 
    pause=0;
  }
}

void mousePressed() {
  boolean bool = mouseX>984*width/1366 && mouseX<1111*width/1366 && mouseY>690*height/768 && mouseY<749*height/768;
  boolean boole = mouseX>984*width/1366 && mouseX<1111*width/1366 && mouseY>690*height/768 && mouseY<740*height/768;
  if (bool && pause == 2) {
    pause=0;
  } else if (boole && pause == 4) {
    pause=0; 
    setup();
  }
  print(mouseX, mouseY);
}