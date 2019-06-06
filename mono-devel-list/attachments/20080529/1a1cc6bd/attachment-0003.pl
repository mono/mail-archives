import java.math.BigDecimal;
import java.math.RoundingMode;

public class Program {

	public static void main(String[] args) {
		Addition();
		Substraction();
		Multiplication();
		Division();
	}

	private static void Division() {
		BigDecimal a, b, c, d;
		long start = System.currentTimeMillis();
		a = new BigDecimal("2345.6");
		b = new BigDecimal("0.009432");
		c = new BigDecimal("8.5467");
		// this is the rounding mode used by System.Decimal by default
		d = a.divide(b, 24, RoundingMode.HALF_EVEN).divide(c, 24,
				RoundingMode.HALF_EVEN);
		for (int i = 0; i < 10000000; i++)
			d = a.divide(b, 24, RoundingMode.HALF_EVEN).divide(c, 24,
					RoundingMode.HALF_EVEN);
		long stop = System.currentTimeMillis();
		System.out.println("division " + (stop - start) + " ms : " + d);
	}

	private static void Multiplication() {
		BigDecimal a, b, c, d;
		long start = System.currentTimeMillis();
		a = new BigDecimal("2345.6");
		b = new BigDecimal("0.009432");
		c = new BigDecimal("8.5467");
		d = a.multiply(b).multiply(c);
		for (int i = 0; i < 10000000; i++)
			d = a.multiply(b).multiply(c);
		long stop = System.currentTimeMillis();
		System.out.println("multiplication " + (stop - start) + " ms : " + d);
	}

	private static void Substraction() {
		BigDecimal a, b, c, d;
		long start = System.currentTimeMillis();
		a = new BigDecimal("2345.6");
		b = new BigDecimal("0.009432");
		c = new BigDecimal("8.5467");
		d = a.subtract(b).subtract(c);
		for (int i = 0; i < 10000000; i++)
			d = a.subtract(b).subtract(c);
		long stop = System.currentTimeMillis();
		System.out.println("substraction " + (stop - start) + " ms : " + d);
	}

	private static void Addition() {
		BigDecimal a, b, c, d;
		long start = System.currentTimeMillis();
		a = new BigDecimal("2345.6");
		b = new BigDecimal("0.009432");
		c = new BigDecimal("8.5467");
		d = a.add(b).add(c);
		for (int i = 0; i < 10000000; i++)
			d = a.add(b).add(c);
		long stop = System.currentTimeMillis();
		System.out.println("addition " + (stop - start) + " ms : " + d);
	}
}