require 'spec_helper'

describe Kazoo::Client do
  let(:base_url) { 'https://www.example.com' }
  let(:version) { 'v2' }

  it 'has a version number' do
    expect(Kazoo::Client::VERSION).not_to be nil
  end

  describe 'initialize' do
    context 'when authentication is successful' do
      before do
        stub_request(:put, "#{base_url}/#{version}/user_auth")
          .with(body: '{"data":{"credentials":"43df4ac61977dbd124e42996ade0ddc5","account_name":"fake_realm"},"verb":"PUT"}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
          .to_return(status: 200, body: fixture('initialize_auth_success_return_body.json'))
        @session = Kazoo::Client.new(base_url, version, 'fake_user', 'fake_password', 'fake_realm')
      end

      it '@auth_token is not nil' do
        expect(@session.auth_token).not_to be nil
      end

      it '@base_url is not nil' do
        expect(@session.base_url).not_to be nil
      end

      it '@account_id is not nil' do
        expect(@session.account_id).not_to be nil
      end
    end

    context 'when authentication fails' do
      before do
        stub_request(:put, "#{base_url}/#{version}/user_auth")
          .to_return(status: 401, body: fixture('initialize_auth_fail_return_body.json'))
      end

      it 'raises exception on failed authentication' do
        expect { Kazoo::Client.new(base_url, version, 'fake_user', 'bad_password', 'fake_realm') }.to raise_error(Kazoo::Client::AuthError)
      end
    end
  end
end
