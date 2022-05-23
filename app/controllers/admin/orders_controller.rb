class Admin::OrdersController < ApplicationController
  def show
    @oders = order.all
  end

  def update
  end
end
