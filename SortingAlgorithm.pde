import java.util.List;

interface SortingAlgorithm<T> {
  public Animation next();
  public boolean hasNext();
  public List<T> getArray();
  public int getSwaps();
  public int getComparisons();
}
