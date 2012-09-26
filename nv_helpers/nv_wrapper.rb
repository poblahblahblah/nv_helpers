require 'nventory'

module NvHelpers
  # Wrapper class for querying nVentory
  class NvWrapper
    include GraffitiHelper
    include NodeGroupHelper

    def initialize(nv_config={})
      # nventory client config hash uses symbol. Make sure we convert all
      # the keys to symbols
      @nv_config = nv_config.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      @nv_config[:server] ||= "http://nventory.corp.eharmony.com"
      if @nv_config[:server] !~ /^http/
        @nv_config[:server]  = "http://" + @nv_config[:server] 
      end 
      @username = @nv_config[:username]
      @password = @nv_config[:password]

      @nvclient = NVentory::Client.new(@nv_config)
    end
    
    def set_nv_server_url(url)
      @nv_config[:server] = url
      @nvclient = NVentory::Client.new(@nv_config)
    end

    def method_missing method_id, *args
      @nvclient.send(method_id, *args)
    end

    def delete_objects(objecttypes, data)
      @nvclient.delete_objects(objecttypes, data, @username, @password)
    end
  
    def delete_nodes(data)
      delete_objects('nodes', data)
    end

    def get_objects(options)
      # including all available fields
      if options[:includeallfields]
        includes_hash = {}
        field_names = @nvclient.get_field_names(options[:objecttype])
        field_names.each do |field_name_entry|
          field_name, rest = field_name_entry.split(' ')
          if field_name =~ /([^\[]+)\[.+\]/
            includes_hash[$1] = true
          end
        end
        includes ||= []
        includes |= includes_hash.keys
        options[:includes] = includes
      end

      objects = @nvclient.get_objects(options)
      return objects
    end

    def get_nodes(options)
      options[:objecttype] = 'nodes'
      return get_objects(options)
    end

    # Returns nVentory data of nodegroup with the given name
    def get_node_by_name(name, options={})
      options[:exactget] ||= {}
      options[:exactget][:name] = name
      ret = get_nodes(options)
      if ret.empty?
        warn "Cannot find node #{name}"
        ret = nil
      elsif ret.values.size == 1
        ret = ret.values[0]
      else
        raise "Multiple nodes returned for #{name}"
      end
      ret 
    end

    # Returns nVentory data of nodegroup with the given id 
    def get_node_by_id(id, options={})
      options[:exactget] ||= {}
      options[:exactget][:id] = id.to_s
      ret = get_nodes(options)
      if ret.empty?
        warn "Cannot find node #{name}"
        ret = nil
      elsif ret.values.size == 1
        ret = ret.values[0]
      else
        raise "Multiple nodes returned for #{name}"
      end
      ret
    end

    # Returns hash of nodegroupname => nodegroupdata
    def get_nodes_from_group(node_group, options = {})
      options[:exactget] ||= {}
      options[:exactget]['node_group[name]'] = node_group
      options[:includes] ||= []
      options[:includes] << ['status'] # we're always interested in status
      return get_nodes(options)
    end

    # Returns nVentory data for the given nodegroup and option
    def get_node_group_by_name(name, options = {})
      options[:objecttype] = 'node_groups'
      options[:exactget] ||= {}
      options[:exactget][:name] = name
      ret = get_objects(options)
      if ret.empty?
        warn "Cannot find node #{name}"
        ret = nil
      elsif ret.values.size == 1
        ret = ret.values[0]
      else
        raise "Multiple nodes returned for #{name}"
      end
      ret
    end
  end
end
