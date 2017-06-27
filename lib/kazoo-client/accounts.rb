module Kazoo
  class Client
    def get_account(id)
      get_request("accounts/#{id}")
    end

    def update_account(id, data)
      post_request("accounts/#{id}", data)
    end

    def get_account_children(id)
      get_request("accounts/#{id}/children")
    end

    def get_account_descendants(id)
      get_request("accounts/#{id}/descendants")
    end

    def get_account_siblings(id)
      get_request("accounts/#{id}/siblings")
    end
  end
end
