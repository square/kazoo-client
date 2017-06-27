module Kazoo
  class Client
    def get_conferences
      get_request('conferences')
    end

    def get_conference(id)
      get_request("conferences/#{id}")
    end

    def add_conference(data)
      put_request('conferences', data)
    end

    def update_conference(id, data)
      post_request("conferences/#{id}", data)
    end

    def delete_conference(id)
      delete_request("conferences/#{id}")
    end
  end
end
