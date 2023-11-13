require 'webrick'
require 'webrick/https'
require 'json'

# Load the key and cert
cert = OpenSSL::X509::Certificate.new File.read "ca.pem"
key = OpenSSL::PKey::RSA.new File.read "ca.key"

# Create a new server
server = WEBrick::HTTPServer.new(
  :Port => 8000,
  :SSLEnable => true,
  :SSLCertificate => cert,
  :SSLPrivateKey => key
)

# Define the handler for the root of the server
server.mount_proc '/' do |req, res|
  res.body = { expiration_date: cert.not_after }.to_json
end

# Start the server
server.start