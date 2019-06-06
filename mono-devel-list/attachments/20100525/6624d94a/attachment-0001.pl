using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Test
{
	/// <summary>
	/// Classe qui permet de contenir un ensemble de valeurs uniques qui sont accessibles en
	/// temps constant.
	/// </summary>
	/// <typeparam name="T">Type de donnée à mettre dans le HashSet.</typeparam>
	public class HashSet<T>
	{
		#region Types
		internal struct Slot
		{
			internal int hashCode;
			internal T value;
			internal int next;
		}
		#endregion

		#region Members
		private static readonly int[] primes = new int[] { 
            3, 7, 11, 0x11, 0x17, 0x1d, 0x25, 0x2f, 0x3b, 0x47, 0x59, 0x6b, 0x83, 0xa3, 0xc5, 0xef, 
            0x125, 0x161, 0x1af, 0x209, 0x277, 0x2f9, 0x397, 0x44f, 0x52f, 0x63d, 0x78b, 0x91d, 0xaf1, 0xd2b, 0xfd1, 0x12fd, 
            0x16cf, 0x1b65, 0x20e3, 0x2777, 0x2f6f, 0x38ff, 0x446f, 0x521f, 0x628d, 0x7655, 0x8e01, 0xaa6b, 0xcc89, 0xf583, 0x126a7, 0x1619b, 
            0x1a857, 0x1fd3b, 0x26315, 0x2dd67, 0x3701b, 0x42023, 0x4f361, 0x5f0ed, 0x72125, 0x88e31, 0xa443b, 0xc51eb, 0xec8c1, 0x11bdbf, 0x154a3f, 0x198c4f, 
            0x1ea867, 0x24ca19, 0x2c25c1, 0x34fa1b, 0x3f928f, 0x4c4987, 0x5b8b6f, 0x6dda89, 0x8cd721, 0xd342ab
         };

		private const int Lower31BitMask = 0x7fffffff;
		private int[] buckets;
		private IEqualityComparer<T> comparer;
		private int count;
		private int freeList;
		private int lastIndex;
		private Slot[] slots;
		#endregion

		#region Properties
		public IEqualityComparer<T> Comparer
		{
			get { return this.comparer; }
		}

		public int Count
		{
			get { return this.count; }
		}
		#endregion

		#region Methods
		// Methods
		public HashSet()
			: this(EqualityComparer<T>.Default)
		{
		}

		public HashSet(int capacity)
			: this(capacity, EqualityComparer<T>.Default)
		{
			this.Initialize(capacity);
		}

		public HashSet(int capacity, IEqualityComparer<T> comparer)
			: this(comparer)
		{
			if (capacity < 0)
			{
				throw new ArgumentOutOfRangeException("capacity", "capacity can't be negative.");
			}
			this.Initialize(capacity);
			this.comparer = comparer;
		}

		public HashSet(IEqualityComparer<T> comparer)
		{
			if (comparer == null)
			{
				comparer = EqualityComparer<T>.Default;
			}
			this.comparer = comparer;
			this.lastIndex = 0;
			this.count = 0;
			this.freeList = -1;
		}

		/// <summary>
		/// Ajoute un élément s'il n'est pas déjà dans le HashSet.
		/// </summary>
		/// <param name="item">Item à ajouter.</param>
		/// <returns>True si l'élément a été ajouté, false sinon.</returns>
		public bool Add(T item)
		{
			return this.AddIfNotPresent(item);
		}

		private bool AddIfNotPresent(T value)
		{
			int index;
			if (this.buckets == null)
			{
				this.Initialize(0);
			}
			int num = this.comparer.GetHashCode(value) & Lower31BitMask;
			int num2 = num % this.buckets.Length;
			for (int i = this.buckets[num % this.buckets.Length] - 1; i >= 0; i = this.slots[i].next)
			{
				if ((this.slots[i].hashCode == num) && this.comparer.Equals(this.slots[i].value, value))
				{
					return false;
				}
			}
			if (this.freeList >= 0)
			{
				index = this.freeList;
				this.freeList = this.slots[index].next;
			}
			else
			{
				if (this.lastIndex == this.slots.Length)
				{
					this.IncreaseCapacity();
					num2 = num % this.buckets.Length;
				}
				index = this.lastIndex;
				this.lastIndex++;
			}
			this.slots[index].hashCode = num;
			this.slots[index].value = value;
			this.slots[index].next = this.buckets[num2] - 1;
			this.buckets[num2] = index + 1;
			this.count++;
			return true;
		}

		/// <summary>
		/// Vide le HashSet, mais conserve la capacité actuelle.
		/// </summary>
		public void Clear()
		{
			if (this.lastIndex > 0)
			{
				Array.Clear(this.slots, 0, this.lastIndex);
				Array.Clear(this.buckets, 0, this.buckets.Length);
				this.lastIndex = 0;
				this.count = 0;
				this.freeList = -1;
			}
		}

		/// <summary>
		/// Vérifie si un item est présent dans le HashSet.
		/// </summary>
		/// <param name="item">Item à chercher.</param>
		/// <returns>True si l'item a été trouvé, false sinon.</returns>
		public bool Contains(T item)
		{
			if (this.buckets != null)
			{
				int num = this.comparer.GetHashCode(item) & Lower31BitMask;
				for (int i = this.buckets[num % this.buckets.Length] - 1; i >= 0; i = this.slots[i].next)
				{
					if ((this.slots[i].hashCode == num) && this.comparer.Equals(this.slots[i].value, item))
					{
						return true;
					}
				}
			}
			return false;
		}

		private void IncreaseCapacity()
		{
			int min = this.count * 2;
			if (min < 0)
			{
				min = this.count;
			}
			int prime = GetPrime(min);
			if (prime <= this.count)
			{
				throw new ArgumentException("HashSet capacity overflow.");
			}
			Slot[] destinationArray = new Slot[prime];
			if (this.slots != null)
			{
				Array.Copy(this.slots, 0, destinationArray, 0, this.lastIndex);
			}
			int[] numArray = new int[prime];
			for (int i = 0; i < this.lastIndex; i++)
			{
				int index = destinationArray[i].hashCode % prime;
				destinationArray[i].next = numArray[index] - 1;
				numArray[index] = i + 1;
			}
			this.slots = destinationArray;
			this.buckets = numArray;
		}

		private void Initialize(int capacity)
		{
			int prime = GetPrime(capacity);
			this.buckets = new int[prime];
			this.slots = new Slot[prime];
		}

		private int InternalIndexOf(T item)
		{
			int num = this.comparer.GetHashCode(item) & Lower31BitMask;
			for (int i = this.buckets[num % this.buckets.Length] - 1; i >= 0; i = this.slots[i].next)
			{
				if ((this.slots[i].hashCode == num) && this.comparer.Equals(this.slots[i].value, item))
				{
					return i;
				}
			}
			return -1;
		}

		/// <summary>
		/// Enlève un item du HashSet.
		/// </summary>
		/// <param name="item">Item à enlever du HashSet.</param>
		/// <returns>True si l'item a été enlever, false s'il n'était pas dans le HashSet.</returns>
		public bool Remove(T item)
		{
			if (this.buckets != null)
			{
				int num = this.comparer.GetHashCode(item) & Lower31BitMask;
				int index = num % this.buckets.Length;
				int num3 = -1;
				for (int i = this.buckets[index] - 1; i >= 0; i = this.slots[i].next)
				{
					if ((this.slots[i].hashCode == num) && this.comparer.Equals(this.slots[i].value, item))
					{
						if (num3 < 0)
						{
							this.buckets[index] = this.slots[i].next + 1;
						}
						else
						{
							this.slots[num3].next = this.slots[i].next;
						}
						this.slots[i].hashCode = -1;
						this.slots[i].value = default(T);
						this.slots[i].next = this.freeList;
						this.freeList = i;
						this.count--;
						return true;
					}
					num3 = i;
				}
			}
			return false;
		}

		private static int GetPrime(int min)
		{
			for (int i = 0; i < primes.Length; i++)
			{
				int num2 = primes[i];
				if (num2 >= min)
				{
					return num2;
				}
			}
			for (int j = min | 1; j < Int32.MaxValue; j += 2)
			{
				if (IsPrime(j))
				{
					return j;
				}
			}
			return min;
		}

		private static bool IsPrime(int candidate)
		{
			if ((candidate & 1) == 0)
			{
				return (candidate == 2);
			}
			int num = (int)Math.Sqrt((double)candidate);
			for (int i = 3; i <= num; i += 2)
			{
				if ((candidate % i) == 0)
				{
					return false;
				}
			}
			return true;
		}

		#endregion
	}

	class Program
	{
		static void Main(string[] args)
		{
			Encoding encoding = Encoding.GetEncoding(1252);
			Random random = new Random(11);
			MemoryStream memoryStream = new MemoryStream();

			HashSet<string> h = new HashSet<string>();
			for (int i = 0; i < 100000; ++i)
			{
				int length = random.Next(10);
				byte[] bytes = new byte[length];
				random.NextBytes(bytes);
				string s = encoding.GetString(bytes);
				h.Add(s);
			}
		}
	}
}
