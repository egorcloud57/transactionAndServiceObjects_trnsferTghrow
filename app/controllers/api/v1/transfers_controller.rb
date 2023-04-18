module Api
  module V1
    class TransfersController < ApplicationController
      before_action :find_sender_and_receiver!

      def create
        # curl --header "Content-Type: application/json" \
        # --request POST \
        # --data "{\"transfer\":{\"money\":\"100\", \"sender_id\":\"1\", \"receiver_id\":\"5\", \"comment\":\"hello world\"}}" \
        # http://localhost:3000/api/v1/transfers.json
        @result = Transfers::CreateService.call({
                                                 sender: @sender,
                                                 receiver: @receiver,
                                                 money: transfer_params[:money]&.to_f&.round(2),
                                                 comment: transfer_params[:comment]
                                               })
        if @result.errors.none? && @result.errors.blank?
          render json: { transfer: @result }, status: :ok
        else
          render json: { transfer: @result.errors }, status: :created
        end
      end

      private

      def find_sender_and_receiver!
        @sender = Account.find(transfer_params[:sender_id])
        @receiver = Account.find(transfer_params[:receiver_id])
      end

      def transfer_params
        params.require(:transfer).permit(:money, :sender_id, :receiver_id, :comment)
      end
    end
  end
end