#if false
#line hahaha // invalid format -> no error
#error
#line hahaha // invalid format -> no error
#undef // without identifier -> error
#line hahaha // invalid format -> no error
#pragma warning disable 3005 // wrong directive on csc 1.x
	public class Foo
	{
	}
#pragma warning restore // wrong directive on csc 1.x

#region // blank -> no error
#endregion
#region Foo // without endregion -> error
#hogehoge // wrong directive

#endif
