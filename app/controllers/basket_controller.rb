class BasketController < ApplicationController
  before_action :set_basket, only: [:index, :add_to_basket, :destroy]
  before_action :check_for_basket_limit, only: [:add_to_basket]
  after_action :set_total_price, only: [:add_to_basket, :destroy]
  after_action :add_free_delivery, only: [:add_to_basket, :destroy]

  def index
    @items = @basket.basket_items

  end

  def add_to_basket
    item = Item.find(params[:item_id])
    @basket_item = @basket.basket_items.new(item_id: params[:item_id])
    if @basket_item.save
      redirect_to basket_index_path
    else
      redirect_to items_path
      flash[:errors] = 'Basket item was successfully created.'
    end
    # basket.add_item(item)
  end

  def destroy
    basket_item = BasketItem.find(params[:id])
    if basket_item.destroy
      redirect_to basket_index_path
    end
  end



  private

    def set_basket
      @basket = Basket.find(session[:basket_id])
    rescue ActiveRecord::RecordNotFound
      @basket = Basket.create
      session[:basket_id] = @basket.id
    end

    def set_total_price
      total = 0
      items = @basket.basket_items
      items.each do |basket_item|
        total += basket_item.item.price
      end
      session[:basket_total] = total
    end

    def add_free_delivery
      total = session[:basket_total].to_i
      if total >= 3000
        flash[:alert] = 'Бесплатная доставка'
      else
        session[:basket_total].to_i += 300
      end
    end

    def check_for_basket_limit
      if @basket.basket_items.count >= 10
        redirect_to items_path
        # binding.pry
        # basket.error_messages.add("Слишком много товаров в корзине")
      end
    end


    def basket_item_params
      params.require(:basket).permit(:item_id)
    end
end

