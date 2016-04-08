require 'rails_helper'

RSpec.describe TopRank do
	before(:all) do
		Rails.cache.clear
	end
	before(:each) { 
		# Rails.cache.clear
		#input values from user for testing
		@category_id = 6001
		@monetization = 'Paid'
		@popId = nil
	}

	describe "find" do
		it "returns top 200 apps ordered by rank position together with the metadata information as a json result" do
			expect(Rails.cache.read("/top_rank/#{@category_id}-#{@monetization}-#{@popId}/find")).to be_nil
			
			response = TopRank.find(@category_id, @monetization, @popId)

			expect(Rails.cache.read("/top_rank/#{@category_id}-#{@monetization}-#{@popId}/find")).to_not be_nil
			expect(response.apps.size).to eq 200
		end
	end

	describe "find_with_metadata" do
		it "returns top 200 apps ordered by rank position together with the metadata information as a json result" do
			response = TopRank.find_with_metadata(@category_id, @monetization, @popId)

			expect(response.apps.size).to eq 200
			expect(response.apps.first.appName).to_not be_nil
		end
	end

	describe "find_app_by_position" do
		it "returns app data for single application together with the metadata as json result" do
			#input values from user for testing
			rankPosition = 3

			response = TopRank.find_app_by_position(@category_id, @monetization, rankPosition)
			
			expect(response.appId).to_not be_nil
		end
	end

	describe "find_top_publishers" do
		it "returns top publishers rank by the amount of apps available in the top list as a json result. (publisher id, publisher name, rank, number of apps, app names in array)" do
			expect(Rails.cache.read("/top_rank/#{@category_id}-#{@monetization}-#{@popId}/find_top_publishers")).to be_nil

			response = TopRank.find_top_publishers(@category_id, @monetization, @popId)

			expect(Rails.cache.read("/top_rank/#{@category_id}-#{@monetization}-#{@popId}/find_top_publishers")).to_not be_nil
			expect(response.size).to be > 1
		end
	end
end