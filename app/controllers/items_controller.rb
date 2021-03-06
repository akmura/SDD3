class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    #口コミ情報の取得
    @item_reviews=ItemReview.where(item_id:@item.id)
    @category = @item.category
  end

  # POST /items/vote
  def vote
    id = params[:item][:id]
    @item = Item.find(id)
    if params[:item][:good] 
      @item.good = @item.good+1
    else
      @item.bad = @item.bad+1
    end
    respond_to do |format|
      if @item.update(good:@item.good,bad:@item.bad)
        format.html { redirect_to @item , notice: '貴方の評価を投稿しました!' }
      else
        format.html { redirect_to @item , error: '投稿に失敗しました' } 
      end
    end
  end

  
  # GET /items/new
  def new
    @item = Item.new
    @shop_hash={"ファミマ"=>"ファミマ","セブン"=>"セブン","ローソン"=>"ローソン"}
    @category_hash={"惣菜"=>"惣菜","おにぎり"=>"おにぎり","スイーツ"=>"スイーツ","ドリンク"=>"ドリンク"}
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new 
    @item.shop = params[:item][:shop]
    @item.category = params[:item][:category]
    @item.name = params[:item][:name]
    @item.price = params[:item][:price]
    @item.item=@item.category
    @item.good=0
    @item.bad=0
    @item.image=''
    @item.status="申請中"

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: '商品の追加に成功しました' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:shop, :category, :item, :name, :price, :good, :bad, :image)
    end
end
