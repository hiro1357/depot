class UserStoriesTest < ActionDispatch::IntegrationTest

 test "buyking a product" do

   LineItem.delete_all #LINEITEMとOrderの中身を削除
  Order.delete_all
  ruby_book =products(:ruby) #購入したい本を変数に

  #下準備ここまで↑

  get "/"  #http://localhost:3000にアクセス
  assert_response :success
  assert_template "index"

  post_via_redirect "/line_items", product_id: ruby_book.id
  assert_response :success
  assert_template "show"

  cart = Cart.find(session[:cart_id])
  assert_equal 1, cart.line_items.size
  assert_equal ruby_book, cart.line_items[0].product

  get "/orders/new"
  assert_response :success
  assert_template "new"

  post_via_redirect "/orders", order: {
                                name:     "dave thomas",
                                address:  "123 the street",
                                email:    "dave@example.com",
                                pay_type: "現金"}
  assert_response :success
  assert_template "index"
  cart = Cart.find(session[:cart_id])
  assert_equal 0, cart.line_items.size

  orders = Order.all
  assert_equal 1, orders.size

  mail = ActionMailer::Base.deliveries.last
  assert_equal ["dave@example.com"], mail.to
  end
end
