require 'spec_helper'

module Puppet::Provider::IosNetworkDns; end
require 'puppet/provider/ios_network_dns/cisco_ios'

RSpec.describe Puppet::Provider::IosNetworkDns::CiscoIos do
  let(:provider) { described_class.new }

  def self.load_test_data
    PuppetX::CiscoIOS::Utility.load_yaml(File.expand_path(__dir__) + '/test_data.yaml', false)
  end

  it_behaves_like 'resources parsed from cli'

  context 'Update tests:' do
    load_test_data['default']['update_tests'].each do |test_name, test|
      it test_name.to_s do
        expect(described_class.commands_from_is_should(test['is'], test['should'])).to eq test['cli']
      end
    end
  end

  describe '#canonicalize' do
    it { expect(provider.canonicalize(anything, [{ name: 'foo', servers: ['2.2.2.2', '1.1.1.1'] }])).to eq [{ name: 'foo', servers: ['1.1.1.1', '2.2.2.2'] }] }
  end
end
