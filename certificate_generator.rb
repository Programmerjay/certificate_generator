require 'openssl'

# Create a new private key
key = OpenSSL::PKey::RSA.new(2048)

# Create a new certificate
cert = OpenSSL::X509::Certificate.new
cert.version = 2
cert.serial = 1
cert.subject = OpenSSL::X509::Name.parse("/C=US/ST=SomeState/L=SomeCity/O=SomeOrganization/OU=SomeUnit/CN=localhost") # for local testing, please change domain name accordingly
cert.issuer = cert.subject # self-signed
cert.public_key = key.public_key
cert.not_before = Time.now
cert.not_after = cert.not_before + 2 * 365 * 24 * 60 * 60 # 2 years validity

# Sign the certificate with the private key
cert.sign key, OpenSSL::Digest::SHA256.new

# Write the key and cert to files
File.open("ca.key", "w") { |f| f.write key.to_pem }
File.open("ca.pem", "w") { |f| f.write cert.to_pem }