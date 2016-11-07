public class P006 {
	public static void main(String[] args) {
		System.out.println(squareOfSum(100) - sumOfSquares(100));
	}

	private static int sumOfSquares(int x) {
		int result = 0;

		for (int i = 1; i <= x; i++) {
			result += i * i;
		}

		return result;
	}

	private static int squareOfSum(int x) {
		int result = 0;

		for (int i = 1; i <= x; i++) {
			result += i;
		}

		return result * result;
	}
}
