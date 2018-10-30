require 'pry'
def items
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]
end

def consolidate_cart(cart)
  new_hash = {}

    cart.each do |hashes|
      hashes.each do |food, data|
        new_hash[food] = data.merge({:count => cart.count(hashes)})  
    end
  end
  new_hash
end


=begin
def apply_coupons(cart, coupons)
  coupons.each do |hashes|
  hashes.each do |attributes, specifics|
  
  cart.each do |food, data|
    data.each do |key, value|
      if data[:count] == hashes[:num]
         cart.merge({"#{food} W/COUPON" => {:price => hashes[:cost], :clearance => data[:clearance], :count => 1}})
         binding.pry

          end
        end
      end
    end
  end
  return cart
end
=end

def apply_coupons(cart, coupons)
  coupons_applied = {}
  coupons.each do |coupon|
    if cart.key?(coupon[:item])
      coupon_count = 0
      until coupon[:num] > cart[coupon[:item]][:count]
        cart[coupon[:item]][:count] -= coupon[:num]
        cart["#{coupon[:item]} W/COUPON"] = {price: coupon[:cost], clearance: cart[coupon[:item]][:clearance], count: coupon_count += 1}
      end
    end
  end
  cart.merge(coupons_applied)
end	





def apply_clearance(cart)
  cart.map do |keys, values|
    if values[:clearance] == true

     new_price = values[:price] *0.8
      values[:price] = new_price.round(2)
    end
  end
  cart
end




def checkout(cart, coupons)
	  cart = consolidate_cart(cart: cart)
	  cart = apply_coupons(cart: cart, coupons: coupons)
  cart = apply_clearance(cart: cart)
  result = 0
  cart.each do |food, info|
    result += (info[:price] * info[:count]).to_f
  end
  result > 100 ? result * 0.9 : result
end
