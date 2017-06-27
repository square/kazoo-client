require 'spec_helper'

describe Kazoo::Client do
  let(:base_url) { 'https://www.example.com' }
  let(:version) { 'v2' }

  describe 'user' do
    before do
      stub_request(:put, "#{base_url}/#{version}/user_auth")
        .with(body: '{"data":{"credentials":"43df4ac61977dbd124e42996ade0ddc5","account_name":"fake_realm"},"verb":"PUT"}',
              headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
        .to_return(status: 200, body: fixture('initialize_auth_success_return_body.json'))

      @session = Kazoo::Client.new(base_url, version, 'fake_user', 'fake_password', 'fake_realm')
    end

    context 'when get_users is successful' do
      before do
        stub_request(:get, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/users")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('users_get_users_success_return_body.json'))
      end

      it 'get_users returns an array of users' do
        expect(@session.get_users).to be_instance_of(Array)
      end

      it 'get_users returns an array with two elements' do
        expect(@session.get_users.count).to equal(2)
      end
    end

    context 'when add_user is successful' do
      before do
        stub_request(:put, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/users")
          .with(body: '{"data":{"first_name":"George","last_name":"Test","username":"georgetest","vm_to_email_enabled":true},"verb":"PUT"}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 201, body: fixture('users_add_user_success_return_body.json'))
      end

      it 'add_user is not nil' do
        user = {
          data: {
            first_name: 'George',
            last_name: 'Test',
            username: 'georgetest',
            vm_to_email_enabled: true
          },
          verb: 'PUT'
        }
        expect(@session.add_user(user)).not_to be nil
      end
    end

    context 'when add_user fails with a duplicate username' do
      before do
        stub_request(:put, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/users")
          .with(body: '{"data":{"first_name":"George","last_name":"Test","username":"georgetest","vm_to_email_enabled":true},"verb":"PUT"}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 500, body: fixture('users_add_user_fail_username_return_body.json'))
      end

      it 'raises exception on add_user with duplicate username' do
        user = {
          data: {
            first_name: 'George',
            last_name: 'Test',
            username: 'georgetest',
            vm_to_email_enabled: true
          },
          verb: 'PUT'
        }
        expect { @session.add_user(user) }.to raise_error(Kazoo::Client::PutError)
      end
    end

    context 'when get_user is successful' do
      before do
        stub_request(:get, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/users/ef01fc2b7339244ba83f597ed4c530f3")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('users_get_user_success_return_body.json'))
      end

      it 'get_user is not nil' do
        expect(@session.get_user('ef01fc2b7339244ba83f597ed4c530f3')).not_to be nil
      end
    end

    context 'when get_user fails' do
      before do
        stub_request(:get, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/users/ef01fc2b7339244ba83f597ed4c530f3")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 404, body: fixture('users_get_user_fail_return_body.json'))
      end

      it 'raises exception on get_user with bad user id' do
        expect { @session.get_user('ef01fc2b7339244ba83f597ed4c530f3') }.to raise_error(Kazoo::Client::GetError)
      end
    end

    context 'when update_user is successful' do
      before do
        stub_request(:post, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/users/ef01fc2b7339244ba83f597ed4c530f3")
          .with(body: '{"data":{"first_name":"George","last_name":"Test 2","username":"georgetest","vm_to_email_enabled":true}}',
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('users_update_user_success_return_body.json'))
      end

      it 'update_user is not nil' do
        user = {
          data: {
            first_name: 'George',
            last_name: 'Test 2',
            username: 'georgetest',
            vm_to_email_enabled: true
          }
        }
        expect(@session.update_user('ef01fc2b7339244ba83f597ed4c530f3', user)).not_to be nil
      end
    end

    context 'when delete_user is successful' do
      before do
        stub_request(:delete, "#{base_url}/#{version}/accounts/dc8f476b3b064171183d82919bad1a4b/users/ef01fc2b7339244ba83f597ed4c530f3")
          .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'f348ab6783801841f2e4f3ecde8fa109' })
          .to_return(status: 200, body: fixture('users_delete_user_success_return_body.json'))
      end

      it 'delete_user is not nil' do
        expect(@session.delete_user('ef01fc2b7339244ba83f597ed4c530f3')).not_to be nil
      end
    end
  end
end
