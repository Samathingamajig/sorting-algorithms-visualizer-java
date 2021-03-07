import java.util.List;
import java.util.Iterator;

List<Integer> array;
SortingAlgorithm sorter;
Animation animation;

final int size = 30;
final int minNum = 20;
final int maxNum = 400;

final int animationsPerFrame = 1;
final boolean showAnimations = true;

String[] algorithms = {
  "Bubble", 
  "Selection", 
  "Insertion", 
};
int currentAlgorithm = 0;
boolean paused = true;
boolean everStarted = false;
boolean playSinceLastToggle = true;

void setup() {
  size(600, 500);
  //fullScreen();
  background(51); 
  frameRate(30);
  //frameRate(60);
  reset();
  initSorter();
}

void reset() {
  array = randomlyFillList();
  paused = true;

  animation = null;
  noStroke();
}

void initSorter() {
  switch (algorithms[currentAlgorithm]) {
  case "Bubble": 
    sorter = new BubbleSort<Integer>(array); 
    break;
  case "Selection": 
    sorter = new SelectionSort<Integer>(array); 
    break;
  case "Insertion": 
    sorter = new InsertionSort<Integer>(array); 
    break;
  default: 
    println("Invalid sorting type: " + algorithms[currentAlgorithm] + "; currentAlgorithm == " + currentAlgorithm);
    println("You might have forgotten to include this sort in the algorithms switch statement :)");
    exit();
  }
}

void draw() {
  background(51);

  if (!paused) {
    if (sorter.hasNext()) {
      if (showAnimations)
        animation = sorter.next();
      for (int i = showAnimations ? 1 : 0; i < animationsPerFrame && sorter.hasNext(); i++)
        if (showAnimations) animation = sorter.next();
        else sorter.next();
      array = sorter.getArray();
    } else {
      animation = null;
    }
  }

  fill(255);
  int tSize = 14;
  int tMargin = 2;
  textSize(tSize);
  textAlign(LEFT, TOP);
  String[] gui = {
    "Algorithm: " + algorithms[currentAlgorithm] + " Sort", 
    "Comparisons: " + sorter.getComparisons(), 
    "Swaps: " + sorter.getSwaps(), 
    "Paused: " + (paused ? "True" : "False"), 
    "FPS: " + frameRate, 
  };
  for (int i = 0; i < gui.length; i++)
    text(gui[i], 0, (tSize + tMargin) * i);

  float boxWidth = (width * 0.7 / size);
  float startingX = (width * 0.15);

  for (int i = 0; i < size; i++) {
    fill(255);
    if (animation != null && (i == animation.getIndex1() || i == animation.getIndex2())) {
      switch (animation.getType()) {
      case "Compare":
        fill(#0000FF);
        break;
      case "Swap":
        fill(#00FF00);
        break;
      default:
        println("Unknown animation type: " + animation.getType());
      }
    }
    rect(startingX + boxWidth*i, height - array.get(i).intValue(), boxWidth, array.get(i).intValue());
  }
}

List<Integer> randomlyFillList() {
  List<Integer> arr = new ArrayList<Integer>(size);
  for (int i = 0; i < size; i++) {
    arr.add(floor(random(maxNum - minNum + 1)) + minNum);
  }
  return arr;
}

void keyPressed() {
  if (key == 'r') {
    reset();
  } else if (key == 'p') {
    everStarted = true;
    if (!playSinceLastToggle) initSorter();
    paused = !paused;
    playSinceLastToggle = true;
  } else if (key == 't') {
    currentAlgorithm = ++currentAlgorithm % algorithms.length; 
    if (everStarted && playSinceLastToggle) reset();
    playSinceLastToggle = false;
  }
}
