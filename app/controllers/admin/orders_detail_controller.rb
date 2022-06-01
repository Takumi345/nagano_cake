class Admin::OrdersDetailController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)

    if @order.order_details.where(making_status: "completed_production").count == @order.order_details.count
      @order.update(status: "shipping_preparation")
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
