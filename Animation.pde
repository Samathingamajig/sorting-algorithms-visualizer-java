class Animation {
  private int index1;
  private int index2;
  private String type;

  Animation(int index, String type) {
    this.index1 = index;
    this.type = type;

    this.index2 = -1;
  }

  Animation(int index1, int index2, String type) {
    this.index1 = index1;
    this.index2 = index2;
    this.type = type;
  }

  public int getIndex1() {
    return index1;
  }

  public int getIndex2() {
    return index2;
  }

  public String getType() {
    return type;
  }
}
