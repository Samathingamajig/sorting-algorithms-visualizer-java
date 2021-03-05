import java.util.List;
import io.herrmann.generator.Generator;

class BubbleSort<T extends Comparable<? super T>> implements Algorithm {
  private List<T> array;
  private int swaps;
  private int comparisons;
  private Iterator<Animation> iterator;

  BubbleSort(List<T> array) {
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
        int lastIndex = array.size();
        while (lastIndex > 1) {
          int lastChangedIndex = 0;
          for (int i = 1; i < lastIndex; i++) {
            comparisons++;
            yield(new Animation(i-1, i, "Compare"));
            if (array.get(i-1).compareTo(array.get(i)) > 0) {
              T temp = array.get(i);
              array.set(i, array.get(i-1));
              array.set(i-1, temp);
              swaps++;
              lastChangedIndex = i;
              yield(new Animation(i-1, i, "Swap"));
            }
          }
          lastIndex = lastChangedIndex;
        }
      }
    };
  }
}
