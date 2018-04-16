module ManageTags
	def self.setTags(params)

		shopify_customer = ShopifyAPI::Customer.find(params["customer_id"])

		unless shopify_customer
			shopify_customer = ShopifyAPI::Customer.new
			shopify_customer.email = params["email"]
			shopify_customer.tags = '';
		end

		old_tags = shopify_customer.tags

		if params["name"]
			shopify_customer.tags = shopify_customer.tags.remove_regex(/name:[^,]*(?=,)/)
			shopify_customer.tags = shopify_customer.tags.add_tag('name:'+params["name"])
		end

		if params["number"]
			shopify_customer.tags = shopify_customer.tags.remove_regex(/number:[^,]*(?=,)/)
			shopify_customer.tags = shopify_customer.tags.add_tag('number:'+params["number"])
		end

		if params["expiration"]
			shopify_customer.tags = shopify_customer.tags.remove_regex(/expiration:[^,]*(?=,)/)
			shopify_customer.tags = shopify_customer.tags.add_tag('expiration:'+params["expiration"])
		end

		puts Colorize.orange(old_tags)
		puts Colorize.magenta(shopify_customer.tags)

		if old_tags == shopify_customer.tags
			puts Colorize.cyan('tags are the same');
		else
			if shopify_customer.save
				print Colorize.green('saved customer tags')
				puts Colorize.orange(' ' << ShopifyAPI.credit_left.to_s)
			else
				puts Colorize.red('error saving tags')
			end
		end

		return shopify_customer
	end
end