class MessagesController < ApplicationController

    skip_before_action :verify_authenticity_token

    
    def create

        MessageCreationJob.perform_later(
            params[:application_token],
            params[:chat_number],
            message_params
            )
        render json: { message: 'Message creation in progress' }, status: :accepted

    end

    def index
        @application = Application.find_by(token: params[:application_token])

        unless @application
            render json: { error: 'Application not found' }, status: :not_found
            return
        end

        @chat = Chat.find_by(number: params[:chat_number], application_id: @application.id)

        unless @chat
            render json: { error: 'Chat not found' }, status: :not_found
            return
        end

        @messages = Message.where(chat_id: @chat.id)

        unless @messages
            render json: { error: 'No messages found for this chat' }, status: :not_found
            return
        end

        render json: @messages.as_json(except: [:id, :chat_id]), status: :ok     # not to expose message id and chat id

    end

    def show
        @application = Application.find_by(token: params[:application_token])

        unless @application
            render json: { error: 'Application not found' }, status: :not_found
            return
        end

        @chat = Chat.find_by(number: params[:chat_number], application_id: @application.id)

        unless @chat
            render json: { error: 'Chat not found' }, status: :not_found
            return
        end

        @message = Message.find_by(number: params[:number], chat_id: @chat.id)

        unless @message
            render json: { error: 'Message not found' }, status: :not_found
            return
        end

        render json: @message.as_json(except: [:id, :chat_id]), status: :ok

    end

    def search
        if params[:query].present?
            response = Message.search(params[:query])   # run the built-in Elasticsearch search method
            @messages = response.records

            if response.results.total == 0
                render json: { error: 'No messages found' }, status: :not_found
            else
    
                render json: @messages
            end
        else
            render json: { error: 'Query is missing' }, status: :bad_request
        end
    end
           

    private

    def message_params
        params.require(:message).permit(:body)
    end


end
