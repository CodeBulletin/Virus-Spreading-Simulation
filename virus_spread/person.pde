class person {
  PVector pos, gotopos;
  float radius;
  boolean infected, isinfected;
  person(PVector pos, float r, boolean infected) {
    this.pos = pos;
    this.radius = r;
    this.infected = infected;
    this.isinfected = false;
  }
  void show() {
    imageMode(CENTER);
    if (isinfected) {
      image(P3, pos.x, pos.y);
    } else if (infected) {
      image(P2, pos.x, pos.y);
    } else {
      image(P1, pos.x, pos.y);
    }
  }
  void move() {
    if (gotopos!=null) {
      PVector dir = gotopos.copy().sub(pos).copy();
      dir.mult(speed/dir.mag());
      pos.add(dir);
      if (gotopos.copy().sub(pos).copy().mag() < speed) {
        pos.x = gotopos.x;
        pos.y = gotopos.y;
        gotopos = null;
      }
    }
  }
};
