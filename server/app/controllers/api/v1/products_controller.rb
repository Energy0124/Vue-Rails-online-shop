module Api
  module V1
    class ProductsController < ApiController
      before_action :set_product, only: [:show, :update, :destroy]
      # todo: fix permission
      skip_before_action :auth_with_token!, except: []


      # GET /products
      def index
        @products = Product.all

        render json: @products
      end

      # GET /products/1
      def show
        render json: @product
      end

      # POST /products
      def create
        @product = Product.new(product_params)

        if @product.save
          @product.image_url = @product.picture.url
          if @product.save
            render json: @product, status: :created, location: @product
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /products/1
      def update
        if @product.update(product_params)
          @product.image_url = @product.picture.url
          if @product.save
            render json: @product
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # DELETE /products/1
      def destroy
        @product.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def product_params
        params.require(:product).permit(:name, :category_id, :price, :description, :image_url, :picture, :image, :image_file_name)
      end

    end
  end
end
