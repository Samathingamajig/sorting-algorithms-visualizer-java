int c = 0;

void setup() {
  size(600, 600);
  background(c);
}

void draw() {
  c++;
  c = c % 256;
  background(c);
}