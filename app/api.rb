module Rest
  class API < Grape::API
    prefix 'api'
    format :json

    helpers do
        def getNumPizzasToday(index, length, users)
            numPizzasToday = 1
            currPurchaseDate = users[index][:eaten_at]
            tempIndex = index+1
            while tempIndex<length
                nextPurchaseDate = users[tempIndex][:eaten_at]
                if currPurchaseDate == nextPurchaseDate
                    numPizzasToday+=1
                else
                    break
                end
                tempIndex+=1
            end
            return numPizzasToday
        end
    end

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
            @users.sort_by! { |hsh| hsh[:eaten_at] }

            index = 0
            length = @users.length
            currStreak=0
            currStreakList = []
            prevStreakList = []
            allStreaks = []
            numPizzasToday = getNumPizzasToday(index, length, @users)
            streaking = false
            while index < length
                prevNumPizzas=numPizzasToday
                numPizzasToday = getNumPizzasToday(index, length, @users)
                if numPizzasToday > prevNumPizzas # continue streak
                    if !streaking
                        currStreakList.push(prevStreakList[0])
                    end
                    streaking = true
                    currStreak+=1
                    upperLimit = index+numPizzasToday
                    while index < upperLimit and index < length
                        currStreakList.push(@users[index])
                        index+=1
                    end

                else # end streak
                    streaking=false
                    if currStreak >= 1
                        currStreakList.each do |hsh|
                            allStreaks.push(hsh)
                        end
                    end
                    currStreakList = []
                    currStreak = 0
                    prevStreakList=[]
                    prevStreakList.push(@users[index])
                    index+=numPizzasToday
                end
            end

            { :data => allStreaks }

        end
    end

    resource "most_pizza" do
        get do
            @users = Pizza.all.map { |e| { :id => e.id, :eaten_at => e.date } }
            @users.sort_by! { |hsh| hsh[:eaten_at] }
            index = 0
            length = @users.length
            maxList = []
            maxPizzas = 0
            maxDate = nil
            currMonth = nil
            while index < length
                monthOfNextDate = @users[index][:eaten_at].month
                if !currMonth
                    currMonth = monthOfNextDate
                else
                    if !(currMonth == monthOfNextDate)
                        maxList.push( maxDate )
                        maxPizzas = 0
                        maxDate = nil
                        currMonth = monthOfNextDate
                    end
                end    

                numPizzasToday = getNumPizzasToday(index, length, @users)
                currDate = @users[index]

                if numPizzasToday > maxPizzas
                    maxDate = currDate
                end
                index+=numPizzasToday
            end

            { :data => maxList }

            
        end        
    end

  end
end