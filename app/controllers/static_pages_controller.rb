class StaticPagesController < ApplicationController
  def home
  end
    
    def index
        @players = Player.all
    end
    
end
