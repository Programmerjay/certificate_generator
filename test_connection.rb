require 'net/http'
require 'openssl'
require 'json'

# Load the CA cert
ca_cert = OpenSSL::X509::Certificate.new File.read "ca.pem"

# Create a new HTTP client
http = Net::HTTP.new 'localhost', 8000
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
http.ca_file = 'ca.pem'

# Make a GET request to the server
response = http.get '/'

# Parse the response body
data = JSON.parse response.body

# Print the certificate expiration date
puts "Certificate expiration date: #{data['expiration_date']}"
