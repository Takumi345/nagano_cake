class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name

    if @address_number = Address.find(params[:order][:address_number]) == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    if @address_number = Address.find(params[:order][:address_number]) == "1"
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    if @address_number = Address.find(params[:order][:address_number]) == "2"
      @order.postal_code = @order.new
      @order.address = @order.new
      @order.name = @order.new

  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to public_orders_confirm(@order.id)
  end

  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(:payment_method,:postal_code, :address, :name, :customer_id)
  end
end