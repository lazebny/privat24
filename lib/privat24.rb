module Privat24
  PRIVAT_24_URL = 'https://api.privatbank.ua/p24api/ishop'

  @default_options = {}
  class << self; attr_accessor :default_option; end
end
