5.times do |i|
  user = User.create({ lname: "Egor#{i}", fname: "Tuchkin#{i}" })
  user.create_account({ score: 1000 })
end

Transfer.create({ sender_id: User.first.id, receiver_id: User.last.id, money: 200 })