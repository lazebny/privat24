require 'privat24/privat24_helper'

module Privat24
  class Railtie < Rails::Railtie
    initializer 'private24.view_helpers' do |app|
      ActionView::Base.send :include, Private24::Private24Helper
    end
  end
end
