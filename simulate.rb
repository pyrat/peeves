require 'rubygems'
require 'activesupport'

$LOAD_PATH << "lib"

ActiveSupport::Dependencies.load_paths = $LOAD_PATH

p = PeevesGateway.new(:simulator)

transaction_reference = Peeves::UniqueId.generate("TEST")

response = p.payment Peeves::Money.new(1000, "GBP"),
              {
                :transaction_reference => transaction_reference,
                :description => "Test Transaction",
                :notification_url => "http://edge.woobius.net"
              }

puts response.inspect

response2 = p.authorise Peeves::Money.new(1000, "GBP"),
{
  :transaction_reference => Peeves::UniqueId.generate("TEST"),
  :description => "Test Authorise",
  :related_transaction_reference => transaction_reference,
  :related_vps_transaction_id => response.vps_transaction_id,
  :related_security_key => response.security_key
}

puts response2.inspect