person[][] p;
float radius = 20;
int xs, ys, totalInfected; 
float ip = 0.2;
float speed = 1000.0;
int pplmoved = 10;
ArrayList<Integer> infectedperday = new ArrayList<Integer>();
boolean travel = false;
PImage P1, P2, P3;
void setup() {
  fullScreen(P2D);
  xs = width/int(radius*2);
  ys = height/int(radius*2);
  p = new person[width/int(radius*2)][height/int(radius*2)];
  for (int i = 0; i < xs; i++) {
    for (int j = 0; j < ys; j++) {
      p[i][j] = new person(new PVector(2*i*radius + radius, 2*j*radius + radius), radius, false);
    }
  }
  int xif = floor(random(xs));
  int yif = floor(random(ys));
  p[xif][yif].infected = true;
  P1 = loadImage("asset/smile.png");
  P1.resize(int(2*radius), int(2*radius));
  P2 = loadImage("asset/worried.png");
  P2.resize(int(2*radius), int(2*radius));
  P3 = loadImage("asset/sick.png");
  P3.resize(int(2*radius), int(2*radius));
}

void draw() {
  background(0);
  if (!travel) {
    totalInfected = 0;
    for (person[] P : p) {
      for (person Pr : P) {
        //Pr.show();
        if (Pr.isinfected) {
          totalInfected++;
        }
        if (Pr.infected) {
          Pr.isinfected = true;
        }
      }
    }
    infectedperday.add(totalInfected);
    infect();
    if (totalInfected != xs*ys) {
      ArrayList<PVector> history = new ArrayList<PVector>();
      for (int i = 0; i < pplmoved; i++) {
        int xif1 = floor(random(xs));
        int yif1 = floor(random(ys));
        int xif2 = floor(random(xs));
        int yif2 = floor(random(ys));
        while (!isvalid(xif1, yif1, xif2, yif2, history)) {
          xif1 = floor(random(xs));
          yif1 = floor(random(ys));
          xif2 = floor(random(xs));
          yif2 = floor(random(ys));
        }
        person temp = p[xif1][yif1];
        p[xif1][yif1] = p[xif2][yif2];
        p[xif2][yif2] = temp;
        PVector tempos = new PVector(temp.pos.x, temp.pos.y);
        p[xif2][yif2].gotopos = new PVector(p[xif1][yif1].pos.x, p[xif1][yif1].pos.y);
        p[xif1][yif1].gotopos = tempos;
        travel = true;
      }
    }
    if (totalInfected == xs*ys) {
      println(infectedperday);
      noLoop();
    }
  } else if (travel) {
    for (person[] P : p) {
      for (person Pr : P) {
        if (Pr.gotopos == null) {
          Pr.show();
        }
        Pr.move();
      }
    }
    travel = false;
    for (person[] P : p) {
      for (person Pr : P) {
        if (Pr.gotopos != null) {
          Pr.show();
          travel = true;
        }
      }
    }
  }
}

boolean isvalid(int a1, int b1, int a2, int b2, ArrayList<PVector> history) {
  PVector temp1 = new PVector(a1, b1);
  PVector temp2 = new PVector(a2, b2);
  for (PVector v : history) {
    if ((v.x == temp1.x && v.y == temp1.y)) {
      return false;
    }
    if ((v.x == temp2.x && v.y == temp2.y)) {
      return false;
    }
    if ((temp1.x == temp2.x && temp1.y == temp2.y)){
      return false;
    }
    if (!((temp1.x >= 0 && temp1.x < xs) && (temp1.y >= 0 && temp1.y < ys))){
      return false;
    }
    if (!((temp2.x >= 0 && temp2.x < xs) && (temp2.y >= 0 && temp2.y < ys))){
      return false;
    }
  }
  history.add(temp1);
  history.add(temp2);
  return true;
}

void infect() {
  for (int i = 0; i < xs; i++) {
    for (int j = 0; j < ys; j++) {
      if (p[i][j].isinfected) {
        if (i-1 >=0 && i+1 < xs) {
          if (j-1 >=0 && j+1 < ys) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!(r == 0 && j == 0)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          } else if (j-1 >= 0) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || s == 1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          } else if (j+1 < ys) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || s == -1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          }
        } else if (i-1 >=0) {
          if (j-1 >=0 && j+1 < ys) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || r == 1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          } else if (j-1 >= 0) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || s == 1 || r == 1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          } else if (j+1 < ys) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || s == -1 || r == 1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          }
        } else if (i+1 < xs) {
          if (j-1 >=0 && j+1 < ys) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || r == -1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          } else if (j-1 >= 0) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || s == 1 || r == -1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          } else if (j+1 < ys) {
            for (int r = -1; r <= 1; r++) {
              for (int s = -1; s <= 1; s++) {
                if (!((r == 0 && j == 0) || s == -1 || r == -1)) {
                  p[i+r][j+s].infected = random(1) < ip? true: p[i+r][j+s].isinfected;
                }
              }
            }
          }
        }
      }
    }
  }
}
