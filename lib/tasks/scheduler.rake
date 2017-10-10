  desc "TODO"
  task auto_cancel_reservation: :environment do
    puts "i can auto cancel your reservation"
  end

  desc "auto cancel"
  task auto_cancel_checkout: :environment do
    puts "i can auto cancel your checkedout"
  end

