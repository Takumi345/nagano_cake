class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @address = Address.find(params[:order][:address_id])
    @address_number = params[:order][:address_number]
    if @address_number == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

    elsif @address_number == "1"
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
    @order_detail = OrderDetail.new
    @order_detail.order_id = @order.id
    @order_detail.item_id = cart_item.item_id
    @order_detail.price = cart_item.item.price
    @order_detail.amount = cart_item.amount
    @order_detail.making_status = 0
    @order_detail.save
    end
    redirect_to public_orders_complete_path
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end


  private

  def order_params
    params.require(:order).permit(:payment_method,:postal_code, :address, :name, :customer_id, :shipping_cost, :total_payment, :status)
  end
end
