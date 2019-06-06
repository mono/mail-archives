/**
 *
 * Project   : Master C# Documentation Generator
 * URL       : http://csdoc.sourceforge.net
 * Namespace : Mono.CSharp
 * Class     : AssemblyObjectNames
 * Author    : Gaurav Vaish
 *
 * Copyright : (C) 2002-2003, with Gaurav Vaish
 */

using System;
using System.Collections;

namespace Mono.CSharp
{
	public class AssemblyObjectNames
	{
		private static AssemblyObjectNames root = 
		                    new AssemblyObjectNames();
		private string thisName;
		private Location location;
		private AssemblyObjectNames[] children;
		private bool isNamespace;

		private AssemblyObjectNames()
		{
			this.thisName = String.Empty;
			this.children = null;
		}

		public static AssemblyObjectNames Root
		{
			get
			{
				return root;
			}
		}

		public bool IsNamespace
		{
			get
			{
				return this.isNamespace;
			}
		}

		public Location Location
		{
			get
			{
				return this.location;
			}
		}

		public string Name
		{
			get
			{
				return this.thisName;
			}
		}

		public AssemblyObjectNames[] Children
		{
			get
			{
				return this.children;
			}
		}

		// false == could not add. Name already defined
		public bool AddChild(string fullName, ref Location location,
		                     bool isNamespace)
		{
			return Root.AddChild(ref Root.children, ref location,
			                     fullName, isNamespace);
		}

		private bool AddChild(ref AssemblyObjectNames[] names,
		                      ref Location location,
		                      string subName, bool isNamespace)
		{
			int colon = subName.IndexOf('.');
			string first = (colon == -1 ?
			            subName : subName.Substring(0, colon));
			string remainder = (colon == -1 ?
			            String.Empty : subName.Substring(colon + 1));
			int addIndex = -1;
			bool existed = false;
			if(names == null)
			{
				names = new AssemblyObjectNames[1];
				names[0] = new AssemblyObjectNames();
				names[0].thisName = first;
				names[0].children = null;
				names[0].isNamespace = isNamespace;
				names[0].location = location;
				addIndex = 0;
			} else
			{
				for(int index = 0; index < names.Length; index++)
				{
					if(names[index].thisName == first)
					{
						addIndex = index;
						existed = true;
						break;
					}
				}
				if(!existed)
				{
					int len = names.Length;
					AssemblyObjectNames[] newNames =
					           new AssemblyObjectNames[len];
					Array.Copy(names, newNames, len);
					names = new AssemblyObjectNames[len + 1];
					Array.Copy(newNames, names, len);
					names[len] = new AssemblyObjectNames();
					names[len].thisName = first;
					names[len].children = null;
					names[len].isNamespace = isNamespace;
					names[len].location = location;
					addIndex = len;
				}
			}
			if(remainder == String.Empty)
			{
				if(existed)
				{
					location = names[addIndex].location;
					return (names[addIndex].isNamespace && isNamespace);
				}
				return true;
			}

			return AddChild(ref names[addIndex].children,
			                ref location,
			                remainder, isNamespace);
		}

		private static string GetBasename(string nsName,
		                                          int level)
		{
			string[] split = nsName.Split(new char[] { '.' });
			if(level < split.Length)
			{
				return split[level];
			}
			return String.Empty;
		}

		private static bool IsDefined(string fullName)
		{
			throw new NotImplementedException();
		}
	}
}
