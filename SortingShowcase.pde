import java.util.List;
import java.util.Iterator;

import java.util.Arrays;

import java.util.Set;
import java.util.HashSet;

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
boolean showHelpMenu = false;

String[] algorithms = {
  "Bubble", 
  "Selection", 
  "Insertion", 
  "Merge", 
};
int currentAlgorithm = 0;
boolean paused = true;
boolean everStarted = false;
boolean hasUnpausedSinceLastChange = true;

String[] helpMenu = {
  "h: " + "show this help menu", 
  "p: " + "toggle pause/play", 
  "t: " + "toggle sorting algorithm", 
  "c: " + "toggle showing colors", 
  "r: " + "reset array to before being sorted", 
  "n: " + "use a new random array", 
};

Set<Integer> currentlyPressedKeys;

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

  currentlyPressedKeys = new HashSet<Integer>();
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
  case "Merge":
    sorter = new MergeSort<Integer>(array);
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
    text(gui.get(i), tMargin, tMargin + (tSize + tMargin) * i);

  if (showHelpMenu) {
    textAlign(RIGHT, TOP);
    for (int i = 0; i < helpMenu.length; i++) {
      text(helpMenu[i], width - tMargin, tMargin + (tSize + tMargin) * i);
    }
  }

  float boxWidth = (width * 0.7 / size);
  float startingX = (width * 0.15);

  for (int i = 0; i < size; i++) {
    fill(255);
    if (animation != null) {
      if (i == animation.getIndex1() || i == animation.getIndex2()) {
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
      if (i == animation.getHeldIndex()) {
        // This could override color, but that's intended
        fill(#FFA500);
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

// Keycodes
final int KEY_H = 72;
final int KEY_T = 84;
final int KEY_P = 80;
final int KEY_C = 67;
final int KEY_R = 82;
final int KEY_N = 78;
final int KEY_F3 = 114;

void keyPressed() {
  if (!currentlyPressedKeys.contains(keyCode)) {
    // Keys which can't be held down
    switch (keyCode) {
    case KEY_R:
      array = lastArray;
      hasUnpausedSinceLastChange = false;
      reset();
      break;
    case KEY_P:
      everStarted = true;
      if (!hasUnpausedSinceLastChange) initSorter();
      paused = !paused;
      hasUnpausedSinceLastChange = true;
      break;
    case KEY_T:
      currentAlgorithm = ++currentAlgorithm % algorithms.length; 
      if (everStarted && hasUnpausedSinceLastChange) reset();
      hasUnpausedSinceLastChange = false;
      break;
    case KEY_C:
      showAnimations = !showAnimations;
      animation = null;
      break;
    case KEY_F3:
      showDebugMenu = !showDebugMenu;
      break;
    case KEY_H:
      showHelpMenu = true;
      break;
    }
  }
  // Keys which can be held down
  // (if this was inside an `else`, there would be a delay for the first press)
  switch (keyCode) {
  case KEY_N:
    lastArray = randomlyFillList();
    paused = true;
    hasUnpausedSinceLastChange = false;
    reset();
    break;
  }
  currentlyPressedKeys.add(keyCode);
}

void keyReleased() {
  switch (keyCode) {
  case KEY_H:
    showHelpMenu = false;
    break;
  }
  currentlyPressedKeys.remove(new Integer(keyCode));
}
