class PokemonsController < ApplicationController
	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer_id = current_trainer.id
		@pokemon.save
		redirect_to root_path
	end

	def damage
		@pokemon = Pokemon.find(params[:id])
		@pokemon.health = @pokemon.health - 10
		@pokemon.save
		if @pokemon.health <= 0
			@pokemon.destroy
		end
		redirect_to trainer_path(@pokemon.trainer_id)
	end

	def new
	end

	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.level = 1
		@pokemon.health = 100
		@pokemon.trainer_id = current_trainer.id
		if @pokemon.save
			redirect_to trainer_path(current_trainer)
		else
			flash[:error] = @pokemon.errors.full_messages.to_sentence
			redirect_to new_pokemon_path
		end
	end

	private
	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
end
