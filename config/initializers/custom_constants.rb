EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/.freeze

def hexdigest(text)
  Digest::MD5.hexdigest(text)
end

class InvalidParams < StandardError; end

class Unauthorized < StandardError; end
