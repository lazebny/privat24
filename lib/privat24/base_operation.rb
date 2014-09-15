require 'digest/sha1'
require 'base64'

module Privat24
  class BaseOperation
    attr_accessor :merchant, :password

    def initialize(options={})
      options.select!{ |key, val| val }
      options.replace Privat24.default_options.merge(options)

      @merchant = options[:merchant]
      @password = options[:password]
    end

    def signature
      @signature ||= sign(signature_fields)
      @signature
    end

    def signature_fields
      raise 'Implement this method'
    end

  private
    def sign(fields)
      _sign = Digest::SHA1.hexdigest(Digest::MD5.hexdigest(fields.join('&') + @password))
      _sign
    end
  end
end
