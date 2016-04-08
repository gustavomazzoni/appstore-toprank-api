require 'rails_helper'

RSpec.describe Api::V1::TopRankController, type: :controller do
	describe "GET #index" do
		context "with category id and monetization(Free, Paid, Grossing)" do
			before(:each) do
				#input values from user for testing
				@category_id = 6001
				@monetization = 'Paid'
				@popId = 30
				get :index, {genreId: @category_id, monetization: @monetization, popId: @popId}
			end

			it "returns top 200 apps ordered by rank position together with the metadata information" do
				apps_response = JSON.parse(response.body, symbolize_names: true)
				expect(apps_response).to_not be_nil
			end

			it "responds successfully with an HTTP 200 status code" do
				expect(response).to be_success
				expect(response).to have_http_status(200)
		    end
		end
	end
end
