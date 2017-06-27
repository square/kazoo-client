module Kazoo
  class Client
    def get_phone_numbers
      get_request('phone_numbers')
    end

    def update_phone_number(id, data)
      post_request("phone_numbers/#{id}", data)
    end

    def delete_phone_number(id)
      delete_request("phone_numbers/#{id}")
    end
  end
end
