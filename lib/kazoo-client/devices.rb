module Kazoo
  class Client
    def get_devices
      get_request('devices')
    end

    def get_device(id)
      get_request("devices/#{id}")
    end

    def add_device(data)
      put_request('devices', data)
    end

    def update_device(id, data)
      post_request("devices/#{id}", data)
    end

    def delete_device(id)
      delete_request("devices/#{id}")
    end

    def get_devices_status
      get_request('devices/status')
    end

    def sync_device(id)
      data = { data: {}, verb: 'POST' }
      if @version == 'v2'
        post_request("devices/#{id}/sync", data)
      else
        raise VersionError, 'sync_device is not implemented for v1 api'
      end
    end
  end
end
