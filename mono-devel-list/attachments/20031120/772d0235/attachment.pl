using System;
using Mono.Math;

public class TestApp {	
	public static void Main(string[] args) {
		try {
			// these primes are taken from RFC 2412
			// [http://www.faqs.org/rfcs/rfc2412.html]
			BigInteger bi = BigInteger.Parse("1552518092300708935130918131258481755631334049434514313202351194902966239949102107258669453876591642442910007680288864229150803718918046342632727613031282983744380820890196288509170691316593175367469551763119843371637221007210577919");
			//BigInteger bi = BigInteger.Parse("179769313486231590770839156793787453197860296048756011706444423684197180216158519368947833795864925541502180565485980503646440548199239100050792877003355816639229553136239076508735759914822574862575007425302077447712589550957937778424442426617334727629299387668709205606050270810842907692932019128194467627007");
			//BigInteger bi = BigInteger.Parse("2410312426921032588552076022197566074856950548502459942654116941958108831682612228890093858261341614673227141477904012196503648957050582631942730706805009223062734745341073406696246014589361659774041027169249453200378729434170325843778659198143763193776859869524088940195577346119843545301547043747207749969763750084308926339295559968882457872412993810129130294592999947926365264059284647209730384947211681434464714438488520940127459844288859336526896320919633919");
			Console.WriteLine("Hexadecimal representation:");
			byte[] bytes = bi.getBytes();
			for(int i = 0; i < bytes.Length; i++) {
				if (i != 0 && i % 24 == 0)
					Console.WriteLine();
				else if (i != 0 && i % 4 == 0)
					Console.Write(" ");
				Console.Write(bytes[i].ToString("X2"));
			}
			Console.WriteLine("\r\n\r\nDecimal representation:");
			Console.WriteLine(bi.ToString());
			Console.WriteLine("\r\nIs probable prime? " + bi.isProbablePrime());
		} catch (Exception e) {
			Console.WriteLine(e);
		}
		Console.ReadLine();
	}
	private static void PrintBytes(byte[] bytes) {
		for(int i = 0; i < bytes.Length; i++) {
			Console.Write(bytes[i].ToString("X2"));
		}
		Console.WriteLine("\r\n");
	}

/*  This is the BigInteger.Parse method I use. This method works
	because BigInteger.ToString returns the input I gave to Parse.
	
	public static BigInteger Parse(string number) {
		if (number == null)
			throw new ArgumentNullException(number);
		int i = 0, len = number.Length;
		char c;
		bool digits_seen = false;
		BigInteger val = new BigInteger(0);
		if (number[i] == '+') {
			i++;
		} else if(number[i] == '-') {
			throw new FormatException("Only positive integers are allowed.");
		}
		for(; i < len; i++) {
			c = number[i];
			if (c == '\0') {
				i = len;
				continue;
			}
			if (c >= '0' && c <= '9'){
				val = val * 10 + (c - '0');
				digits_seen = true;
			} else {
				if (Char.IsWhiteSpace(c)){
					for (i++; i < len; i++){
						if (!Char.IsWhiteSpace (number[i]))
							throw new FormatException();
					}
					break;
				} else
					throw new FormatException();
			}
		}
		if (!digits_seen)
			throw new FormatException();
		return val;
	}*/
}
