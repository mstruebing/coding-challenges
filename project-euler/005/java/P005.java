public class P005 {
	public static void main(String[] args) {
		int maxDivisor = 20;
		int x = maxDivisor;

		while(!isEvenlyDivisableByAll(x, maxDivisor)) {
			x = x + maxDivisor;		
		} 

		System.out.println(x);
	}

	private static Boolean isEvenlyDivisableByAll(int number, int maxDivisor) {
		Boolean result = true;
		for (int i = 1; i <= maxDivisor; i++) {
			result = result && number % i == 0;
		}

		return result;
	}
}
