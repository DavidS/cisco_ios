require 'spec_helper'
describe 'the ios_snmp_global type' do
  it 'loads' do
    expect(Puppet::Type.type(:ios_snmp_global)).not_to be_nil
  end
end
