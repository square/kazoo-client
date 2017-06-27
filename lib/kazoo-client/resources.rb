module Kazoo
  class Client
    def get_resources
      get_request('resources')
    end

    def get_resource(id)
      get_request("resources/#{id}")
    end

    def add_resource(data)
      put_request('resources', data)
    end

    def update_resource(id, data)
      post_request("resources/#{id}", data)
    end

    def delete_resource(id)
      delete_request("resources/#{id}")
    end
  end
end
