ArrayList<Point> points;

void setup() {
  size(1200, 900, P3D);
  points = new ArrayList<Point>();
  
  background(0);
  drawCenterLine();
  
}

void draw() {}

void mouseClicked() {
  if (mouseX > width/2) {
    points.add(new Point(mouseX, mouseY));
    drawLine();
  }
}

void drawLine() {
  int numberOfPoints = points.size();
  stroke(255, 0, 0);
  if (numberOfPoints > 1) {
    line(points.get(numberOfPoints - 2).x, points.get(numberOfPoints - 2).y,
         points.get(numberOfPoints - 1).x, points.get(numberOfPoints - 1).y);
  }
}

void drawCenterLine() {
  stroke(255, 0, 0);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  noStroke();
  strokeWeight(1);
}
