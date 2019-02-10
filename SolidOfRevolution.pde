ArrayList<Point> points;
Point lastPoint, currentPoint;
PShape object;
boolean drawMode;

void setup() {
  size(1200, 900, P3D);
  reset();
}

void draw() {
  if (!drawMode) {
    pushMatrix();
    background(0);
    textSize(25);
    text("Move the mouse to move the object", 40, 100);
    text("Press R to redraw", 40, 150);
    translate(mouseX, mouseY);
    shape(object);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 'S' || key == 's')
    solidOfRevolution();
  if (key == 'R' || key == 'r')
    reset();
  if (key == 'L' || key == 'l')
    if (object != null)
      drawMode = false;
}

void mouseClicked() {
  if (mouseX > width/2) {
    currentPoint = new Point(mouseX, mouseY, 0);
    drawLine();
    points.add(new Point(currentPoint.x - width / 2, currentPoint.y - height / 2, 0));
  }
}

void solidOfRevolution() {
  int numberOfPoints = points.size();
  
  if (numberOfPoints >= 2) {
    int numberOfRotations = 45;
    int angle = 360 / numberOfRotations;
    float radians = angle * 3.141592 / 180;
    
    object = createShape();
    object.beginShape(TRIANGLE_STRIP);
    
    object.fill(color(255));
    object.stroke(77, 196, 247);
    object.strokeWeight(2);
    
    Point currentLevelPoint, nextLevelPoint;
    
    for (int i = 0; i < numberOfPoints - 1; i++) {
      
      currentLevelPoint = points.get(i);
      nextLevelPoint = points.get(i + 1);
      
      object.vertex(currentLevelPoint.x, currentLevelPoint.y, currentLevelPoint.z);
      object.vertex(nextLevelPoint.x, nextLevelPoint.y, nextLevelPoint.z);
      
      for (int j = angle; j <= 360; j += angle) {
        currentLevelPoint = points.get(i);
        currentLevelPoint = new Point(getNewX(currentLevelPoint, radians),
                                      currentLevelPoint.y,
                                      getNewZ(currentLevelPoint, radians));
        object.vertex(currentLevelPoint.x, currentLevelPoint.y, currentLevelPoint.z);
  
        nextLevelPoint = points.get(i + 1);
        nextLevelPoint = new Point(getNewX(nextLevelPoint, radians),
                                   nextLevelPoint.y,
                                   getNewZ(nextLevelPoint, radians));
        object.vertex(nextLevelPoint.x, nextLevelPoint.y, nextLevelPoint.z);
        
        radians = (angle + j) * 3.141592 / 180;
      }    
    }
    object.endShape();   
    drawMode = false;
  }
}

int getNewX(Point point, float radians) {
  return (int) (point.x * cos(radians) - point.z * sin(radians));
}

int getNewZ(Point point, float radians) {
  return (int) (point.x * sin(radians) + point.z * cos(radians));
}

void drawLine() {
  if (lastPoint == null)
    lastPoint = currentPoint;  
  else {
    stroke(77, 196, 247);
    line(lastPoint.x, lastPoint.y, currentPoint.x, currentPoint.y);
    lastPoint = currentPoint;    
  }
}

void reset() {
  points = new ArrayList();
  lastPoint = null;
  currentPoint = null;
  drawMode = true;
  background(0);
  drawCenterLine();
  showUserInformation();
}

void showUserInformation() {
  textSize(25);
  translate(0,0);
  text("Draw a profile on the right side of\nthe screen by clicking with the mouse.", 40, (height / 2) - 100);
  text("Press S when you're finished.", 40, (height / 2));
  text("Press R to reset.", 40, (height / 2) + 50);
  text("Press L to see the last figure you created.", 40, (height / 2) + 100);
}

void drawCenterLine() {
  stroke(77, 196, 247);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  noStroke();
}
