require 'rails_helper'

RSpec.describe TopRank do
	describe "find_with_metadata" do
		it "returns top 200 apps ordered by rank position together with the metadata information as a json result" do
			#input values from user for testing
			category_id = 6001
			monetization = 'Paid'

			response = TopRank.find_with_metadata(category_id, monetization, nil)
			
			expect(response.apps.size).to eq 200
		end
	end

	describe "find_app_by_position" do
		it "returns app data for single application together with the metadata as json result" do
			#input values from user for testing
			category_id = 6001
			monetization = 'Paid'
			rankPosition = 3

			response = TopRank.find_app_by_position(category_id, monetization, rankPosition)
			
			expect(response.appId).to_not be_nil
		end
	end

	describe "find_top_publishers" do
		it "returns top publishers rank by the amount of apps available in the top list as a json result. (publisher id, publisher name, rank, number of apps, app names in array)" do
			#input values from user for testing
			category_id = 6001
			monetization = 'Paid'

			response = TopRank.find_top_publishers(category_id, monetization)

			puts response.to_json
			
			expect(response.size).to be > 1
		end
	end
end