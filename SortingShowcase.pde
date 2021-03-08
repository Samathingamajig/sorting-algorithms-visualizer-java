import java.util.List;
import java.util.Iterator;

import java.util.Arrays;

List<Integer> array;
List<Integer> lastArray;
SortingAlgorithm sorter;
Animation animation;

final int size = 30;
final int minNum = 20;
final int maxNum = 400;

final int animationsPerFrame = 1;
boolean showAnimations = true;

boolean showDebugMenu = false;

String[] algorithms = {
  "Bubble", 
  "Selection", 
  "Insertion", 
};
int currentAlgorithm = 0;
boolean paused = true;
boolean everStarted = false;
boolean hasUnpausedSinceLastChange = true;

void setup() {
  size(600, 500);
  //fullScreen();
  background(51); 
  frameRate(30);
  //frameRate(60);
  lastArray = randomlyFillList();
  reset();
  initSorter();
  noStroke();
}

void reset() {
  array = lastArray;
  paused = true;

  animation = null;
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
  List<String> gui = new ArrayList<String>(Arrays.asList(
    "Algorithm: " + algorithms[currentAlgorithm] + " Sort", 
    "Comparisons: " + (hasUnpausedSinceLastChange ? sorter.getComparisons() : 0), 
    "Swaps: " + (hasUnpausedSinceLastChange ? sorter.getSwaps() : 0), 
    "Paused: " + (paused ? "True" : "False")
    ));
  if (showDebugMenu) {
    gui.add("Show Animations: " + (showAnimations ? "True" : "False"));
  }
  gui.add("FPS: " + frameRate);
  for (int i = 0; i < gui.size(); i++)
    text(gui.get(i), 0, (tSize + tMargin) * i);

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

// Function key keycodes
final int F3 = 114;

void keyPressed() {
  if (key == 'r') {
    array = lastArray;
    hasUnpausedSinceLastChange = false;
    reset();
  } else if (key == 'p') {
    everStarted = true;
    if (!hasUnpausedSinceLastChange) initSorter();
    paused = !paused;
    hasUnpausedSinceLastChange = true;
  } else if (key == 't') {
    currentAlgorithm = ++currentAlgorithm % algorithms.length; 
    if (everStarted && hasUnpausedSinceLastChange) reset();
    hasUnpausedSinceLastChange = false;
  } else if (key == 'n') {
    lastArray = randomlyFillList();
    paused = true;
    hasUnpausedSinceLastChange = false;
    reset();
  } else if (key == 'c') {
    showAnimations = !showAnimations;
    animation = null;
  } else if (keyCode == F3) {
    showDebugMenu = !showDebugMenu;
  }
}
