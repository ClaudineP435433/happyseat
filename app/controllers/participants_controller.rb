class ParticipantsController < ApplicationController

  def create
    @table = Table.first
    @participant = Participant.new(participant_params)
    @participant.table = @table

    # @participant.seat = 4 #algo
    if @participant.save
      redirect_to seating_plan_tables_path(@table.seating_plan)
      #algo ajouter sur table + allouer un siége
      flash[:notice] = "Successfully added your guest #{@participant.first_name.capitalize} #{@participant.last_name.capitalize}"
    else
      @tables = Table.all
       render 'tables/index'
    end
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(participant_params)
      redirect_to @participant, notice: 'Successfully updated participant'
    else
      #render????
    end
  end





  private

  def participant_params
    params.require(:participant).permit(
      :first_name,
      :last_name,
      :age_range,
      :family_type,
    )
  end

  def search_params
    params.require(:search).permit(
      :participant_id,
      :seating_plan_id
      )
  end
end



# click finalize
#1 afficher en ajax @participant.name
#2 ouvrir modal lors click button + display
#3 display params @participant ds modal

#4 nested form



