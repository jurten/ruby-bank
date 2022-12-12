class TurnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_turn, only: %i[ show edit update destroy ]

  # GET /turns or /turns.json
  def index
    @turns = Turn.accessible_by(current_ability)
  end

  # GET /turns/1 or /turns/1.json
  def show
  end

  # GET /turns/new
  def new
    @turn = Turn.new
  end

  # GET /turns/1/edit
  def edit
  end

  # POST /turns or /turns.json
  def create
    turn_data = turn_params
    turn_data[:user_id] = current_user.id
    @turn = Turn.new(turn_data)

    respond_to do |format|
      if @turn.save
        format.html { redirect_to turn_url(@turn), notice: "El Turno fue creado con exito" }
        format.json { render :show, status: :created, location: @turn }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turns/1 or /turns/1.json
  def update
    turn_data = turn_params
    if !(turn_data[:comment] == "")
      turn_data[:status] = "finished"
      turn_data[:staff_id] = current_user.id
    end
    respond_to do |format|
      if @turn.update(turn_data)
        format.html { redirect_to turn_url(@turn), notice: "El Turno fue actualizado con exito" }
        format.json { render :show, status: :ok, location: @turn }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turns/1 or /turns/1.json
  def destroy
    @turn.destroy

    respond_to do |format|
      format.html { redirect_to turns_url, notice: "El Turno fue borrado con exito" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_params
      params.require(:turn).permit(:branch_id, :user_id, :date, :reason, :status, :comment, :staff_id)
    end
end
