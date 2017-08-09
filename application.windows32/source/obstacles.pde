class Obstacle {
  PVector obs = new PVector();
  PVector vel;
  color col;
  int dia=9;
  float var = 0.05;
  float speed = 1.3;

  Obstacle() {
    if (random(2)<width/(2.0*height)) {
      obs.x = floor(random(xmargin, width-xmargin));
      obs.y = random(1)>0.5?scl/3:height-scl/3;
    } else {
      obs.y = floor(random(scl/3, height-scl/3));
      obs.x = random(1)>0.5?xmargin:width-xmargin;
    }

    vel=new PVector(pos.x-obs.x, pos.y-obs.y);
    vel.setMag((2.5+random(-var, var))*speed);
    col = color(random(50, 255), random(0, 255), random(0, 255));
  }

  void show() {
    fill(col);
    ellipse(obs.x, obs.y, dia, dia );
  }
  void update() {
    obs.x+=vel.x;
    obs.y+=vel.y;
    //obs.lerp(pos,0.005);
  }

  void renew() {
    if (random(2)<0.85) {
      obs.x = floor(random(xmargin, width-xmargin));
      obs.y = random(1)>0.5?scl/3:height-scl/3;
    } else {
      obs.y = floor(random(scl/3, height-scl/3));
      obs.x = random(1)>0.5?xmargin:width-xmargin;
    }

    vel=new PVector(pos.x-obs.x, pos.y-obs.y);
    vel.setMag((2.5+random(-var, var))*speed);
  }

  boolean offscreen() {
    if (obs.x<xmargin || obs.x>width-xmargin || obs.y<scl/3 || obs.y> height-scl/3) {
      return true;
    } else {
      return false;
    }
  }
}