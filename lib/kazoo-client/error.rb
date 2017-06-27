module Kazoo
  class Client
    # Generic error
    class Error < StandardError; end

    # Authentication error
    class AuthError < Error; end

    # Get error
    class GetError < Error; end

    # Put error
    class PutError < Error; end

    # Post error
    class PostError < Error; end

    # Delete error
    class DeleteError < Error; end

    # Version error
    class VersionError < Error; end
  end
end
