#Create the keypair:
openssl genrsa -des3 -out root-ca.key 1024

#Use the key to sign itself:
openssl req -new -x509 -days 3650 -key root-ca.key -out root-ca.crt -config openssl.cnf

perl mk_new_ca_dir.pl CondorRootCA
#mv root-ca.crt CondorRootCA
#mv root-ca.key CondorRootCA


#Creating the signing certificates
openssl genrsa -des3 -out signing-ca-1.key 1024
openssl req -new -days 1095 -key signing-ca-1.key -out signing-ca-1.csr -config openssl.cnf
openssl ca -config openssl.cnf -name CA_root -extensions v3_ca -out signing-ca-1.crt -infiles signing-ca-1.csr

#Preparing a directory structure for the signing CA
perl mk_new_ca_dir.pl CondorSigningCA1 
#mv signing-ca-1.crt CondorSigningCA1 
#mv signing-ca-1.key CondorSigningCA1

#Generating keys, signing requests, and certificates
#Users
openssl req -newkey rsa:1024 -keyout zmiller.key -config openssl.cnf -out zmiller.req
openssl ca -config openssl.cnf -out zmiller.crt -infiles zmiller.req

#Hosts
openssl req -newkey rsa:1024 -keyout host_omega.key -nodes -config openssl.cnf -out host_omega.req
openssl ca -config openssl.cnf -out host_omega.crt -infiles host_omega.req