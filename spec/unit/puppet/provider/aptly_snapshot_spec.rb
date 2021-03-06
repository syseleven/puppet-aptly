require 'spec_helper'
require 'puppet/type/aptly_snapshot'

describe Puppet::Type.type(:aptly_snapshot).provider(:cli) do
  let(:resource) do
    Puppet::Type.type(:aptly_snapshot).new(
      name: '2016-07-30-daily',
      ensure: 'present',
      source_type: 'repository',
      source_name: 'test'
    )
  end

  let(:provider) do
    described_class.new(resource)
  end

  [:create, :destroy, :exists?].each do |method|
    it "have a(n) #{method}" do
      expect(provider).to respond_to(method)
    end
  end

  describe '#create' do
    it 'create the snapshot' do
      Puppet_X::Aptly::Cli.expects(:execute).with(
        uid: '450',
        gid: '450',
        object: :snapshot,
        action: 'create',
        arguments: ['2016-07-30-daily', 'from repo', 'test'],
        flags: { 'config' => '/etc/aptly.conf' }
      )
      provider.create
    end
  end

  describe '#destroy' do
    it 'drop the snapshot' do
      Puppet_X::Aptly::Cli.expects(:execute).with(
        uid: '450',
        gid: '450',
        object: :snapshot,
        action: 'drop',
        arguments: ['2016-07-30-daily'],
        flags: { 'config' => '/etc/aptly.conf' }
      )
      provider.destroy
    end
  end

  describe '#exists?' do
    it 'check the snapshot list' do
      Puppet_X::Aptly::Cli.stubs(:execute).with(
        uid: '450',
        gid: '450',
        object: :snapshot,
        action: 'list',
        flags: { 'raw' => 'true', 'config' => '/etc/aptly.conf' },
        exceptions: false
      ).returns "foo\n2016-07-30-daily\nbar"
      expect(provider.exists?).to eq(true)
    end
    it 'handle without snapshot' do
      Puppet_X::Aptly::Cli.stubs(:execute).with(
        uid: '450',
        gid: '450',
        object: :snapshot,
        action: 'list',
        flags: { 'raw' => 'true', 'config' => '/etc/aptly.conf' },
        exceptions: false
      ).returns ''
      expect(provider.exists?).to eq(false)
    end
  end
end
