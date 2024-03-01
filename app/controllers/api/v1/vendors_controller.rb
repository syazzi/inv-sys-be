module Api 
    module V1 
        class VendorsController < ApplicationController
            def index
                @vendors = Vendor.all

                render json: VendorSerializer.new(@vendors, options).serialized_json
            end

            def create
                @vendor = Vendor.new(vendor_params)
                if @vendor.save
                    render json: VendorSerializer.new(@vendor).serialized_json
                else
                    render json: {data: @vendor.errors, message: "vendors cannot be added"}, status: :unprocessable_entity

                end
            end
        

        private

            def vendor_params
                params.require(:vendor).permit(:name)
            end

            def options
                @options ||= {include: %i[stocks]}
            end
            
        end
    end
end