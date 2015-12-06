int nWaves = 30;
// Number of wave phases that are visible on screen
// (in other words, number of up peaks or down peaks)
float nPhases = 4.3;
int phaseLength;
int offsetX = -10;
int waveOffsetX = -5;
int waveWidth = 5;
int initialX = 0, initialY = 0;
int amplitude = 30;
color curvePrimaryColor = color(100, 200, 200);

void setup() {
  size(920, 426);
  phaseLength = (int)(width/nPhases);
  background(255);
  fill(curvePrimaryColor);
  noStroke();
}

void draw() {
  for(int i = 0; i <= nWaves; i++) {
    int x = initialX;
    int y = initialY - amplitude / 2;
    beginShape();
    vertex(x, y);
    // First curveVertex is just to guide the beginning of the curve
    curveVertex(x - phaseLength / 2, y + amplitude);
    curveVertex(x, y);
    for(int j = 0; j <= nPhases; j++) {
      x += phaseLength / 2;
      y += amplitude;
      curveVertex(x, y);
      x += phaseLength / 2;
      y -= amplitude;
      curveVertex(x, y);
    }
    // Last curveVertex is just to guide the end of the curve
    curveVertex(x + phaseLength / 2, y + amplitude);
    vertex(x, y);
    y += waveWidth;
    // Go back
    x += waveOffsetX;
    vertex(x, y);
    // First curveVertex is just to guide the beginning of the curve
    curveVertex(x + phaseLength / 2, y + amplitude);
    curveVertex(x, y);
    for(int j = (int)nPhases; j >= 0; j--) {
      x -= phaseLength / 2;
      y += amplitude;
      curveVertex(x, y);
      x -= phaseLength / 2;
      y -= amplitude;
      curveVertex(x, y);
    }
    // Last curveVertex is just to guide the end of the curve
    curveVertex(x - phaseLength / 2, y + amplitude);
    vertex(x, y);
    endShape();
    initialX += offsetX;
    initialY += height / nWaves; //<>//
  }
}