#Create the keypair:
openssl.exe genrsa -des3 -out root-ca.key 1024

#Use the key to sign itself:
openssl.exe req -new -x509 -days 3650 -key root-ca.key -out root-ca.crt -config openssl.cnf
openssl x509 -noout -text -in root-ca.crt

perl mk_new_ca_dir.pl CondorSigningCA1
#mv root-ca.crt CondorSigningCA1/signing-ca-1.crt
#mv root-ca.key CondorSigningCA1/signing-ca-1.key


#Using the Root CA to Sign Certificates
#Users
openssl.exe req -newkey rsa:1024 -keyout zmiller.key -config openssl.cnf -out zmiller.req
openssl.exe ca -config openssl.cnf -out zmiller.crt -infiles zmiller.req

#Hosts
openssl.exe req -newkey rsa:1024 -keyout host_omega.key -nodes -config openssl.cnf -out host_omega.req
openssl.exe ca -config openssl.cnf -out host_omega.crt -infiles host_omega.req