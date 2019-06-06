#
# See slapd.conf(5) for details on configuration options.
# This file should NOT be world readable.
#
ucdata-path	C:/openldap/ucdata
include   C:/openldap/etc/schema/core.schema
include   C:/openldap/etc/schema/cosine.schema
include   C:/openldap/etc/schema/nis.schema
include   C:/openldap/etc/schema/courier.schema

# Define global ACLs to disable default read access.

# Do not enable referrals until AFTER you have a working directory
# service AND an understanding of referrals.
#referral	ldap://root.openldap.org

pidfile		C:/openldap/var/run/slapd.pid
argsfile	C:/openldap/var/run/slapd.args

# Load dynamic backend modules:
# modulepath	C:/openldap/libexec/openldap
# moduleload	back_bdb.la
# moduleload	back_ldap.la
# moduleload	back_ldbm.la
# moduleload	back_passwd.la
# moduleload	back_shell.la

# Sample security restrictions
#	Require integrity protection (prevent hijacking)
#	Require 112-bit (3DES or better) encryption for updates
#	Require 63-bit encryption for simple bind
# security ssf=1 update_ssf=112 simple_bind=64

# Sample access control policy:
#	Root DSE: allow anyone to read it
#	Subschema (sub)entry DSE: allow anyone to read it
#	Other DSEs:
#		Allow self write access
#		Allow authenticated users read access
#		Allow anonymous users to authenticate
#	Directives needed to implement policy:
# access to dn.base="" by * read
# access to dn.base="cn=Subschema" by * read
# access to *
#	by self write
#	by users read
#	by anonymous auth
#
# if no access controls are present, the default policy
# allows anyone and everyone to read anything but restricts
# updates to rootdn.  (e.g., "access to * by * read")
#
# rootdn can always read and write EVERYTHING!

#basic definitions
#access to dn.base="" by * read
#access to *
#	by self write
#	by users read

#User1 permissions
#access to dn.base="ou=R&D,ou=People,dc=myhosting,dc=example"
#	by dn.exact="cn=User1,ou=Users,dc=myhosting,dc=example" read

#User2 permissions
#access to dn.base="ou=DevQA,ou=People,dc=myhosting,dc=example"
#	by dn.exact="cn=User2,ou=Users,dc=myhosting,dc=example" read

#SuperUser permissions
#access to dn.base="ou=People,dc=myhosting,dc=example"
#	by dn.exact="cn=SuperUser,ou=Users,dc=myhosting,dc=example" read



#######################################################################
# BDB database definitions
#######################################################################
database      bdb
suffix        "dc=myhosting,dc=example"
rootdn        "cn=Manager,dc=myhosting,dc=example"
# Cleartext passwords, especially for the rootdn, should
# be avoid.  See slappasswd(8) and slapd.conf(5) for details.
# Use of strong authentication encouraged.
rootpw		secret
# The database directory MUST exist prior to running slapd AND 
# should only be accessible by the slapd and slap tools.
# Mode 700 recommended.
directory	C:/openldap/var/openldap-data
# Indices to maintain
index   objectClass  pres,eq
index   mail,cn      eq,sub
