module Kazoo
  class Client
    attr_reader :base_url, :version, :username, :realm, :account_id, :auth_token

    def initialize(base_url, version, username, password, realm)
      @base_url = base_url
      @username = username
      @password = password
      @realm = realm
      @version = version

      unless authenticated?
        authenticate
      end
    end

    def authenticated?
      !@auth_token.nil?
    end

    def authenticate
      credentials = Digest::MD5.hexdigest "#{@username}:#{@password}"
      auth_hash = {
        data: {
          credentials: credentials,
          account_name: @realm
        },
        verb: 'PUT'
      }
      response = HTTP.headers(content_type: 'application/json', accept: 'application/json')
                     .put("#{@base_url}/#{@version}/user_auth", json: auth_hash)
      result = JSON.parse(response.body)
      case response.code
      when (200..299)
        @account_id = result['data']['account_id']
        @auth_token = result['auth_token']
        @base_header = {
          content_type: 'application/json',
          accept: 'application/json',
          X_Auth_Token: @auth_token
        }
        return result['data']
      else
        raise AuthError, "Authentication error: #{response.status}"
      end
    end

    def get_request(url)
      response = HTTP.headers(@base_header)
                     .get("#{@base_url}/#{@version}/accounts/#{@account_id}/#{url}")
      result = JSON.parse(response.body)
      case response.code
      when (200..299)
        return result['data']
      else
        raise GetError, "Get error: #{response.status} #{result['data']}"
      end
    end

    def put_request(url, data)
      response = HTTP.headers(@base_header)
                     .put("#{@base_url}/#{@version}/accounts/#{@account_id}/#{url}", json: data)
      result = JSON.parse(response.body)
      case response.code
      when (200..299)
        return result['data']
      else
        raise PutError, "Put error: #{response.status} #{result['data']}"
      end
    end

    def post_request(url, data)
      response = HTTP.headers(@base_header)
                     .post("#{@base_url}/#{@version}/accounts/#{@account_id}/#{url}", json: data)
      result = JSON.parse(response.body)
      case response.code
      when (200..299)
        return result['data']
      else
        raise PostError, "Post error: #{response.status} #{result['data']}"
      end
    end

    def delete_request(url)
      response = HTTP.headers(@base_header)
                     .delete("#{@base_url}/#{@version}/accounts/#{@account_id}/#{url}")
      result = JSON.parse(response.body)
      case response.code
      when (200..299)
        return result['data']
      else
        raise DeleteError, "Delete error: #{response.status} #{result['data']}"
      end
    end
  end
end
