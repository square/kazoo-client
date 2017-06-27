module Kazoo
  class Client
    def get_temporal_rules
      get_request('temporal_rules')
    end

    def get_temporal_rule(id)
      get_request("temporal_rules/#{id}")
    end

    def add_temporal_rule(data)
      put_request('temporal_rules', data)
    end

    def update_temporal_rule(id, data)
      post_request("temporal_rules/#{id}", data)
    end

    def delete_temporal_rule(id)
      delete_request("temporal_rules/#{id}")
    end
  end
end
