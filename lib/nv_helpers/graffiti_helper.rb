module NvHelpers
  module GraffitiHelper
    # Returns a hash of key => value graffiti(s)
    # If user doesn't specify what graffitis, then return all graffitis
    def get_graffitis(node_group, keys = nil, recursive = false)
      result = {}
      data = get_node_group_by_name(node_group, {:includes => ['graffitis', 'parent_groups']})


      data['graffitis'].each do | graffiti |
	if keys.nil? or keys.include?(graffiti['name'])
	  result[graffiti['name']] = graffiti['value']
	end
      end
      
      # See if we got all of the graffitis we need.
      # If not, then try to find it from the parent nodegroups
      if keys
        leftover = keys - result.keys
      else
        leftover = nil
      end
      unless leftover.nil? or leftover.empty? or !recursive
	parents = data["parent_groups"].collect{|pg|pg['name']}
	parents.each do |parent|
	  # TODO: do we want to keep on traversing up the tree? If not,
	  # then we need to call get_graffitis with false
	  result.merge!(get_graffitis(parent, leftover, true))
	end
      end
      result
    end
  end
end
