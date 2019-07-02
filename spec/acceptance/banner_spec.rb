require 'spec_helper_acceptance'

describe 'banner' do
  it 'edit banner' do
    pp = <<-EOS
    banner { "default":
      motd => 'meow',
    }
    EOS
    make_site_pp(pp)
    run_device(allow_changes: true)
    # Are we idempotent
    run_device(allow_changes: false)
    # Check puppet resource
    result = run_resource('banner', 'default')
    expect(result).to match(%r{default.*})
    expect(result).to match(%r{motd.*meow})
  end
  it 'unset banner' do
    pp = <<-EOS
    banner { "default":
      motd => 'unset',
    }
    EOS
    make_site_pp(pp)
    run_device(allow_changes: true)
    # Are we idempotent
    run_device(allow_changes: false)
    # Check puppet resource
    result = run_resource('banner', 'default')
    expect(result).to match(%r{default.*})
    expect(result).to match(%r{motd.*unset})
  end
end
