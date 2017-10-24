module Api
  module V1
    class ProductsController < ApiController
      # todo: fix permission
      skip_before_action :auth_with_token!, except: []


      def index
        render json: Product.all
      end

      def show
        render json: Product.find(params[:id])
      end

      def create
        product = Product.new
        if product.save
          render json: product, status: :created
        else
          render_error(product.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def update
        product = Product.find(params[:id])
        if product.update(product_params)
          render json: product
        else
          render_error(product.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def destroy
        product = Product.find(params[:id])
        product.destroy
        head :no_content
      end

      private
      def product_params
        params.require(:product).permit(:name)
      end

    end
  end
end
