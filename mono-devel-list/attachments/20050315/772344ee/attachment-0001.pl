version: 1
dn: dc=myhosting,dc=example
objectClass: dcObject
objectClass: organization
dc: myhosting
description: My wonderful company as much text as you want to place in this line up to 32Kcontinuation data for the line above must have <CR> or <CR><LF> i.e. ENTER works on both Windows and *nix system - new line MUST begin with ONE SPACE
o: Example, Inc.

dn: ou=people,dc=myhosting,dc=example
objectClass: organizationalUnit
description: All people in organisation
ou: people

dn: ou=Human Resources,ou=people,dc=myhosting,dc=example
objectClass: organizationalUnit
ou: Human Resources

dn: cn=John Smith,ou=Human Resources,ou=people,dc=myhosting,dc=example
objectClass: organizationalRole
cn: John Smith
description: Very clever person
ou: Human Resources
telephoneNumber: 1 801 555 1212

dn: cn=Barak Tsabari,ou=Human Resources,ou=people,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Barak Tsabari
facsimileTelephoneNumber: +1 906 777 8853
ou: Human Resources
ou: People
sn: Tsabari
telephoneNumber: +1 906 777 8854

dn: ou=R&D,ou=people,dc=myhosting,dc=example
objectClass: organizationalUnit
ou: R&D

dn: cn=Yossi Cohen,ou=R&D,ou=people,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Yossi Cohen
facsimileTelephoneNumber: +1 503 777 4498
ou: R&D
ou: People
sn: Cohen
telephoneNumber: +1 503 777 4499

dn: cn=Uzi Cohen,ou=R&D,ou=people,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Uzi Cohen
facsimileTelephoneNumber: +1 602 333 1234
ou: R&D
ou: People
sn: Cohen
telephoneNumber: +1 602 333 1233

dn: cn=Daniel Cohen,ou=R&D,ou=people,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Daniel Cohen
facsimileTelephoneNumber: +1 602 333 1235
ou: R&D
ou: People
sn: Cohen
telephoneNumber: +1 602 333 1236

dn: cn=Sara Cohen,ou=R&D,ou=people,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Sara Cohen
facsimileTelephoneNumber: +1 602 333 1244
ou: R&D
ou: People
sn: Cohen
telephoneNumber: +1 602 333 1243

dn: ou=DevQA,ou=people,dc=myhosting,dc=example
objectClass: organizationalUnit
ou: DevQA

dn: cn=Daniel Smith,ou=DevQA,ou=people,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Daniel Smith
facsimileTelephoneNumber: +1 408 555 3372
l: Santa Clara
ou: DevQA
ou: People
sn: Smith
telephoneNumber: +1 408 555 9519

dn: cn=Daniel Morgan,ou=DevQA,ou=people,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Daniel Morgan
facsimileTelephoneNumber: +1 805 666 5645
ou: DevQA
ou: People
sn: Morgan
telephoneNumber: +1 805 666 5644

dn: cn=Manager,dc=myhosting,dc=example
objectClass: organizationalRole
cn: Manager

dn: cn=Uzi Cohen,cn=Manager,dc=myhosting,dc=example
objectClass: person
objectClass: organizationalPerson
cn: Uzi Cohen
facsimileTelephoneNumber: +1 602 333 1234
ou: R&D
ou: People
sn: Cohen
telephoneNumber: +1 602 333 1233

