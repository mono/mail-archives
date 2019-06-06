using System;
using System.Collections.Generic;

public interface TestItf<TT>
{
	void TestMethod ();
}

public interface TestItf2<TT, YY>
{
	void TestMethod ();
}

/// <summary>
/// blah
/// </summary>
public class Test : TestItf<int>, TestItf2<int, double>
{
	public Test ()
	{

	}

	/// <summary>
	/// Test
	/// </summary>
	void TestItf<int>.TestMethod ()
	{
	}

	/// <summary>
	/// Test
	/// </summary>
	void TestItf2<int, double>.TestMethod ()
	{
	}

	
}

