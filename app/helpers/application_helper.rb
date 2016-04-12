module ApplicationHelper

  def something(a,b,c,d,e,f,g,h)
   @badCodeSmells = 1
   #We automatically generated one or more configuration files for this repo. You can download this configuration to customize it

   a = [
[1,2,3]
]
  end

def sort
prepared_items = @cart.prepare_sort
    errors = []
    orders = []

    ActiveRecord::Base.transaction do
      address_create = create_new_address address_params if order_params[:address_attributes].present?

      prepared_items.each do |type, items|
        next unless items.present?

        user = current_user.class.name == 'User' ? { user_id: current_user.id } : { user_id: nil }

        case type
          when :order    then @order = Order.new(order_params.merge(user))
          when :preorder then @order = Order.new(order_params.merge(user.merge(status: 'preorder')))
          when :b_y      then @order = Order.new(order_params.merge(user.merge(delivery: 'pick_up', store_id: Settings.store.for_by)))
        end

        @order.is_mobile = mobile_device?
        @order.promo_code = @cart.promo_code
        @order.promotion = Promotion.for_line_items(@cart)

        good_promotion = Promotion.good_promotion_with_bonus(@cart)
        if good_promotion && @cart.used_promotion_discount > 0
          @order.bonus_promotion = good_promotion.promotion
          @order.stored_bonus_promotion_discount = @cart.used_promotion_discount
        end

        items.each{ |item| @order.add_line_item item }
        address_create.orders << @order if address_create.present?

        if @order.save
          orders << @order
        else
          errors += @order.errors.full_messages
        end
      # Are you fucking serious?
      end if errors.empty?

end
end
