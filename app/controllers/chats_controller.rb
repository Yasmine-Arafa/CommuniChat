class ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token


    def create

        @application = Application.find_by(token: params[:application_token])

        unless @application
            Rails.logger.error "Application not found for token: #{params[:application_token]}"
            render json: { error: 'Application not found' }, status: :not_found
            return
        end

        number = @application.chats.maximum(:number).to_i + 1  # ( optimistically ) fetchs the max field num. and increment by 1

        job = ChatCreationJob.perform_later(params[:application_token], number)

        queue_id = job.provider_job_id

        render json: {
                        message: 'Chat creation in progress',
                        chat_number: number,
                        queue_id: queue_id  
                    }, 
                    status: :ok
      
    end
      

    def index
        @application = Application.find_by(token: params[:application_token])

        unless @application
            render json: { error: 'Application not found' }, status: :not_found
            return
        end

        @chats = Chat.where(application_id: @application.id)

        unless @chats
            render json: { error: 'No chats found for this application' }, status: :not_found
            return
        end

        render json: @chats.as_json(except: [:id, :application_id]), status: :ok  # not to expose app id and chat id
    end

    def show
        @application = Application.find_by(token: params[:application_token])

        unless @application
            render json: { error: 'Application not found' }, status: :not_found
            return
        end
        
        @chat = Chat.find_by(number: params[:number], application_id: @application.id)

        unless @chat
            render json: { error: 'Chat not found' }, status: :not_found
            return
        end

        render json: @chat.as_json(except: [:id, :application_id]), status: :ok
    end

    private

    def chat_params
        params.require(:chat).permit(:number)
    end

end
