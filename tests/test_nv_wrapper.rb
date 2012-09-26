require './nv_helpers'
require 'test/unit'

class TestNvWrapper < Test::Unit::TestCase
  def test_initialize
    assert_nothing_raised{ NvHelpers::NvWrapper.new }
    assert_nothing_raised{ NvHelpers::NvWrapper.new({'server' => 'nventory.dev.corp.eharmony.com'}) }
    assert_nothing_raised{ NvHelpers::NvWrapper.new({'server' => 'nventory.corp.eharmony.com'}) }
    assert_nothing_raised{ NvHelpers::NvWrapper.new({'server' => 'nventory.dev.corp.eharmony.com', 'username' => 'ddao'}) }
    assert_nothing_raised{ NvHelpers::NvWrapper.new({'server' => 'nventory.dev.corp.eharmony.com', 'username' => 'ddao', 'password' => 'secret'}) }
  end
  def test_get_nodes
    nv_helper =  NvHelpers::NvWrapper.new
    result = nv_helper.get_nodes({:get => {:name => "prod.dc1.eharmony.com", 'network_interfaces[name]' => "eth0"},
                                        :includes => ['network_interfaces[ip_addresses]']})
    assert(!result.empty?)
  end
end
