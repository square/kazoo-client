module Kazoo
  class Client
    def get_limits
      get_request('limits')
    end
  end
end
