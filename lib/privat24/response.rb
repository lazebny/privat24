require 'base64'
require 'privat24/base_operation'

module Privat24
  class Response < BaseOperation
    SUCCESS_STATUSES = %w(ok wait test)

    attr_reader :payment

    def initialize(options = {})
      super(options)

      @payment = options['payment']
      @request_signature = options['signature']

      decode!
    end

    def signature_fields
      [@payment]
    end

    # Returns true, if the transaction was successful
    def success?
      SUCCESS_STATUSES.include? self.state
    end

  private
    def decode!
      # p 'signature=' + signature
      # p 'request_signature=' + @request_signature
      if signature != @request_signature
        raise Privat24::InvalidResponse
      end
    end
  end
end
