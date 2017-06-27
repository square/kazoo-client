require 'spec_helper'

describe Kazoo::Client do
  let(:base_url) { 'https://www.example.com' }
  let(:version) { 'v2' }

  describe 'device' do
    before do
      stub_request(:put, "#{base_url}/#{version}/user_auth")
        .with(body: '{"data":{"credentials":"43df4ac61977dbd124e42996ade0ddc5","account_name":"fake_realm"},"verb":"PUT"}',
              headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
        .to_return(status: 200, body: fixture('initialize_auth_success_return_body.json'))
      @session = Kazoo::Client.new(base_url, version, 'fake_user', 'fake_password', 'fake_realm')
    end

    context 'when get_devices is successful' do
      before do
        stub_request(:get, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('devices_get_devices_success_return_body.json'))
      end

      it 'get_devices returns an array of devices' do
        expect(@session.get_devices).to be_instance_of(Array)
      end

      it 'get_devices returns an array with two elements' do
        expect(@session.get_devices.count).to equal(2)
      end
    end

    context 'when add_device is successful' do
      before do
        stub_request(:put, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices")
          .with(body: '{"data":{"name":"100","device_type":"sip_device","enabled":true,"mac_address":"de:ad:be:ef:ca:fe"},"verb":"PUT"}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 201, body: fixture('devices_add_device_success_return_body.json'))
      end

      it 'add_device is not nil' do
        device = {
          data: {
            name: '100',
            device_type: 'sip_device',
            enabled: true,
            mac_address: 'de:ad:be:ef:ca:fe'
          },
          verb: 'PUT'
        }
        expect(@session.add_device(device)).not_to be nil
      end
    end

    context 'when add_device fails with a duplicate mac address' do
      before do
        stub_request(:put, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices")
          .with(body: '{"data":{"name":"101","device_type":"sip_device","enabled":true,"mac_address":"de:ad:be:ef:ca:fe"},"verb":"PUT"}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 500, body: fixture('devices_add_device_fail_mac_address_return_body.json'))
      end

      it 'raises exception on add_device with duplicate mac address' do
        device = {
          data: {
            name: '101',
            device_type: 'sip_device',
            enabled: true,
            mac_address: 'de:ad:be:ef:ca:fe'
          },
          verb: 'PUT'
        }
        expect { @session.add_device(device) }.to raise_error(Kazoo::Client::PutError)
      end
    end

    context 'when add_device fails with a duplicate sip username' do
      before do
        stub_request(:put, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices")
          .with(body: '{"data":{"name":"101","device_type":"sip_device","enabled":true,"mac_address":"de:ad:be:ef:be:ea"},"verb":"PUT"}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 500, body: fixture('devices_add_device_fail_sip_username_return_body.json'))
      end

      it 'raises exception on add_device with duplicate sip username' do
        device = {
          data: {
            name: '101',
            device_type: 'sip_device',
            enabled: true,
            mac_address: 'de:ad:be:ef:be:ea'
          },
          verb: 'PUT'
        }
        expect { @session.add_device(device) }.to raise_error(Kazoo::Client::PutError)
      end
    end

    context 'when get_device is successful' do
      before do
        stub_request(:get, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices/e6a9f3c77f47aca12efc50186b953a29")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('devices_get_device_success_return_body.json'))
      end

      it 'get_device is not nil' do
        expect(@session.get_device('e6a9f3c77f47aca12efc50186b953a29')).not_to be nil
      end
    end

    context 'when get_device fails' do
      before do
        stub_request(:get, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices/e6a9f3c77f47aca12efc50186b953a28")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 404, body: fixture('devices_get_device_fail_return_body.json'))
      end

      it 'raises exception on get_device with bad device id' do
        expect { @session.get_device('e6a9f3c77f47aca12efc50186b953a28') }.to raise_error(Kazoo::Client::GetError)
      end
    end

    context 'when update_device is successful' do
      before do
        stub_request(:post, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices/e6a9f3c77f47aca12efc50186b953a29")
          .with(body: '{"data":{"name":"100 Updated","device_type":"sip_device","enabled":true,"mac_address":"de:ad:be:ef:ca:fe"},"verb":"POST"}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('devices_update_device_success_return_body.json'))
      end

      it 'update_device is not nil' do
        device = {
          data: {
            name: '100 Updated',
            device_type: 'sip_device',
            enabled: true,
            mac_address: 'de:ad:be:ef:ca:fe'
          },
          verb: 'POST'
        }
        expect(@session.update_device('e6a9f3c77f47aca12efc50186b953a29', device)).not_to be nil
      end
    end

    context 'when delete_device is successful' do
      before do
        stub_request(:delete, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices/e6a9f3c77f47aca12efc50186b953a29")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('devices_delete_device_success_return_body.json'))
      end

      it 'delete_device is not nil' do
        expect(@session.delete_device('e6a9f3c77f47aca12efc50186b953a29')).not_to be nil
      end
    end

    context 'when sync_device is successful' do
      before do
        stub_request(:post, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices/e6a9f3c77f47aca12efc50186b953a29/sync")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('devices_sync_device_success_return_body.json'))
      end

      it 'sync_device is not nil' do
        expect(@session.sync_device('e6a9f3c77f47aca12efc50186b953a29')).not_to be nil
      end
    end

    context 'when sync_device fails' do
      before do
        stub_request(:post, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/devices/3c6ef581ff8e8f92e1aaf64a0f2d9840/sync")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 404, body: fixture('devices_sync_device_fail_return_body.json'))
      end

      it 'raises exception on sync_device with bad device id' do
        expect { @session.sync_device('3c6ef581ff8e8f92e1aaf64a0f2d9840') }.to raise_error(Kazoo::Client::PostError)
      end
    end
  end
end
