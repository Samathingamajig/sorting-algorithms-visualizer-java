import java.util.List;
import io.herrmann.generator.Generator;

class SelectionSort<T extends Comparable<? super T>> implements SortingAlgorithm {
  private List<T> array;
  private int swaps;
  private int comparisons;
  private Iterator<Animation> iterator;

  SelectionSort(List<T> array) {
    this.array = new ArrayList<T>(array);
    this.iterator = this.sort().iterator();
  }

  public Animation next() { 
    return iterator.next();
  }
  public boolean hasNext() { 
    return iterator.hasNext();
  }

  public List<T> getArray() { 
    return array;
  }
  public int getComparisons() { 
    return comparisons;
  }
  public int getSwaps() { 
    return swaps;
  };

  private Generator<Animation> sort() {
    return new Generator<Animation>() {
      public void run() throws InterruptedException {
        for (int i = 0; i < array.size()-1; i++) {
          int jMin = i;
          for (int j = i+1; j < array.size(); j++) {
            comparisons++;
            yield(new Animation(j, jMin, "Compare"));
            if (array.get(j).compareTo(array.get(jMin)) < 0) {
              jMin = j;
            }
          }

          if (jMin != i) {
            T temp = array.get(i);
            array.set(i, array.get(jMin));
            array.set(jMin, temp);
            swaps++;
            yield(new Animation(i, jMin, "Swap"));
          }
        }
      }
    };
  }
}
