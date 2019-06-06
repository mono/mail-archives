
using System; 
using System.Globalization;
using System.Runtime.CompilerServices;

class T {
	const int iters = 10, value = 32; 
	
	
	public static void Main ()
	{
		System.Threading.Thread.CurrentThread.CurrentCulture = System.Globalization.CultureInfo.InvariantCulture;

		// jit everything, so we dont get funk 
		bool ib;
		//return;

		String test = "Test";
		String singlechar = "A";
		String TS = "TestString";
		int count = 0;//iters;

		//TS = new String ('a', 10);
		TS = "jhiosd jfiodjs oisd jfiofdsa jfio sadjfiopsda jifo ajs ghid ghuidfs ghuisd hgui sdhfuig shdfuihsdufi ghsuidf ghuis hdfgui fsdhuigshdfuighufid hiusd hfgid hfiu hsiufd hgiusdfhiugdshfi ushufid hguidfs huigs dfhuigfdhui hiu fdhsiug hdfsui hiudhsiofhidshfuihdfohfui hisdf hugie rhiusd hriu shfdui hgiudf huifdshf uiosdhfui iofjidos jfaiosd jfioa sdjfio asdjiofasdjio";
		TS = "jhiosd jfiodjs oisd jfiofdsa jfio sadjfiopsda jifo ajs ghid ghuidfs ghuisd hgui sdhfuig shdfuihsdufi ghsuidf ghuis hdfgui fsdhuigshdfuighufid hiusd hfgid hfiu hsiufd hgiusdfhiugdshfi ushufid hguidfs huigs dfhuigfdhui hiu fdhsiug hdfsui hiudhsiofhidshfuihdfohfui hisdf hugie rhiusd hriu shfduihiosd jfiodjs oisd jfiofdsa jfio sadjfiopsda jifo ajs ghid ghuidfs ghuisd hgui sdhfuig shdfuihsdufi ghsuidf ghuis hdfgui fsdhuigshdfuighufid hiusd hfgid hfiu hsiufd hgiusdfhiugdshfi ushufid hguidfs huigs dfhuigfdhui hiu fdhsiug hdfsui hiudhsiofhidshfuihdfohfui hisdf hugie rhiusd hriu shfdui hgiudf huifdshf uiosdhfui iofjidos jfaiosd jfioa sdjfio asdjiofasdjihiosd jfiodjs oisd jfiofdsa jfio sadjfiopsda jifo ajs ghid ghuidfs ghuisd hgui sdhfuig shdfuihsdufi ghsuidf ghuis hdfgui fsdhuigshdfuighufid hiusd hfgid hfiu hsiufd hgiusdfhiugdshfi ushufid hguidfs huigs dfhuigfdhui hiu fdhsiug hdfsui hiudhsiofhidshfuihdfohfui hisdf hugie rhiusd hriu shfdui hgiudf huifdshf uiosdhfui iofjidos jfaiosd jfioa sdjfio asdjiofasdjihiosd jfiodjs oisd jfiofdsa jfio sadjfiopsda jifo ajs ghid ghuidfs ghuisd hgui sdhfuig shdfuihsdufi ghsuidf ghuis hdfgui fsdhuigshdfuighufid hiusd hfgid hfiu hsiufd hgiusdfhiugdshfi ushufid hguidfs huigs dfhuigfdhui hiu fdhsiug hdfsui hiudhsiofhidshfuihdfohfui hisdf hugie rhiusd hriu shfdui hgiudf huifdshf uiosdhfui iofjidos jfaiosd jfioa sdjfio asdjiofasdjihiosd jfiodjs oisd jfiofdsa jfio sadjfiopsda jifo ajs ghid ghuidfs ghuisd hgui sdhfuig shdfuihsdufi ghsuidf ghuis hdfgui fsdhuigshdfuighufid hiusd hfgid hfiu hsiufd hgiusdfhiugdshfi ushufid hguidfs huigs dfhuigfdhui hiu fdhsiug hdfsui hiudhsiofhidshfuihdfohfui hisdf hugie rhiusd hriu shfdui hgiudf huifdshf uiosdhfui iofjidos jfaiosd jfioa sdjfio asdjiofasdjihiosd jfiodjs oisd jfiofdsa jfio sadjfiopsda jifo ajs ghid ghuidfs ghuisd hgui sdhfuig shdfuihsdufi ghsuidf" 
		+ " ghuis hdfgui fsdhuigshdfuighufid hiusd hfgid hfiu hsiufd hgiusdfhiugdshfi ushufid hguidfs huigs dfhuigfdhui hiu fdhsiug hdfsui hiudhsiofhidshfuihdfohfui hisdf hugie rhiusd hriu shfdui hgiudf huifdshf uiosdhfui iofjidos jfaiosd jfioa sdjfio asdjiofasdji hgiudf huifdshf uiosdhfui iofjidos jfaiosd jfioa sdjfio asdjiofasdjio";
		String ES1 = "shadkfjladsf kjasdfh aksdlfh aksjd fhaksld fhio sdhfia sdhfiasd hfiuas dfhiuasd";
		String ES2 = "shadkfjladsf kjasdfh aksdlfh aksjd fhaksld fhio sdhfia sdhfiasd hfiuas dfhiuasa";
		//String SSP = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
		//String SS1 = SSP + SSP + SSP + "a";
		//String SS2 = SSP + SSP + SSP + "b";
		String SS1 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
		String SS2 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
		SS2 = SS2 + "a";
		String SS3 = "aaaaaaaaaa";
		String SS4 = "baaaaaaaa";
		SS4 = SS4 + "a";
		String TSL = TS + TS + TS + TS;
		TSL = TSL + TSL + TSL + TSL;
		Char[] LSC = new char[100000];
		String LS = new String (LSC);
		//TS = "TestString";
		//TS = new String ('a', 10);
		String T1 = "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH";
		String TC = T1 + "H";
		T1 = T1 + "H";
		String T2 = "HAAAAAAAAAAAAAAHAH";
		String T3 = "               H ";
		String TSplit = "A B C D E F G H I J";
		String TReplace = T1 + "1";
		//String T3 = T1 + "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
		String T4 = "        AAAAAAAAAAAAAAA ";
		Char[] TA = new char[10000];// { 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A' };
		Char[] CA = { 'S', ' ' };
		String[] SA = new String [10];// { "Hallo", "Test", "T", "Null" };
		Char[] Search = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', ' ' };
		//String[] SA = { "Hallo", "Test", "T", "Null" };
		//String[] SA2 = new String [10];
		//Object[] SA = new Object [10];
		//for (int i = 0; i < 10; i++)
			//SA[i] = "T";
		//String[] dummy = TS.Split (CA, 0);
		String LFS = new String ('a', 10);
		//Char[] dummy = TS.ToCharArray ();
		//int it = TS.IndexOf('?');
		//char Ia = T1[100];
		//Console.WriteLine ("Test".ToUpper () );
		//Console.WriteLine (T1.Length + ": " + TReplace.Replace ('H', 'A'));
		//Console.WriteLine (T4.TrimStart (Search));
		//Console.WriteLine (T2.Trim (Search));
		Console.WriteLine (T2.PadLeft (100, '-'));
		Console.WriteLine (T2.Replace ('H', 'A'));
		Console.WriteLine (T1.Length);
		//return;
		bool b = false;

		//Console.WriteLine (String.Join (".", SA, 0, SA.Length));
		Console.WriteLine(TS.Split().Length);

		long t1 = Environment.TickCount; 

	  //for (int x = 0; x < 1000000; x++) {
	  //	UnicodeCategory u = Char.GetUnicodeCategory ('a');
	  //}
		for (int x = 0; x < 10000000; x++) {
			//singlechar += "a";
			//TestChar = (char)y;
			//String[] t = TS.Split (CA, 2);
			//String[] t = TS.Split (CA);
			//String[] t = TS.Split ();
			//String[] t = TSplit.Split ();
			//Char[] t = TS.ToCharArray (5, 2);
			//Char[] t = T2.ToCharArray (0, T2.Length);
			//Char[] t = T1.ToCharArray ();
			TSL.CopyTo (0, TA, 0, 512);
			//String t = T1.Substring (958);
			//String t = T2.ToUpper (CultureInfo.InvariantCulture);
			//String t = T3.Trim ();
			//String t = T3.Trim (Search);
			//String t = test.Trim (null);
			//String t = T2.TrimStart (Search);
			//String t = T2.PadLeft (30, '-');
			//String t = T1.Remove (5, 50);
			//String t = String.Copy (T1);
			//count += t.Length;
			//count += T2.IndexOf('H');
			//count += "".IndexOf('_');
			//count += T2.IndexOf('A', 0, 12);
			//count += T1.IndexOfAny(Search);
			//count += T1.IndexOfAny(Search);
			//count += (short)T1[100];
			//TestB ("Test", 1);
			//String.Join (".", SA, 0, SA.Length);
			//String t = test.Insert (2, test);
			//String t = test.ToLower();
			//String t = String.Concat ("Hallo", "Test", "n", "Null", "n", "Null");
			//String t = String.Concat ("Hallo", "Test", null, "Null"); //, null, "Null");
			//String t = String.Concat ("Test", null, null, null); //, null, "Null");
			//String t = String.Concat ("T", "T", "T", "T");
			//String t = T2.Insert (5, "B");
			//String t = TReplace.Replace ('H', 'A');
			//String t = T2.Replace ('H', 'A');
			//String t = TReplace.Replace ('H', 'a');
			//int i = singlechar.HashCodeSpeed () ;
			//int i = singlechar.GetHashCode () ;
			//b = String.Equals (SS3, SS4);
			//b = (ES1.ToLower() == SS1.ToLower());
			//b = ("ah".ToLower() == "ah".ToLower());
			//b = (String.Compare (ES1, SS1, true, CultureInfo.InvariantCulture) == 0);
			//b = (String.Compare ("ah", "ah", true, CultureInfo.InvariantCulture) == 0);
			//b = String.Equals (null, null);
			if (b)
				count++;
			//count += t.Length;
			//count += i;
		}
          //for (int i = 0; i < iters; i ++) fib (value); 
           
          long t2 = Environment.TickCount; 
	  //GC.Collect(3);
	  long t3 = Environment.TickCount; 
           
//	  for (int x = 0; x < 1000; x++) {
//		for (int y = 0; y < (int)Char.MaxValue; y++) {
//	for (int x = 0; x < 10000000; x++) {
////			//TestChar = (char)y;
////			//char lowerchar = Char.ToLower((char)y);
////	  		bool b = Char.IsDigit (TestChar);
////			//char[] b = new char[test.Length];
////			//for (int c = 0; c < test.Length; c++) {
////			//	b[c] = Char.ToLower(test[c]);
////			//}
////			//String result = new String (b);
////		}
//		String t = String.Concat (SA2);
//		count += t.Length;
//	}
	  //CharTest.GetUnicodeCategory ('a');
          //for (int i = 0; i < iters; i ++) fib_box (value); 
           
          long t4 = Environment.TickCount; 
		
		Console.WriteLine ("First try  : {0}", t2 - t1);
		Console.WriteLine ("Second try: {0}", t4 - t3);
		Console.WriteLine (count);
		//Console.WriteLine (singlechar.GetHashCode() + ";" + singlechar.HashCodeTest());
		//Console.WriteLine ("A".Split('A')[1]);
	}
	
		public static void TestA (string str, int index)
		{
			if (str == null) 
				throw new ArgumentNullException (Locale.GetText ("str is a null reference"));
			
			if (index < 0 || index >= str.Length)
				throw new ArgumentOutOfRangeException (Locale.GetText (
				 "The value of index is less than zero, or greater than or equal to the length of str"));
		}
		
		public static void TestB (string str, int index)
		{
			if (str == null) 
				throw new ArgumentNullException (Locale.GetText ("str is a null reference"));
			
			if (index < 0)
				throw new ArgumentOutOfRangeException (Locale.GetText (
				 "The value of index is less than zero, or greater than or equal to the length of str"));
			if (index >= str.Length)
				throw new ArgumentOutOfRangeException (Locale.GetText (
				 "The value of index is less than zero, or greater than or equal to the length of str"));
		}

}


	public class Locale {
		public static String GetText (String i){ return null;}
	}
	
