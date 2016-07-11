module Rest
  class API < Grape::API
    prefix 'api'
    format :json

    resource "people" do
        get do
            { :total => Person.count, :data => Person.all.map { |e| { :id => e.id, :name => e.name } } }
        end
    end

    resource "pizzas" do
        get do
            { :total => Pizza.count, :data => Pizza.all.map { |e| { :id => e.id, :person_id => e.person_id, :type => e.type, :eaten_at => e.date } } }
        end
    end

    resource "streaks" do
        get do
            @users = Pizza.all.map { |e| { :id => e.id, :eaten_at => e.date } }
            @users.sort_by { |hsh| hsh[:eaten_at] }
            prevPurchaseDate = nil
            currStreak = 0
            prevStreak = 0
            streaks = []
            streak = []
            @users.each do |hsh|
                currPurchaseDate = hsh[:eaten_at]
                if prev != nil
                    if prevPurchaseDate == currPurchaseDate
                        currStreak+=1
                    else
                        if currStreak >= prevStreak
                            streak.push(prevPurchaseDate)
                        else
                            if streak.length > 1
                                streaks.push(streak)
                                streak = []
                            end
                        end
                    end
                    prevPurchaseDate = currPurchaseDate
                else
                    prevPurchaseDate = hsh[:eaten_at]
                end
            end
        end
    end

    resource "most_pizza" do
        get do
            @users = Pizza.all.map { |e| { :id => e.id, :eaten_at => e.date } }
            @users.sort_by { |hsh| hsh[:eaten_at] }
            prevPurchaseDate = nil
            currStreak = 0
            prevStreak = 0
            streaks = []
            streak = []
            @users.each do |hsh|
            #     currPurchaseDate = hsh[:eaten_at]
            #     if prev != nil
            #         if prevPurchaseDate == currPurchaseDate
            #             currStreak+=1
            #         else
            #             if currStreak >= prevStreak
            #                 streak.push(prevPurchaseDate)
            #             else
            #                 if streak.length > 1
            #                     streaks.push(streak)
            #                     streak = []
            #                 end
            #             end
            #         end
            #         prevPurchaseDate = currPurchaseDate
            #     else
            #         prevPurchaseDate = hsh[:eaten_at]
            #     end
            # end
        end        
    end

  end
end