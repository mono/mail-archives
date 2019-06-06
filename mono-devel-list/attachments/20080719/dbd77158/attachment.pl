using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HashCollisions
{
    class Program
    {
        static void Main(string[] args)
        {
            var arr = get3(3);
            var l = arr.Length;
            var x = 0; // total collisions
            var y = 0; // colls
            var q = false;
            for (int i = 0; i < l; i++)
            {
                var c = arr[i];
                var h = c.GetHashCode();
                for (int j = 0; j < l; j++)
                {
                    if (i != j)
                    {
                        var t = arr[j];
                        if (h == t.GetHashCode())
                        {
                            Console.Write(c);
                            Console.Write(", ");
                            Console.WriteLine(t);
                            y++;
                            break;
                            
                            //
                            if (!q)
                            {
                                Console.Write(c);
                                Console.Write(", ");
                                y++;
                            }
                            x++;
                            Console.Write(t);
                            Console.Write(", ");
                            q = true;
                        }
                    }
                }
                if (q) Console.WriteLine();
                q = false;
            }
            Console.WriteLine(l);
            Console.WriteLine(l * l);
            Console.WriteLine(y);
            Console.WriteLine(x);
        }

        unsafe static string[] get(int size)
        {
            var s = set.Length;
            var l = set.Length;
            for (int i = 0; i < size-1; i++)
            {
                l *= l;
            }
            var all = new string[l];
            char* itm = stackalloc char[size + 1];
            int x = 0;
            for (int i = 0; i < s; i++)
            {
                itm[0] = set[i];
                for (int j = 0; j < s; j++)
                {
                    itm[1] = set[j];
                    all[x++] = new string(itm);
                }
            }
            return all;
        }
        unsafe static string[] get3(int size)
        {
            var s = set.Length;
            var l = (int)Math.Pow(s, size);
            var all = new string[l];
            char* itm = stackalloc char[size + 1];
            int x = 0;
            for (int i = 0; i < s; i++)
            {
                itm[0] = set[i];
                for (int j = 0; j < s; j++)
                {
                    itm[1] = set[j];
                    for (int k = 0; k < s; k++)
                    {
                        itm[2] = set[k];
                        all[x++] = new string(itm);
                    }
                }
            }
            return all;
        }

        static char[] set = init();

        static char[] init()
        {
            var b1 = block('a', 'z');
            var b2 = block('A', 'Z');
            var b3 = block('0', '9');
            var set = new char[b1.Length + b2.Length + b3.Length];
            Array.Copy(b1, 0, set, 0,                     b1.Length);
            Array.Copy(b2, 0, set, b1.Length,             b2.Length);
            Array.Copy(b3, 0, set, b1.Length + b2.Length, b3.Length);
            return set;
        }
        
        static char[] block(char start, char end)
        {
            return block((int)start, (int)end + 1);
        }
        
        unsafe static char[] block(int start, int end)
        {
            var length = end - start;
            var block = new char[length];
            fixed (char *p = block)
            {
                char* x = p;
                for (int i = start; i < end; i++, x++)
			    {
                    *x = (char)i;
                    Console.WriteLine(*x);
			    }
            }
            return block;
        }
    }
}