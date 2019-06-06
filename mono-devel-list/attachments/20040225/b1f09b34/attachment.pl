//
// Locale.cs
//
// Author:
//   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
//   Miguel de Icaza (miguel@ximian.com)
//
// (C) 2001 - 2003 Ximian, Inc (http://www.ximian.com)
//

using System;
using System.Globalization;
using System.Resources;
using System.Reflection;

internal sealed class Locale
{
	private static CultureInfo currentCulture;
	private static String neutralLangID;
	private static bool useInternal;
	private static ResourceManager rm;
	private static ResourceSet currentResources;

	static Locale ()
	{
		object[] attribs = Assembly.GetCallingAssembly().GetCustomAttributes (
			typeof (NeutralResourcesLanguageAttribute), false);

		if (attribs.Length >= 1)
			neutralLangID = ((NeutralResourcesLanguageAttribute)attribs[0]).CultureName;

		rm = new ResourceManager ("Resources", Assembly.GetCallingAssembly());

		InitCulture();
	}

	private Locale ()
	{
	}

	private static void InitCulture ()
	{
		currentCulture = CultureInfo.CurrentUICulture;

		// Check if we are using the neutral culture
		if (neutralLangID == currentCulture.Name) {
			useInternal = true;
			currentResources = null;
			return;
		}

		// Check if other resources exist
		currentResources = rm.GetResourceSet (currentCulture, true, true);
		if (currentResources == null) {
			useInternal = true;
			return;
		}

		useInternal = false;
	}

	/// <summary>
	///   Returns the translated message for the current locale
	/// </summary>
	internal static string GetText (string msg)
	{
		// Check if the culture has changed
		if (CultureInfo.CurrentUICulture != currentCulture)
			// TODO locking mechanism here?
			InitCulture();

		if (useInternal)
			return msg;

		// TODO Is it guaranteed that we get something back here?
		return currentResources.GetString (msg);
	}

	internal static object GetObject (string idString)
	{
		return rm.GetObject (idString);
	}
}
