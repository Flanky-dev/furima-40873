class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:edit, :update, :show]
  before_action :check_item_owner, only: [:edit, :update]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def set_item
    @item = Item.find_by(id: params[:id])
    return unless @item.nil?

    redirect_to root_path
  end

  def check_item_owner
    return unless @item.present? && @item.user_id != current_user.id

    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :status_id, :shipping_fee_id, :shipping_day_id,
                                 :prefecture_id, :image).merge(user_id: current_user.id)
  end
end
