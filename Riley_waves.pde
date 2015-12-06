int nWaves;
// Number of wave phases that are visible on screen
// (in other words, number of up peaks or down peaks)
float nPhases = 4.3;
int phaseLength;
int amplitude = 20;
float inclination = -1;
int waveWidth = 20;
int waveSeparation = 20;
int initialX = 0, initialY = 0;
color curvePrimaryColor = color(100, 200, 200);

void setup() {
  size(600, 600);
  phaseLength = (int)(width/nPhases);
  nWaves = height/(waveWidth + waveSeparation) + 1;
  background(255);
  fill(curvePrimaryColor);
  noStroke();
}

void draw() {
  for(int i = 0; i <= nWaves; i++) {
    inclination = -PI*atan(0.2*(i - nWaves/2));
    int waveOffsetX = (int)(waveWidth * sin(inclination));
    int offsetX = waveOffsetX + (int)(waveSeparation * sin(inclination));
    int x = initialX;
    int y = initialY - amplitude;
    beginShape();
    vertex(x, y);
    // First curveVertex is just to guide the beginning of the curve
    curveVertex(x - phaseLength / 2, y + amplitude);
    curveVertex(x, y);
    while(x <= width + phaseLength + waveOffsetX) {
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
    while(x > 0) {
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
    while(initialX + offsetX > 0) {
      initialX -= phaseLength;
    }
    initialY += waveWidth + waveSeparation; //<>//
  }
}