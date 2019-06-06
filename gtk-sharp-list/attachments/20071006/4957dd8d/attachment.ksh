
On Sat, 2007-10-06 at 16:11 +0200, Stefan Andersson wrote:
> Whren I run ./configure it says I need to eitheir install Mono or .NET
> but latest version of Mono is already installed and can be executed???
> I have Fedora 7 Linux on x86_64.

Be sure that you have the development package installed as well.  The
configure script is trying to check pkg-config for mono and isn't
finding it.

