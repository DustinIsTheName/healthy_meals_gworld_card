class CustomerController < ApplicationController

	skip_before_filter :verify_authenticity_token
	before_filter :set_headers

	def save
		puts Colorize.magenta(params)

		shopify_customer = ManageTags.setTags(params)

		render json: shopify_customer
	end

	def get
		shopify_customer = ShopifyAPI::Customer.find(params["customer_id"])

		if shopify_customer
			render json: shopify_customer
		else
			render json: {error: "No such user; check the submitted email address"}, status: 404
		end
	end

	private

		def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
    end

end