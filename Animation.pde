class Animation {
  private int index1;
  private int index2;
  private int heldIndex;
  private String type;

  Animation(int index, String type) {
    this.index1 = index;
    this.type = type;

    this.index2 = -1;
    this.heldIndex = -1;
  }

  Animation(int index1, int index2, String type) {
    this.index1 = index1;
    this.index2 = index2;
    this.type = type;

    this.heldIndex = -1;
  }

  Animation(int index1, int index2, String type, int heldIndex) {
    this.index1 = index1;
    this.index2 = index2;
    this.type = type;
    this.heldIndex = heldIndex;
  }

  public int getIndex1() {
    return index1;
  }

  public int getIndex2() {
    return index2;
  }

  public int getHeldIndex() {
    return heldIndex;
  }

  public String getType() {
    return type;
  }
}
