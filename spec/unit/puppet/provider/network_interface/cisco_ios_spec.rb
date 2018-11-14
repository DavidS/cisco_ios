require 'spec_helper'

module Puppet::Provider::NetworkInterface; end
require 'puppet/provider/network_interface/cisco_ios'
require 'puppet_x/puppetlabs/cisco_ios/utility'

RSpec.describe Puppet::Provider::NetworkInterface::CiscoIos do
  def self.load_test_data
    PuppetX::CiscoIOS::Utility.load_yaml(File.expand_path(__dir__) + '/test_data.yaml', false)
  end
  it_behaves_like 'resources parsed from cli'
  it_behaves_like 'commands created from instance'

  context 'Table tests:' do
    load_test_data['default']['read_table_tests'].each do |test_name, test|
      it test_name.to_s do
        expect(PuppetX::CiscoIOS::Utility.read_table(test['status_output']).first).to eq test['instance']
      end
    end
  end

  context 'Get value from table tests:' do
    load_test_data['default']['read_table_tests'].each do |test_name, test|
      it test_name.to_s do
        expect(PuppetX::CiscoIOS::Utility.get_speed_value_from_table_data([test['instance']], 'Speed')).to eq test['value_auto_speed']
        expect(PuppetX::CiscoIOS::Utility.get_speed_value_from_table_data([test['instance']], 'Speed', false)).to eq test['value_no_auto']
      end
    end
  end

  context 'Canonicalize tests:' do
    interface = described_class.new
    load_test_data['default']['canonicalize_tests'].each do |test_name, test|
      it test_name.to_s do
        fake_device(test['device'])
        expect(interface.canonicalize(nil, [test['instance']])).to eq [test['returned']]
      end
    end
  end
end
