public class P001 {

  /**
   * Main method
   */
  public static void main(String[] args) {

    System.out.println(calculateSum(3, 5, 1000));

  }

  private static int calculateSum(int multiplier1, int multiplier2, int maxNum) {
    int sum = 0;

    for (int i = 1; i < maxNum; i++) {
      if (i % multiplier1 == 0 || i % multiplier2 == 0) {
        sum += i;
      }
    }

    return sum;
  }

}
