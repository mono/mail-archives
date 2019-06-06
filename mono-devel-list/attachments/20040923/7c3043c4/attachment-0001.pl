public string LockToKey(string lck) {
	string ret;
	integer h;
	integer j;
	integer n = 5;
	
	h = lck.indexOf(" ");
	if (h > -1)
		lck = lck.Substring(0,h);
	
	h = (int)(lck[0] ^ lck[lck.Length - 1] ^ lck[lck.Length - 2] ^ (char)n);
	
	//iirc, an integer divided by an integer should be an integer
	h = (h / 16) ^ (h * 16);
	h %= 256;
	
	//this would require a sloppy goto/continue switch case
	//	an if statement works better in this instance.
	if ((h==0)||(h==5)||(h==36)||(h==96)||(h==124)||(h==126))
		ret = "/%DCN" + ("00" + h.ToString()).Substring(0,3) + "%/";
	else
		ret = ((chr)h).ToString();
	
	//iteration through each character in the lck, stopping before end
	for (j=0; j<lck.Length-1; j++) {
		h = (int)(lck[j] ^ lck[j+1]);
		h = (h / 16) ^ (h * 16);
		h %= 256;
		
		if ((h==0)||(h==5)||(h==36)||(h==96)||(h==124)||(h==126))
			ret += "/%DCN" + ("00" + h.ToString()).Substring(0,3) + "%/";
		else
			ret += ((chr)h).ToString();
	}
	
	return ret;
}