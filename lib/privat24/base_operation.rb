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
    end

    def signature_fields
      [
        'amt=' + amt.to_f.to_s,
        'ccy=' + ccy.to_s,
        'details=' + details,
        'ext_details=' + details,
        'pay_way=' + pay_way,
        'order=' + order,
        'merchant=' + merchant,
      ]
    end

    def pay_way
      'privat24'
    end

  private
    def sign(fields)
      _sign = Digest::SHA1.hexdigest(Digest::MD5.hexdigest(fields.join('&') + @password))
      _sign
    end
  end
end
