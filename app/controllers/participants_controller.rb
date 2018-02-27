class ParticipantsController < ApplicationController

  def create

    @table = Table.first
    @participant = Participant.new(participant_params)
    @participant.table = @table
    # @participant.seat = 4 #algo
    raise
    if @participant.save
      redirect_to seating_plan_tables_path(@table.seating_plan)
      flash[:notice] = "Successfully added your guest #{@participant.first_name.capitalize} #{@participant.last_name.capitalize}"
      #algo ajouter sur table + allouer un siége
    else
      @tables = Table.all
      render 'tables/index'
    end
  end

  def update
  end

  def destroy
  end

  private

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :age_range, :family_type, relationships_attributes: [:link, :second_guest_id])
  end

end
