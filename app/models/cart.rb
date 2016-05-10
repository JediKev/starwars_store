class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def destroy
		if @cart.destroy
			session[:cart_id] = nil
			flash[:notice] = "Cart was successfully deleted."
			redirect_to shop_path
		else
			flash.now[:alert] = "Could not delete cart."
			redirect_to edit_cart_path
		end
	end

	def subtotal
		# SQL Version of summing, faster than Ruby
		line_items.select("SUM(quantity * price) AS sum")[0].sum
		
		# Ruby Version of summing 
		#line_items.to_a.sum{ |item| item.total }
	end
end
