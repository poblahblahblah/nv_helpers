module NvHelpers
  module NodeGroupHelper
    def parse_node_group(node_group)
      result = {}
      envs = ['prod', 'qa', 'stage', 'dev', 'dyn', 'np', 'ee', 'lt']

      # First, split by the : character
      tokens = node_group.split(":")

      # Use case 1: nodegroup has the name format of x
      if tokens.size == 1
	if envs.include?(tokens[0])
	  result[:env] = tokens[0]
	else
	  # No idea
	  raise "I'm not smart enough to parse this nodegroup name."
	end
	return result
      elsif tokens.size != 2
	raise "unknown nodegroup format"
      end

      # Use case 2:  nodegroup has the name format of x:y
      result[:service] = tokens[1]
      env_product = tokens[0]
      tokens = env_product.split("-")
      if envs.include?tokens[0]
	result[:env] = tokens[0]
      end

      if result[:env] == "qa" && tokens[1] =~ /r\d+/
	result[:runway] = tokens[1]
	tokens.delete(result[:runway])
      end
      tokens.delete(result[:env])

      if tokens.size == 1
	result[:product] = tokens[0]
      elsif tokens.size > 1
	result[:runway] = tokens[0]
	tokens.delete(result[:runway])
	result[:product] = tokens.join("-")
      end
      return result
    end

    # takes in env, runway, product, service and figure out
    # the corresponding node group
    def whats_my_node_group(data={}, service_delimeter=":")
      env = data[:env]
      runway = data[:runway]
      if data[:product] == "shared" or data[:product] == ""
        product = nil
      else
        product = data[:product]
      end
      service = data[:service]
      env_prod = [env, runway, product].compact.join("-")
      env_prod = nil if env_prod.empty?
      node_group = [env_prod, service].compact.join(service_delimeter)
      return node_group
    end
  end
end
