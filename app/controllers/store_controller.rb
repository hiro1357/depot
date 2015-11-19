class StoreController < ApplicationController

  def index
    @products = Product.order(:title)

    puts "------------------"
    puts session[:counter]
    puts "------------------"

    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter]+=1
    end

    if session[:counter] < 5
    else
    @countup = "アクセスは#{session[:counter]}回目です。"
    end

    @cart = current_cart
  end
end