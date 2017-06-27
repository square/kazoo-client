module Kazoo
  class Client
    def get_users
      get_request('users')
    end

    def get_user(id)
      get_request("users/#{id}")
    end

    def add_user(data)
      put_request('users', data)
    end

    def update_user(id, data)
      post_request("users/#{id}", data)
    end

    def delete_user(id)
      delete_request("users/#{id}")
    end

    def get_hotdesk
      get_request('users/hotdesk')
    end
  end
end
