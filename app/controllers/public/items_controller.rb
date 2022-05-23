class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

  def correct_costomer
    @item = Item.find(params[:id])
    @customer = @item.customer
    redirect_to(public_items_path) unless @customer== current_customer
  end

end
