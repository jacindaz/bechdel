require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

require 'pry'

# Creates an instance of the client.
client = Google::APIClient.new
client = Google::APIClient.new(:key => 'something')

#drive = client.discovered_api('drive', 'v2')

# Authorization setup goes here.
# Fetch the discovery document and obtain a reference to the API we care about.
search = client.discovered_api('customsearch')

# Make an API call using a reference to a discovered method.
response = client.execute(
  search.cse.list, 'q' => 'your query'
)
status, headers, body = response

puts response
