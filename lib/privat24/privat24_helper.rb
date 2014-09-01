module Privat24
  module Privat24Helper
    # Displays a form to send a payment request to Privat24
    #
    # You can either pass in a block, that SHOULD render a submit button (or not, if you plan to submit the form otherwise), or
    # let the helper create a simple submit button for you.
    #
    # privat24_request - an instance of Privat24::Request
    # options - currently accepts two options
    #   id - the ID of the form being created (`privat24_form` by default)
    #   title - text on the submit button (`Pay with Privat24` by default); not used if you pass in a block
    def privat24_button(privat24_request, options={}, &block)
      id = options.fetch(:id, 'privat24_form')
      title = options.fetch(:title, 'Pay with Privat24')
      content_tag(:form, id: id, action: ::Privat24::PRIVAT24_URL, method: :post) do
        result = privat24_request.form_fields.map{|name, value|
          hidden_field_tag(name, value)
        }.join("\n").html_safe

        if block_given?
          result += yield
        else
          result += submit_tag(title, :name => nil)
        end
        result
      end
    end
  end
end
