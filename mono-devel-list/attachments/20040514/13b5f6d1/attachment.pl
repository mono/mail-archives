%define _prefix /usr/local
%define _sysconfdir %{_prefix}/etc
Summary: The mono CIL runtime, suitable for running .NET code
Name: mono
Version: @VERSION@
Release: 1
License: LGPL
Group: System Environment/Base
# the original file is in .gz format but I want to save a few bytes
Source0: http://go-mono.com/archive/mono-%{version}.tar.gz
# Patch1: mono-nodl.patch
URL: http://go-mono.com/
BuildRoot: %{_tmppath}/%{name}-root
Prefix: /usr/local
Requires: /sbin/ldconfig
# BuildRequires: libgc-devel
BuildRequires: bison
Packager: Miguel de Icaza <miguel@ximian.com>
Requires: mono-classes

%description
The Mono runtime implements a JIT engine for the ECMA CLI virtual machine (as
well as a byte code interpreter, the class loader, the garbage collector, threading system and
metadata access libraries.

%package devel
Summary: Files and programs needed for mono development
Group: Development/Tools
PreReq: %{name} = %{version}-%{release}

%description devel
Header files, programs and documentation needed to develop programs with
the Mono .NET implementation

%prep
%setup -q

# %patch1 -p1 -b .oldzh

%build
echo [libdir = %{_libdir}]
./configure
make

%install
rm -rf %{buildroot}
%makeinstall

%clean
rm -rf %{buildroot}

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%defattr(-, root, root)
%doc AUTHORS COPYING.LIB ChangeLog NEWS README
%{_bindir}/*
%{_libdir}/*.dll
%{_libdir}/*.so*
%{_libdir}/mono/1.0/*
%{_libdir}/mono/2.0/*
%{_libdir}/mono/gac/*/*/*
%{_mandir}/*/*
%{_sysconfdir}/%{name}/*
%{_datadir}/%{name}/*/*

%files devel
%defattr(-, root, root)
%{_libdir}/*.a
%{_libdir}/*.la
%{_libdir}/pkgconfig/*
%{_includedir}/%{name}/*/*

%changelog
* Wed Aug 21 2002 Miguel de Icaza <miguel@ximian.com>
Few touches, check into cvs

* Mon Aug 19 2002 Daniel Resare <noa@resare.com>
- Initial RPM release.
