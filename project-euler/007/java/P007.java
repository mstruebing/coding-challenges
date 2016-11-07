public class P007 {
	public static void main(String[] args) {
		int n = 10001;
		System.out.println(getNthPrime(n));
	}

	private static int getNthPrime(int n) {
		int numberOfPrimes = 0;
		int nthPrime = 0;
		int i = 2;

		do {
			if (isPrime(i)) {
				numberOfPrimes++;
				nthPrime = i;
			}
			i += 1;
		} while (numberOfPrimes != n);

		return nthPrime;

	}

	private static boolean isPrime(int n) {
		if (n % 2 ==0 && n != 2) {
			return false;
		}

		for (int i = 3; i < n; i+=2) {
			if (n % i == 0) {
				return false;
			}
		}

		return true;
	}

	
}
