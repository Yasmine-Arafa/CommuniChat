class ApplicationsController < ApplicationController

    skip_before_action :verify_authenticity_token   # skip CSRF check 


    def create
        @application = Application.new(application_params)
        if @application.save
            render json: { token: @application.token }, status: :created   # returns only token
        else
            render json: @application.errors, status: :unprocessable_entity
        end
    end

    
    def index
        @applications = Application.all

        unless @applications
            render json: { error: 'No Applications Found' }, status: :not_found
            return
        end

        render json: @applications.as_json(except: :id), status: :ok  # not to expose id
    end


    def show
        @application = Application.find_by(token: params[:token])

        unless @application
            render json: { error: 'Application not found' }, status: :not_found
            return
        end

        render json: @application.as_json(except: :id), status: :ok
    end
    
    def update
        @application = Application.find_by(token: params[:token])
        
        unless @application
            render json: { error: 'Application not found' }, status: :not_found
            return
        end
        
        
        retries = 0
    
        begin
            if @application.update!(application_params)
                render json: @application.as_json(except: :id), status: :ok
            else
                render json: @application.errors, status: :unprocessable_entity
            end
        rescue ActiveRecord::StaleObjectError
            
          if retries < 3

            retries += 1
            @application.reload
            retry

          else
            render json: { error: 'Record has been updated by another user. Please refresh and try again.' }, status: :conflict            
          end

        end

    end

    
    private
    
    def application_params
        params.require(:application).permit(:name)
    end

end
