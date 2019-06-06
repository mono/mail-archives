Hmmm security. Yeah... I guess... somewhat. 
It would all depend on how the user implemented it for their class.

Two areas I know, that I don't know too much about:
* Thread safety: It's a big old static object and I lock into a few sections, but I'm not 100% on the subtlies of locking.
* Performance: 
It seems most of the time is spent in:
System.Activator::CreateInstance (creating the appropriate licenseProvider) 
System.Attribute::GetCustomAttribute (getting the licenseProvider type for the object)
If performance was an issue, it may be worth caching the Type to licenseProvider type, or even Type to licenseProvider instance.

Files attached.

--- Sebastien Pouliot <spouliot@videotron.ca> wrote:
Hello Ivan,

Please post a diff (cvs -z3 diff -u) to the mailling list.
I will review the patch as a license manager is (somewhat security) related.

Thanks for your contribution to Mono :)

Sebastien Pouliot
http://pages.infinit.net/ctech/poupou.html
