module Api 
    module V1 
        class ItemsController < ApplicationController
            def index
                @items = Item.all

                render json: ItemSerializer.new(@items, options).serialized_json
            end

            def create
                @item = Item.new(item_params)
                if @item.save
                    render json: ItemSerializer.new(@item).serialized_json
                else
                    render json: {data: @item.errors, message: "items cannot be added"}, status: :unprocessable_entity

                end
            end
        

        private

            def item_params
                params.require(:item).permit(:name, :category)
            end

            def options
                @options ||= {include: %i[stocks]}
            end
            
        end
    end
end