module Kazoo
  class Client
    def get_vmboxes
      get_request('vmboxes')
    end

    def get_vmbox(id)
      get_request("vmboxes/#{id}")
    end

    def add_vmbox(data)
      put_request('vmboxes', data)
    end

    def update_vmbox(id, data)
      post_request("vmboxes/#{id}", data)
    end

    def delete_vmbox(id)
      delete_request("vmboxes/#{id}")
    end
  end
end
