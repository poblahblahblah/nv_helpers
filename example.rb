require 'nv_helpers'

helper = NvHelpers::NvWrapper.new(:server => "http://nventory.slacklabs.com") # guest/guest

puts helper.get_nodes_from_group("apache-server").inspect
puts helper.parse_node_group("qa-r1-jazzed:account").inspect

# Get all graffitis of this nodegroup
puts helper.get_graffitis("apache-server").inspect

# Specify what graffitis you want to get
puts helper.get_graffitis("apache-server", ["test"]).inspect

puts helper.get_node_by_name("nonexistingnode.com").inspect
puts helper.get_node_by_name("cc1").inspect
