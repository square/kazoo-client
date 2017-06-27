module Kazoo
  class Client
    def get_callflows
      get_request('callflows')
    end

    def get_callflow(id)
      get_request("callflows/#{id}")
    end

    def add_callflow(data)
      put_request('callflows', data)
    end

    def update_callflow(id, data)
      post_request("callflows/#{id}", data)
    end

    def delete_callflow(id)
      delete_request("callflows/#{id}")
    end
  end
end
