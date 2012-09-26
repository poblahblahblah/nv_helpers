#$:.unshift File.join(File.dirname(__FILE__),'..')
require 'nv_helpers' #/node_group_helper
require 'test/unit'

class TestNodeGroupHelper < Test::Unit::TestCase
  include NvHelpers::NodeGroupHelper
  def test_parse_node_group
    expect = {:env => "qa"}
    result = parse_node_group("qa")
    assert_equal(expect, result)

    expect = {:env => "prod", :service => "service"}
    result = parse_node_group("prod:service")
    assert_equal(expect, result)

    expect = {:env => "dev", :service => "webapp", :product => "singles"}
    result = parse_node_group("dev-singles:webapp")
    assert_equal(expect, result)

    expect = {:env => "dyn", :service => "account", :product => "jazzed", :runway => "ddao"}
    result = parse_node_group("dyn-ddao-jazzed:account")
    assert_equal(expect, result)

    expect = {:env => "qa", :service => "webapp", :product => "singles"}
    result = parse_node_group("qa-singles:webapp")
    assert_equal(expect, result)

    expect = {:env => "qa", :service => "account", :product => "jazzed", :runway => "r1"}
    result = parse_node_group("qa-r1-jazzed:account")
    assert_equal(expect, result)

    expect = {:service => "something3", :runway => "something", :product => "something2"}
    result = parse_node_group("something-something2:something3")
    assert_equal(expect, result)
  end

  def test_whats_my_node_group
    data = {:product => "singles", :service => "webapp", :env => "prod"}
    result = whats_my_node_group(data)
    assert_equal("prod-singles:webapp", result)
    result = whats_my_node_group(data, "-")
    assert_equal("prod-singles-webapp", result)

    data = {:product => "jazzed", :service => "account", :env => "qa", :runway => "r1"}
    result = whats_my_node_group(data)
    assert_equal("qa-r1-jazzed:account", result)

    data = {:product => "jazzed", :service => "account", :env => "dev"}
    result = whats_my_node_group(data)
    assert_equal("dev-jazzed:account", result)

    data = {:service => "hadoop"}
    result = whats_my_node_group(data)
    assert_equal("hadoop", result)

    data = {:product => "jazzed", :service => "webapp"}
    result = whats_my_node_group(data)
    assert_equal("jazzed:webapp", result)
 
    data = {:env => "qa", :product => "singles", :service => "webapp"}
    result = whats_my_node_group(data)
    assert_equal("qa-singles:webapp", result)

    data = {:env => "qa", :product => "", :service => "webapp"}
    result = whats_my_node_group(data)
    assert_equal("qa:webapp", result)
  end
end
