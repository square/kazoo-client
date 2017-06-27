module Kazoo
  class Client
    def get_servers
      get_request('servers')
    end

    def get_deployment(id)
      get_request("servers/#{id}/deployment")
    end

    def add_deployment(data)
      put_request("servers/#{id}/deployment", data)
    end

    def get_logs(id)
      get_request("servers/#{id}/log")
    end
  end
end
