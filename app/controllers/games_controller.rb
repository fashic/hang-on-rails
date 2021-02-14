class GamesController < ApplicationController
  def create
    word = Word.order('RANDOM()').first
    game = word.games.create

    redirect_to game
  end

  def show
    @game = Game.find(params[:id])
  end

  def index
    @games = Game.sorted
  end

  def play
    game = Game.find(params[:id])
    game.play!(params[:letter])
    game.save

    respond_to do |format|
      format.json do
        render json: {
          current: render_to_string(partial: 'games/current', locals: { game: game }, formats: [:html])
        }
      end
    end
  end
end
