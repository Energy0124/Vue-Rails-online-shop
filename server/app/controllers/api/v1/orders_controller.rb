require 'paypal-sdk-rest'
include PayPal::SDK::REST
module Api
  module V1

    class OrdersController < ApiController
      before_action :set_order, only: [:show, :update, :destroy]
      # todo: fix permission
      skip_before_action :auth_with_token!, only: [:create_payment]
      before_action :auth_with_admin_token!, only: [:index, :show]

      def create_payment

        params.permit!
        carts = JSON.parse(params["0"])
        puts carts
        items =[]
        total_price = 0
        carts.each {|item|

          product = Product.find (item["id"])

          total_price += product.price * item["count"]
          items.append({
                         :name => product.name,
                         :sku => product.id,
                         :price => product.price,
                         :currency => "HKD",
                         :quantity => item["count"]})
        }

        puts items
        puts total_price

        PayPal::SDK::REST.set_config(
          :mode => "sandbox", # "sandbox" or "live"
          :client_id => "AbvYt9vTE8tqnzfvFRJRrrUMSGA15Mn8bBfQGGf2H4Eqwz0QlFH4ZmV3HBbKEGe_2gN37QKLlX9rG1yK",
          :client_secret => "EM_0_013SaljS3JlSYXQYqIPYWWnQG1qLtvOcJ1Nzyb7sVa_0tICz_cPORmyhfwqY_GLGBuILCpjyPAp")

        # Build Payment object
        @payment = Payment.new({
                                 :intent => "sale",
                                 :payer => {
                                   :payment_method => "paypal"},
                                 :redirect_urls => {
                                   :return_url => "http://localhost:8080/",
                                   :cancel_url => "http://localhost:8080/"},
                                 :transactions => [{
                                                     :item_list => {
                                                       :items => items},
                                                     :amount => {
                                                       :total => total_price,
                                                       :currency => "HKD"},
                                                     :description => "This is the payment transaction description."}]})

        if @payment.create
          order = ShopOrder.new
          order.payment_id = @payment.id
          order.currency="HKD"
          order.items = items.map {|o| Hash[o.each_pair.to_a]}.to_json
          order.total_price = total_price
          order.status = "created"
          order.save
          @payment.id # Payment Id
        else
          @payment.error # Error Hash
        end

        render json: @payment
      end

      # GET /orders
      def index
        @orders = ShopOrder.all

        render json: @orders
      end

      # GET /orders/1
      def show
        render json: @order
      end

      # POST /orders
      def create
        @order = ShopOrder.new(order_params)

        if @order.save
          render json: @order, status: :created, location: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /orders/1
      def update
        if @order.update(order_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # DELETE /orders/1
      def destroy
        @order.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = ShopOrder.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def order_params
        params.require(:order).permit(:name)
      end
    end
  end
end
