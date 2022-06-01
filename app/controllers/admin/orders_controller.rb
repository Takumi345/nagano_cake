class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    if @order.payment_confirmation?
      puts "hello"
      @order_details.each do |order_detail|
      order_detail.awaiting_manufacture!
      end
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :created_at, :postal_code, :address, :name, :payment_method, :status,:shipping_cost)
  end

end
