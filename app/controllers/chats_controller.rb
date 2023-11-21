class ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token


    def create
        
        ChatCreationJob.perform_later(params[:application_token])
        render json: { message: 'Chat creation in progress' }, status: :accepted
      
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
