require 'rake'

Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
FantasyLol::Application.load_tasks

class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
    
    def search
        @players = Player.search params[:search]
    end
    
    def updateScore
        Player.find_each do |player|
            if player.k == nil
                player.k=0
            end
            if player.d == nil
                player.d=0
            end
            if player.a == nil
                player.a=0
            end
            tmprk = player.k
            tmprd = player.d
            tmpra = player.a
            tmpsum = (3*tmprk) - (1*tmprd) + (2*tmpra)
            
            player.update(score:tmpsum)
        end
    end
    
    #Updates all player's KDA stats
    def updatePlayer
        Player.find_each do |player|
            #puts player.riotID
            tmprid = player.riotID
            #puts tmprid
            s = "Rake example:get_last_game_byID[" + tmprid + "]"
            system s
            
            updateScore
        end
    end
        
  # GET /players
  # GET /players.json
  def index
    @players = Player.all
      updatePlayer
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:riotID, :name, :k, :d, :a, :cs, :triple, :quadra, :penta, :towers, :inhibs, :dragon, :baron)
    end
end
