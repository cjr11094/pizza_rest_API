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
  end
end