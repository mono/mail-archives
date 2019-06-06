using System;
using System.Collections.Generic;

public class CompletionMatcherComparison
{
	internal static MatchLane MatchString (string text, string toMatch)
	{
		if (text.Length < toMatch.Length)
			return null;

		List<MatchLane> matchLanes = null;
		bool lastWasSeparator = false;
		int tn = 0;

		while (tn < text.Length) {
			char ct = text [tn];

			// Keep the lane count in a var because new lanes don't have to be updated
			// until the next iteration
			int laneCount = matchLanes != null ? matchLanes.Count : 0;

			char cm = toMatch [0];
			if (char.ToLower (ct) == char.ToLower (cm)) {
				if (matchLanes == null)
					matchLanes = new List<MatchLane> ();
				matchLanes.Add (new MatchLane (MatchMode.Substring, tn, text.Length - tn));
				if (toMatch.Length == 1)
					return matchLanes[0];
				if (char.IsUpper (ct) || lastWasSeparator)
					matchLanes.Add (new MatchLane (MatchMode.Acronym, tn, text.Length - tn));
			}

			for (int n=0; n<laneCount; n++) {
				MatchLane lane = matchLanes [n];
				if (lane == null)
					continue;
				cm = toMatch [lane.MatchIndex];
				bool match = char.ToLower (ct) == char.ToLower (cm);
				bool wordStartMatch = match && (tn == 0 || char.IsUpper (ct) || lastWasSeparator);

				if (lane.MatchMode == MatchMode.Substring) {
					if (wordStartMatch) {
						// Possible acronym match after a substring. Start a new lane.
						MatchLane newLane = lane.Clone ();
						newLane.MatchMode = MatchMode.Acronym;
						newLane.Index++;
						newLane.Positions [newLane.Index] = tn;
						newLane.Lengths [newLane.Index] = 1;
						newLane.MatchIndex++;
						matchLanes.Add (newLane);
					}
					if (match) {
						// Maybe it is a false substring start, so add a new lane to keep
						// track of the old lane
						MatchLane newLane = lane.Clone ();
						newLane.MatchMode = MatchMode.Acronym;
						matchLanes.Add (newLane);

						// Update the current lane
						lane.Lengths [lane.Index]++;
						lane.MatchIndex++;
					} else {
						if (lane.Lengths [lane.Index] > 1)
							lane.MatchMode = MatchMode.Acronym;
						else
							matchLanes [n] = null; // Kill the lane
					}
				}
				else if (lane.MatchMode == MatchMode.Acronym) {
					if (match && lane.Positions [lane.Index] == tn - 1) {
						// Possible substring match after an acronim. Start a new lane.
						MatchLane newLane = lane.Clone ();
						newLane.MatchMode = MatchMode.Substring;
						newLane.Lengths [newLane.Index]++;
						newLane.MatchIndex++;
						matchLanes.Add (newLane);
						if (newLane.MatchIndex == toMatch.Length)
							return newLane;
					}
					if (wordStartMatch || (match && char.IsPunctuation (cm))) {
						// Maybe it is a false acronym start, so add a new lane to keep
						// track of the old lane
						MatchLane newLane = lane.Clone ();
						matchLanes.Add (newLane);

						// Update the current lane
						lane.Index++;
						lane.Positions [lane.Index] = tn;
						lane.Lengths [lane.Index] = 1;
						lane.MatchIndex++;
					}
				}
				if (lane.MatchIndex == toMatch.Length)
					return lane;
			}
			lastWasSeparator = (ct == '.' || ct == '_' || ct == '-' || ct == ' ' || ct == '/' || ct == '\\');
			tn++;
		}
		return null;
	}

	internal enum MatchMode
	{
		Substring,
		Acronym
	}

	internal class MatchLane
	{
		public int[] Positions;
		public int[] Lengths;
		public MatchMode MatchMode;
		public int Index;
		public int MatchIndex;

		public MatchLane ()
		{
		}

		public MatchLane (MatchMode mode, int pos, int len)
		{
			MatchMode = mode;
			Positions = new int [len];
			Lengths = new int [len];
			Positions [0] = pos;
			Lengths [0] = 1;
			Index = 0;
			MatchIndex = 1;
		}

		public MatchLane Clone ()
		{
			MatchLane lane = new MatchLane ();
			lane.Positions = (int[]) Positions.Clone ();
			lane.Lengths = (int[]) Lengths.Clone ();
			lane.MatchMode = MatchMode;
			lane.MatchIndex = MatchIndex;
			lane.Index = Index;
			return lane;
		}
	}

	/// <summary>
	/// A class for computing sub word matches (ex. WL matches WriteLine).
	/// </summary>
	class CompletionMatcher
	{
		readonly string filterTextUpperCase;

		readonly bool[] filterTextLowerCaseTable;
		readonly bool[] filterIsNonLetter;

		readonly List<int> matchIndices;

		public CompletionMatcher (string filterText)
		{
			matchIndices = new List<int> ();
			if (filterText != null) {
				filterTextLowerCaseTable = new bool[filterText.Length];
				filterIsNonLetter        = new bool[filterText.Length];
				for (int  i = 0; i < filterText.Length; i++) {
					filterTextLowerCaseTable[i] = char.IsLower (filterText[i]);
					filterIsNonLetter[i] = !char.IsLetter (filterText[i]);
				}
				
				filterTextUpperCase = filterText.ToUpper ();
			}
		}

		public bool IsMatch (string text)
		{
			return GetMatch (text) != null;
		}
		
		/// <summary>
		/// Gets the match indices.
		/// </summary>
		/// <returns>
		/// The indices in the text which are matched by our filter.
		/// </returns>
		/// <param name='text'>
		/// The text to match.
		/// </param>
		public int[] GetMatch (string text)
		{
			if (string.IsNullOrEmpty (filterTextUpperCase))
				return new int[0];
			if (string.IsNullOrEmpty (text))
				return null;

			matchIndices.Clear ();
			int j = 0;
			
			for (int i = 0; i < filterTextUpperCase.Length; i++) {
				if (j >= text.Length)
					return null;
				bool wasMatch = false;
				char filterChar = filterTextUpperCase[i];
				// filter char is no letter -> search for next exact match
				if (filterIsNonLetter[i]) {
					for (; j < text.Length; j++) {
						if (filterChar == text[j]) {
							matchIndices.Add (j);
							j++;
							wasMatch = true;
							break;
						}
					}
					if (!wasMatch)
						return null;
					continue;
				}
				
				// letter case
				bool textCharIsUpper = char.IsUpper (text[j]);
				if ((textCharIsUpper || filterTextLowerCaseTable[i]) && filterChar == (textCharIsUpper ? text[j] : char.ToUpper (text[j]))) {
					matchIndices.Add (j++);
					continue;
				}

				// no match, try to continue match at the next word start
				j++;
				for (; j < text.Length; j++) {
					if (char.IsUpper (text[j]) && filterChar == text[j]) {
						matchIndices.Add (j);
						j++;
						wasMatch = true;
						break;
					}
				}
				
				if (!wasMatch)
					return null;
			}
			
			return matchIndices.ToArray ();
		}
	}

	public static void Main (string[] args)
	{
		Console.WriteLine ("Prepare list ...");
		List<string> list = new List<string> ();
		for (int i = 0; i < 100000; i++) {
			list.Add ("AelvfneslfhBefnlsvfelveCeolcofgcsclhoDevlhselvghesE");
		}
		
		Console.WriteLine ("Match upper case filter:");
		var now = DateTime.Now;
		list.ForEach (str => MatchString (str, "ABCDE"));
		Console.WriteLine ("navigate to filter took: {0}ms", (DateTime.Now - now).TotalMilliseconds);
		now = DateTime.Now;

		var job = new CompletionMatcher ("ABCDE");
		list.ForEach (str => job.GetMatch (str));
		Console.WriteLine ("code completion filter took: {0}ms", (DateTime.Now - now).TotalMilliseconds);
		
		Console.WriteLine ();
		Console.WriteLine ("Match lower case filter:");
		now = DateTime.Now;
		list.ForEach (str => MatchString (str, "abcde"));
		Console.WriteLine ("navigate to filter took: {0}ms", (DateTime.Now - now).TotalMilliseconds);
		now = DateTime.Now;

		job = new CompletionMatcher ("abcde");
		list.ForEach (str => job.GetMatch (str));
		Console.WriteLine ("code completion filter took: {0}ms", (DateTime.Now - now).TotalMilliseconds);
	}
}