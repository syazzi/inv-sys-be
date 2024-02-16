module Api 
    module V1 
        class StocksController < ApplicationController
            # protect_from_forgery with: :null_session
            def index 
                stocks = Stock.order('created_at DESC');

                render json: StockSerializer.new(stocks).serialized_json
            end
            
            def show
                @stock = Stock.find(params[:id])
                render json: StockSerializer.new(@stock).serialized_json
                
            end

            def create
                @stock = Stock.new(stock_params)
                if @stock.save
                    render json: StockSerializer.new(@stock).serialized_json
                else
                    render json: {data: @stock.errors, message: 'Stock Cannot be Saved'}, status: :unprocessable_entity
                end
            end
            
            def destroy
                @stock = Stock.find(params[:id])
                if @stock.destroy
                    render json: StockSerializer.new(@stock).serialized_json
                else
                    render json: {data: @stock.errors, message: 'Stock Cannot be deleted'}, status: :unprocessable_entity
                end
            end
            
            def update
                @stock = Stock.find(params[:id])
                if @stock.update(stock_params)
                    render json: StockSerializer.new(@stock).serialized_json
                else
                    render json: {data: @stock.errors, message: 'Stock Cannot be updated'}, status: :unprocessable_entity
                end
            end
                        
            private

            def stock_params
                params.require(:stock).permit(:item_id, :department_id, :purchase_date, :arrival_date, :vendor_id, :quantity, :price_per_unit, :image_url, :description)
            end
        end
    end
end