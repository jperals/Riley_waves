int waveWidth = 15;
int waveSeparation = 15;
int amplitude = 20;
// Number of wave phases that are visible on screen
// (in other words, number of peaks or number of troughs)
float nPhases = 4.3;
int initialX = 0;
int initialY = -amplitude/2;
color curvePrimaryColor = color(100, 150, 200);

// Number of waves will be calculated according to window height, waveWidth and waveSeparation
int nWaves;
// Phase length will be calculated according to window width and number of phases
int phaseLength;

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
    float inclination = -2*PI*atan(0.4*(i - nWaves/2));
    int waveOffsetX = (int)(waveWidth * sin(inclination));
    int offsetX = waveOffsetX + (int)(waveSeparation * sin(inclination));
    int x = initialX;
    int y = initialY;
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