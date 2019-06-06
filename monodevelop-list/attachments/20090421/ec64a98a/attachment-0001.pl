[ic-uach]
name=ic-uach
failovermethod=priority
baseurl=http://fedora.ic.uach.cl/yum/base/10/i386
#baseurl=http://200.2.116.223/yum/base/$releasever/$basearch
enabled=1
gpgcheck=0

[ic-uach-updates]
name=ic-uach-updates
failovermethod=priority
baseurl=http://fedora.ic.uach.cl/yum/updates/10/i386
#baseurl=http://200.2.116.223/yum/updates/$releasever/$basearch
enabled=1
gpgcheck=0
