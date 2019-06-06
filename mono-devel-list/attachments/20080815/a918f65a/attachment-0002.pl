using System;
using System.Linq;
using System.Collections.Generic;

static class CurryBug
{	// curry for function of arity 3
	//
	// this compiles
	public static Func<int,Func<int, Func<int,int>>>
		curry_for_int_func (this Func<int,int,int,int> f)
	{
		return arg1 => arg2 => arg3 => f(arg1 , arg2 , arg3);
	}

	// but his does not
	static Func<A,Func<B,Func<C,D>>> curry<A,B,C,D> (this Func<A,B,C,D> f)
	{
		return arg1 => arg2 => arg3 => f(arg1, arg2, arg3);
	}

	static void Main ()
	{
		Func<int,int,int,int> plus = (x, y, z) => x + y + z;

		Console.WriteLine(plus.curry()(7)(23)(47));
	}
}
