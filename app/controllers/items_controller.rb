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
    # 商品情報はset_itemで取得済み
  end

  def edit
    # 商品情報はset_itemで取得済み
  end

  def update
    # 商品情報はset_itemで取得済み
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報が更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # 商品の取得
  def set_item
    @item = Item.find_by(id: params[:id])
    redirect_to root_path, alert: '商品が見つかりません' if @item.nil?
  end

  # 出品者確認
  def check_item_owner
    redirect_to root_path, alert: '編集権限がありません' if @item.user_id != current_user.id
  end

  # Strong Parameters
  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :status_id, :shipping_fee_id, :shipping_day_id,
                                 :prefecture_id, :image).merge(user_id: current_user.id)
  end
end
