import java.util.List;
import io.herrmann.generator.Generator;

class MergeSort<T extends Comparable<? super T>> implements SortingAlgorithm {
  private List<T> array;
  private int swaps;
  private int comparisons;
  private Iterator<Animation> iterator;

  MergeSort(List<T> array) {
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
        final int len = array.size();
        List<T> aux = new ArrayList<T>(array); // Have to use a List because Java doesn't allow you to make a new array of a generic type
        for (int size = 1; size < len; size *= 2) {
          for (int i = 0; i < len; i += 2 * size) {
            final int iLeft = i, iRight = min(i + size, len), iEnd = min(i + 2 * size, len);
            int a = iLeft, b = iRight;
            for (int k = iLeft; k < iEnd; k++) {
              if (a < iRight && (b >= iEnd || array.get(a).compareTo(array.get(b)) <= 0)) {
                aux.set(k, array.get(a));
                if (b >= iEnd) {
                  comparisons++;
                  yield(new Animation(a, b, "Compare"));
                }
                a++;
              } else {
                aux.set(k, array.get(b));
                if (a < iRight) {
                  comparisons++;
                  yield(new Animation(a, b, "Compare"));
                }
                b++;
              }
            }
            for (int q = iLeft; q < iEnd; q++) {
              swaps++;
              array.set(q, aux.get(q));
              yield(new Animation(q, "Swap"));
            }
          }
        }
      }
    };
  }
}
