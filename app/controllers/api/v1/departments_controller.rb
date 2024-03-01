module Api 
    module V1 
        class DepartmentsController < ApplicationController
            def index
                @departments = Department.all

                render json: DepartmentSerializer.new(@departments, options).serialized_json
            end

            def create
                @department = Department.new(department_params)
                if @department.save
                    render json: DepartmentSerializer.new(@department).serialized_json
                else
                    render json: {data: @department.errors, message: "Department cannot be added"}, status: :unprocessable_entity

                end
            end
        

        private

            def department_params
                params.require(:department).permit(:name)
            
            end

            def options
                @options ||= {include: %i[stocks]}
            end
            
        end
    end
end