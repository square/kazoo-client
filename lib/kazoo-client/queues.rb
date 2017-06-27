module Kazoo
  class Client
    def get_queues
      get_request('queues')
    end

    def get_queue(id)
      get_request("queues/#{id}")
    end

    def add_queue(data)
      put_request('queues', data)
    end

    def update_queue(id, data)
      post_request("queues/#{id}", data)
    end

    def delete_queue(id)
      delete_request("queues/#{id}")
    end
  end
end
