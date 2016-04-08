require 'rails_helper'

RSpec.describe App do
	before(:each) { 
		Rails.cache.clear
		#input values from user for testing
		@id = 448012186
	}

	describe "find_by_id" do
		it "returns app metadata" do
			expect(Rails.cache.read("/app/#{@id}/find_by_id")).to be_nil
			
			response = App.find_by_id(@id)

			expect(Rails.cache.read("/app/#{@id}/find_by_id")).to_not be_nil
			expect(response).to_not be_nil
			expect(response.appId).to eq @id
		end
	end
end