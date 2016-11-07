import java.util.ArrayList;

public class P004 {
	public static void main(String[] args) {
		int maxFactor = 999;
		int minFactor = 100;
		int newPalindromeNumber = 0;
		int biggestPalindromeNumber = 0;

		for (int i = maxFactor; i >= minFactor; i--) {
			for (int j = maxFactor; j >= minFactor; j--) {
				newPalindromeNumber = i * j;
				if (isPalindromeNumber(newPalindromeNumber) &&
					newPalindromeNumber > biggestPalindromeNumber) {
					biggestPalindromeNumber = newPalindromeNumber;	
				}
			}
		}

		System.out.println(biggestPalindromeNumber);
	}

	private static Boolean isPalindromeNumber(Integer x) {
		String number = Integer.toString(x);
		String reverseNumber = new StringBuilder(number).reverse().toString();

		return number.equals(reverseNumber);		
	}
	
}
