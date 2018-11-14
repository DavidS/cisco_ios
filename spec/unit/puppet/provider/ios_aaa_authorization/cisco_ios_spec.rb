require 'spec_helper'

module Puppet::Provider::IosAaaAuthorization; end
require 'puppet/provider/ios_aaa_authorization/cisco_ios'

RSpec.describe Puppet::Provider::IosAaaAuthorization::CiscoIos do
  def self.load_test_data
    PuppetX::CiscoIOS::Utility.load_yaml(File.expand_path(__dir__) + '/test_data.yaml', false)
  end

  it_behaves_like 'resources parsed from cli'
  it_behaves_like 'commands created from instance'
end
