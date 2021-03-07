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

void setup() {
  size(600, 500);
  //fullScreen();
  background(51); 
  frameRate(30);
  //frameRate(60);
  reset();
}

void reset() {
  array = randomlyFillList();

  //sorter = new BubbleSort<Integer>(array);
  sorter = new SelectionSort<Integer>(array);
  animation = null;
  noStroke();
}

void draw() {
  background(51);

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

  fill(255);
  int tSize = 14;
  int tMargin = 2;
  textSize(tSize);
  textAlign(LEFT, TOP);
  String[] gui = {
    "Comparisons: " + sorter.getComparisons(), 
    "Swaps: " + sorter.getSwaps(), 
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
  if (key == 'r') reset();
}
