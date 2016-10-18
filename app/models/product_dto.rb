class Product_dto 
  include ActiveModel::Model
  
  attr_accessor :shop,:category,:item,:name,:price,:calorie,:net,:protein,:fat,:carbon,:sugar,:fiber,:sodium
  
  def initialize(shop,category,item,name,price,calorie,net,protein,fat,carbon,sugar,fiber,sodium)
    @shop=shop
    @category=category
    @item=item
    @name=name
    @price=price
    @calorie=calorie
    @net=net
    @protein=protein
    @fat=fat
    @carbon=carbon
    @sugar=sugar
    @fiber=fiber
    @sodium=sodium
  end
end
