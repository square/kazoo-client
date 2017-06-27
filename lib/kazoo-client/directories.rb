module Kazoo
  class Client
    def get_directories
      get_request('directories')
    end

    def get_directory(id)
      get_request("directories/#{id}")
    end

    def add_directory(data)
      put_request('directories', data)
    end

    def update_directory(id, data)
      post_request("directories/#{id}", data)
    end

    def delete_directory(id)
      delete_request("directories/#{id}")
    end
  end
end
