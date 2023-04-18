module Transfers
  class CreateService < ::ApplicationService
    attr_accessor :sender, :receiver, :money, :comment

    def initialize(params)
      @sender = params[:sender]
      @receiver = params[:receiver]
      @money = params[:money]
      @comment = params[:comment]
      super
    end

    def call(&block)
      if money == 0 or sender.score < money
        return ::ApplicationService::Result.new({ errors: ['нет бабла'] })
      end
      result = transaction_commit! do
        sender.update!(score: sender.score - money)
        receiver.update!(score: receiver.score + money)
        Comment.create!(description: comment, user_id: receiver.id) if comment.present?
        Transfer.create!(sender_id: sender.id, receiver_id: receiver.id, money: money)
      end
      # block.call if block.present?
      # super
      ::ApplicationService::Result.new({ result: result, errors: result.errors.full_messages })
    end
  end
end