import java.util.List;
import io.herrmann.generator.Generator;

class InsertionSort<T extends Comparable<? super T>> implements SortingAlgorithm {
  private List<T> array;
  private int swaps;
  private int comparisons;
  private Iterator<Animation> iterator;

  InsertionSort(List<T> array) {
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
  }

  private Generator<Animation> sort() {
    return new Generator<Animation>() {
      public void run() throws InterruptedException {
        //i ← 1
        //while i < length(A)
        //    x ← A[i]
        //    j ← i - 1
        //    while j >= 0 and A[j] > x
        //        A[j+1] ← A[j]
        //        j ← j - 1
        //    end while
        //    A[j+1] ← x[3]
        //    i ← i + 1
        //end while
        for (int i = 1; i < array.size(); i++) {
          T temp = array.get(i);
          for (int j = i-1; j >= 0; j--) {
            comparisons++;
            yield(new Animation(j, j+1, "Compare"));
            if (array.get(j).compareTo(temp) <= 0) break;
            array.set(j+1, array.get(j));
            array.set(j, temp);
            swaps++;
            yield(new Animation(j, j+1, "Swap"));
          }
        }
      }
    };
  }
}
