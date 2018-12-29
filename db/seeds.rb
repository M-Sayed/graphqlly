ActiveRecord::Base.transaction do
  [Vote, Link, User].each(&:destroy_all)

  5.times do |i|
    user = User.create! do |u|
      u.name      = "User_#{i}"
      u.email     = "example_#{i}@email.com"
      u.password  = "SimplePa$$word"
      u.password_confirmation  = "SimplePa$$word"
    end

    2.times do |j|
      link = Link.create! do |l|
        l.url = "http://www.website#{i*2 + j}.com"
        l.description = "description #{i*2 + j}"
        l.user = user
      end
    end
  end

  10.times do |i|
    user = User.order(Arel.sql("RANDOM()")).first
    link = Link.order(Arel.sql("RANDOM()")).first

    Vote.create!(link: link, user: user)
  end
end
