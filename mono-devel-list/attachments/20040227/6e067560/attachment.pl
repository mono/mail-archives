using System;
using System.Text.RegularExpressions;
using System.IO;

namespace RegexBench
{
	class RegexBench
	{
		private string m_text;
		
		[STAThread]
		static void Main(string[] args)
		{
			TextReader reader = null;
			try
			{	
				reader = File.OpenText("RegexBench.txt");			
				
				RegexBench bench = new RegexBench(reader.ReadToEnd());

				//***
				//To test any regex, just do :
				//bench.testRegex("", false);
				//with the regex text as first parameter.  To view the results of a regex, use true as second parameter.
								
				bench.testRegex("a|b", false);
				//bench.testRegex("(?<left><(?<inter>[a-zA-Z]+)>)[^<>]*</\\k<inter>>", false); //Balanced html tag (not exactly it)
				//bench.testRegex("(\\s[ab]{2,3}\\w+\\s)", false); //Random regex
				//bench.testRegex("\\w{3,5}://([\\.]|\\w|\\\\)*", false); //Simple Internet address
			       				
				//bench.testRegex("[abC-DefgG-Jklm]{5}", false); //Big character class
				//bench.testRegex("(\\w|(\\w\\.\\w)|(\\w_\\w)|(\\w\\-\\w))+@(\\w|(\\w\\.\\w)|(\\w_\\w)|(\\w\\-\\w))+\\.\\w{2,4}", false); //E-mail


				//Throw exception on mono
				//bench.testRegex("(?<left><(?<inter>[a-zA-Z]+)>)[^<>]*(?<right-left></\\k<inter>>)", false);//Balanced html tag (not exactly it)
			}
			catch(Exception e)
			{
				Console.WriteLine(e.Message + "\n" +  e.StackTrace);
			}
			finally
			{
				try
				{
					if (reader != null)
						reader.Close();
				}
				catch(Exception){};
			}
		}

		public RegexBench(string text)
		{
			m_text = text;
		}

		//Evaluate execution time to find all results of regex "strRegex" in compiled and uncompiled mode.
		//To view regex results, put showResult to true;
		private void testRegex(string strRegex, bool showResult)
		{	
			int begin;
			int end;
			int nbMatch;
			double compCompTime;
			double compInterTime;
			double compTime;
			double interTime;
			MatchCollection matches;

			Console.WriteLine("Testing Regex : {0}", new object[] {strRegex});

			//Creation
			begin = Environment.TickCount;
			Regex regex = new Regex(strRegex);
			end = Environment.TickCount;
			compInterTime = end - begin;
			Console.WriteLine("Creation of interpreted regex : {0}ms", new object[] {compInterTime});
			

			begin = Environment.TickCount;
			Regex regexc = new Regex(strRegex, RegexOptions.Compiled);
			end = Environment.TickCount;
			compCompTime = end - begin;
			Console.WriteLine("Compilation time : {0}ms\n", new object[] {compCompTime});
			

			//Interpreted Regex
			begin = Environment.TickCount;
			matches = regex.Matches(m_text);
			nbMatch = matches.Count;	//Important, MS do the job here.	
			end = Environment.TickCount;
			interTime = end - begin;

			Console.WriteLine("Elapsed time (Interpreted): {0}ms", new object[]{interTime});
			Console.WriteLine("Nb Match : {0}\n", new object[]{nbMatch});


			//Compiled Regex
			begin = Environment.TickCount;
			matches = regexc.Matches(m_text);	
			nbMatch = matches.Count;	//Important, MS do the job here.
			end = Environment.TickCount;
			compTime = end - begin;

			Console.WriteLine("Elapsed time (Compiled): {0}ms", new object[]{compTime});
			Console.WriteLine("Nb Match : {0}", new object[]{nbMatch});


			Console.WriteLine("\nInterpreted compilation ratio : {0}%", (int)(compInterTime / interTime * 100));
			Console.WriteLine("Compiled compilation ratio : {0}%", (int)(compCompTime / compTime * 100));
			Console.WriteLine("Compiled vs Interpreted (without compile time) : {0}%", (int)(compTime / interTime * 100));
			Console.WriteLine("Compiled vs Interpreted (with compile time) : {0}%", (int)((compTime + compCompTime) / (compInterTime + interTime) * 100));
			

			if( showResult)
			{
				for(int i=0; i<nbMatch ;i++)
				{
					Console.WriteLine(matches[i].Captures[0].Value);
					Console.WriteLine("---------------------");
				}
			}

			Console.WriteLine("");
		}
	}
}
