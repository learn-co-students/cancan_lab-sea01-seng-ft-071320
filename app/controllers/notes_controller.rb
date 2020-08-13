class NotesController < ApplicationController
  before_action :draw_note, only: [ :update ]
  # load_and_authorize_resource

  def create
    # authorize! :create, Note
    if !current_user
      # stolen from solution, specifically return unauthorized
      return head(:unauthorized)
    else
      # success, logged in
      @note = Note.new(note_params)
      @note.user = current_user
      if @note.save
        # success, redirect
        Viewer.create(user: current_user, note: @note) # create the join to associate current_user with this note
        redirect_to '/'
      else
        render 'new'
      end
    end
  end

  def update
    @note.update(note_params)
    redirect_to '/'
  end

  private

  def draw_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
