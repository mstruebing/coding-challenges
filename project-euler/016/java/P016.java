import java.math.BigInteger;

public class P016 {
	public static void main(String[] args) {
		BigInteger number = BigInteger.valueOf(2).pow(1000);
		String numberAsString = String.valueOf(number);
		Integer result = 0;

		for (int i = 0; i < numberAsString.length(); i++) {
			result += Character.getNumericValue(numberAsString.charAt(i));
		}

		System.out.println(result);
	}
}
