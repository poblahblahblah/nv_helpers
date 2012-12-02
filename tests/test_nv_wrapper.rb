require 'nv_helpers'
require 'test/unit'

class TestNvWrapper < Test::Unit::TestCase
  def test_initialize
    assert_nothing_raised{ NvHelpers::NvWrapper.new }
    assert_nothing_raised{ NvHelpers::NvWrapper.new({'server' => 'nventory.slacklabs.com'}) }
    assert_nothing_raised{ NvHelpers::NvWrapper.new({'server' => 'nventory.slacklabs.com', 'username' => 'guest'}) }
    assert_nothing_raised{ NvHelpers::NvWrapper.new({'server' => 'nventory.slacklabs.com', 'username' => 'guest', 'password' => 'guest'}) }
  end

  def test_get_nodes
    nv_helper = NvHelpers::NvWrapper.new({'server' => 'nventory.slacklabs.com'})

    # expecting not to find any nodes on slacklabs that have interface 
    # eth0 ...
    result = nv_helper.get_nodes({
      :get => {'network_interfaces[name]' => "eth0"},
      :includes => ['network_interfaces[ip_addresses]']
    })
    assert(result.empty?)
  end
end
