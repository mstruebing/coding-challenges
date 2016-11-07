public class P008 {
	public static void main(String[] args) {
		int k2 = 0;
		for (int h = 1; h <= 500; h++) {
			for (int k = 1; k <= h; k++) {
				k2 = 1000 - h - k;
				if (k * k + k2 * k2 == h * h) {
					System.out.println(h * k * k2);
					return;
				}
			}
		}
	}
}
