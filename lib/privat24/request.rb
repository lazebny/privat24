require 'base64'
require 'privat24/base_operation'

module Privat24
  class Request < BaseOperation
    # REQUIRED Amount of payment (Float), in :currency
    attr_accessor :amt
    # REQUIRED Currency of payment - one of `Privat24::SUPPORTED_CURRENCIES`
    attr_accessor :ccy
    # REQUIRED Description to be displayed to the user
    attr_accessor :details
    attr_accessor :ext_details
    # RECOMMENDED Arbitrary but unique ID (May be REQUIRED by Privat24 configuration)
    attr_accessor :order
    # RECOMMENDED URL that the user will be redirected to after payment
    attr_accessor :return_url
    # RECOMMENDED URL that'll receive the order details in the background.
    attr_accessor :server_url

    def initialize(options={})
      super(options)

      @amt = options[:amt]
      @ccy = options[:ccy] #|| default_options[:ccy]
      @details = options[:details]
      @ext_details = options[:ext_details]
      @order = options[:order]
      @return_url = options[:return_url]
      @server_url = options[:server_url]
      @kamikaze = options[:kamikaze]
    end


    def form_fields
      validate! unless @kamikaze
      fields =
        {
          merchant: merchant,
          amt: amt,
          ccy: ccy,
          details: details,
          ext_details: ext_details,
          order: order,
          return_url: return_url,
          server_url: server_url,
          # signature: signature,
          pay_way: pay_way
        }.select{ |k,v| v }
      p fields
      fields
    end

  private

    def pay_way
      'privat24'
    end

    def signature_fields
      fields_ = [
        'amt=' + amt.to_s,
        'ccy=' + ccy.to_s,
        'details=' + details,
        'ext_details=' + details,
        'pay_way=' + pay_way,
        'order=' + order,
        'merchant=' + merchant,
      ]
      fields_
    end

    def validate!
      %w(merchant password amt ccy details).each do |required_field|
        raise Privat24::Exception.new(required_field + ' is a required field') unless self.send(required_field).to_s != ''
      end

      raise Privat24::Exception.new('currency must be one of '+Privat24::SUPPORTED_CURRENCIES.join(', ')) unless Privat24::SUPPORTED_CURRENCIES.include?(ccy)

      begin
        self.amt = Float(self.amt)
      rescue ArgumentError, TypeError
        raise Privat24::Exception.new('amount must be a number')
      end

      raise Privat24::Exception.new('amount must be rounded to 2 decimal digits') unless self.amt.round(2) == self.amt

      raise Privat24::Exception.new('amount must be more than 0.01') unless amt > 0.01
    end
  end
end
