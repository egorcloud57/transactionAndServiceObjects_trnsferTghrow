class Account < ApplicationRecord
  belongs_to :user

  has_many :my_senders, class_name: 'Transfer', foreign_key: :sender_id # ключа account id нет, поэтому обязательно
  # указываем.
  has_many :my_receivers, class_name: 'Transfer', foreign_key: :receiver_id # ключа account id нет, поэтому
  # обязательно указываем.
  has_many :receivers, through: :my_senders # все аккаунты которые получали деньги от этого. связь идет чз sender_id
  has_many :senders, through: :my_receivers # все аккаунты которые отправляли деньги этому. связь идет чз receiver_id

  def transfers
    my_senders + my_receivers
  end
end
