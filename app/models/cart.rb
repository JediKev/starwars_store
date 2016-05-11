class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def subtotal
		# SQL Version of summing, faster than Ruby
		line_items.select("SUM(quantity * price) AS sum")[0].sum
		
		# Ruby Version of summing 
		#line_items.to_a.sum{ |item| item.total }
	end

	def add_product(product_id)
		product = Product.find(product_id)
		
		# Find out if the item is already in cart. If it doesn't exist its value is nil.
		current_item = line_items.find_by(product_id: product_id)

		# If current item does exist, increase quantity. If not, build new line item.
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product: product, price: product.price)
		end
		current_item
	end

end
