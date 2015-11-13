class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :now

  def now
    @time = Time.now
  end

  private

    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

  # whitelistがtrueの時だけ実行します。
  # before_action :now, if: :whitelist
  # def whitelist
  #   %w{store products}.include?(controller_name)
  # end

end
