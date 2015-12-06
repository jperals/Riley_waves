int waveWidth = 20;
int waveSeparation = 20;
int amplitude = 25;
// Number of wave phases that are visible on screen
// (in other words, number of peaks or number of troughs)
float nPhases = 4.3;
float initialX;
float initialY;
color[] colors;
color initialColor = color(50, 63, 150);

// Number of waves will be calculated according to window height, waveWidth and waveSeparation
int nWaves;
// Phase length will be calculated according to window width and number of phases
int phaseLength;

float inclinationOffset = 0.5*PI;

void setup() {
  size(600, 600);
  phaseLength = (int)(width/nPhases);
  nWaves = height/(waveWidth + waveSeparation) + 1;
  colors = new color[nWaves + 1];
  colors[0] = initialColor;
  for(int i = 1; i <= nWaves; i++) {
    color lastColor = colors[i - 1];
    color waveColor = color(red(lastColor) + random(-10, 40), green(lastColor) + random(-10, 30), blue(lastColor) + random(-10, 20));
    colors[i] = waveColor;
  }
  noStroke();
}

void draw() {
  initialX = 0;
  initialY = -amplitude/2;
  background(255);
  for(int i = 0; i <= nWaves; i++) {
    float inclination = PI*sin(0.2*i + inclinationOffset);
    float waveOffsetX = waveWidth * cos(inclination);
    float offsetX = waveOffsetX + waveSeparation * cos(inclination);
    float x = initialX;
    float y = initialY;
    beginShape();
    fill(colors[i]);
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
    // Last curveVertex is just to guide the end of the curve //<>//
    curveVertex(x - phaseLength / 2, y + amplitude);
    vertex(x, y);
    endShape();
    initialX += offsetX;
    while(initialX + offsetX > 0) {
      initialX -= phaseLength;
    }
    initialY += waveWidth + waveSeparation;
  }
  inclinationOffset = (inclinationOffset + 0.005) % (2*PI);
  // Modify colors a bit
  float dr = random(-1, 1);
  float dg = random(-1, 1);
  float db = random(-1, 1);
  for(int i = 0; i < nWaves + 1; i++) {
    color waveColor = colors[i];
    float r = red(waveColor);
    float g = green(waveColor);
    float b = blue(waveColor);
    r += dr;
    g += dg;
    b += db;
    r = constrain(r, 0, 255);
    g = constrain(g, 0, 255);
    b = constrain(b, 0, 255);
    r = constrain(r, g - 50, g + 50);
    g = constrain(r, b - 50, b + 50);
    colors[i] = color(round(r), round(g), round(b));
  }
}