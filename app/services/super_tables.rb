class SuperTables

  attr_accessor :list

  def initialize(params = {})
    @seating_plan = params[:seating_plan]
    create_list
  end


  def create_list
    seats = (1..@seating_plan.nb_participants).to_a
    @list = {}
    @seating_plan.tables.each_with_index do |table, index|
      seats[0..table.nb_max_participants-1].each do |seat|
      @list["#{index}"] =
      end
      seats = seats[table.nb_max_participants..-1]
    end




  end

end
