require 'nv_helpers'

helper = NvHelpers::NvWrapper.new

puts helper.get_nodes_from_group("qa-r1-singles-webapp").inspect
puts helper.parse_node_group("qa-r1-jazzed:account").inspect

# Get all graffitis of this nodegroup
puts helper.get_graffitis("qa-ddao-singles-webapp").inspect

# Specify what graffitis you want to get
puts helper.get_graffitis("qa-ddao-singles-webapp", ["service_name", "instances"]).inspect

puts helper.get_node_by_name("nonexistingnode.com").inspect
puts helper.get_node_by_name("devssvm.dev.dc1.eharmony.com").inspect
