require 'base64'
require 'privat24/base_operation'

module Privat24
  class Response < BaseOperation
    SUCCESS_STATUSES = %w(ok wait test)

    ATTRIBUTES = %w(
      amt
      ccy
      details
      ext_details
      pay_way
      order
      merchant
      state
      date
      ref
    )

    ATTRIBUTES.each { |attr| attr_reader attr }


    def initialize(options = {})
      super(options)

      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", options['payment'][attribute]
      end
      @request_signature = options['signature']

      decode!
    end

    # Returns true, if the transaction was successful
    def success?
      SUCCESS_STATUSES.include? self.state
    end

  private
    def decode!
      if signature != @request_signature
        raise Privat24::InvalidResponse
      end
    end
  end
end
