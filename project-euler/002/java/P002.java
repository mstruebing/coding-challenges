import java.util.ArrayList;

public class P002 {
	public static void main(String[] args ) {
		Integer maxNumber = 4000000;
		System.out.println(sumFibs(getEvenFibs(fibonacciGenerator(maxNumber))));

	}

	private static ArrayList fibonacciGenerator(Integer maxNumber) {
		ArrayList<Integer> fibs = new ArrayList<Integer>();

		fibs.add(0);
		fibs.add(1);

		for(Integer i = 2; fibs.get(fibs.size() - 1) + fibs.get(fibs.size() - 2) < maxNumber; i++) {
			fibs.add(fibs.get(fibs.size() - 1) + fibs.get(fibs.size() - 2));
		}

		return fibs;
	}

	private static Integer sumFibs(ArrayList<Integer> fibs) {
		Integer sum = 0;

		for (Integer i : fibs) {
			sum += i;
		}

		return sum;
	}

	private static ArrayList getEvenFibs(ArrayList<Integer> fibs) {
		ArrayList<Integer> evenFibs = new ArrayList<Integer>();
		for (Integer fib : fibs) {
			if (fib % 2 ==0) {
				evenFibs.add(fib);
			}
		}

		return evenFibs;
	}
}
