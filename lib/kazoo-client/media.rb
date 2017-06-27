module Kazoo
  class Client
    def get_medias
      get_request('media')
    end

    def get_media(id)
      get_request("media/#{id}")
    end

    def add_media(data)
      put_request('media', data)
    end

    def update_media(id, data)
      post_request("media/#{id}", data)
    end

    def delete_media(id)
      delete_request("media/#{id}")
    end

    def get_languages
      get_request('media/languages')
    end

    def get_languages_missing
      get_request('media/languages/missing')
    end
  end
end
