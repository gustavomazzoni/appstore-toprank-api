class Api::V1::TopRanksController < ApplicationController
	
	before_filter do
		unless params[:genreId] && params[:monetization] && (params[:genreId].to_i > 0) && (['Paid', 'Free', 'Top Grossing'].include? params[:monetization])
		  render nothing: true, status: :bad_request
		end
	end

	def index
		if params[:rankPosition]
			unless (params[:rankPosition].to_i > 0)
			  render nothing: true, status: :bad_request
			end

			render json: TopRank.find_app_by_position(params[:genreId],params[:monetization],params[:popId],params[:rankPosition])
		else
			render json: TopRank.find_with_metadata(params[:genreId],params[:monetization],params[:popId])
		end
	end

	def top_publishers
		render json: TopRank.find_top_publishers(params[:genreId],params[:monetization],params[:popId])
	end
end
