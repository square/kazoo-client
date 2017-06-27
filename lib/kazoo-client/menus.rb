module Kazoo
  class Client
    def get_menus
      get_request('menus')
    end

    def get_menu(id)
      get_request("menus/#{id}")
    end

    def add_menu(data)
      put_request('menus', data)
    end

    def update_menu(id, data)
      post_request("menus/#{id}", data)
    end

    def delete_menu(id)
      delete_request("menus/#{id}")
    end
  end
end
