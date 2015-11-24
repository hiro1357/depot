class StoreController < ApplicationController
  skip_before_action :authorize

  def index
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    else
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
end