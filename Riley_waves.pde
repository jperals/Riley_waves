int waveWidth = 20;
int waveSeparation = 20;
int amplitude = 25;
// Number of wave phases that are visible on screen
// (in other words, number of peaks or number of troughs)
float nPhases = 4.3;
int initialX;
int initialY;
color curvePrimaryColor = color(100, 150, 200);

// Number of waves will be calculated according to window height, waveWidth and waveSeparation
int nWaves;
// Phase length will be calculated according to window width and number of phases
int phaseLength;

float inclinationOffset = 0;

void setup() {
  size(600, 600);
  phaseLength = (int)(width/nPhases);
  nWaves = height/(waveWidth + waveSeparation) + 1;
  fill(curvePrimaryColor);
  noStroke();
}

void draw() {
  initialX = 0;
  initialY = -amplitude/2;
  background(255);
  for(int i = -nWaves/2; i <= nWaves; i++) {
    float inclination = PI*sin(0.05*i + inclinationOffset);
    int waveOffsetX = (int)(waveWidth * cos(inclination));
    int offsetX = waveOffsetX + (int)(waveSeparation * cos(inclination));
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
  inclinationOffset = (inclinationOffset + 0.005) % (2*PI);
}