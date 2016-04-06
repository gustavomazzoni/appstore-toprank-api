require 'itunes_api'

RSpec.describe ITunesAPI do
	before(:each) do
		@itunes_api = ITunesAPI.new
    end

	describe "view_top" do

		it "returns information from itunes viewTop API (Top 200 app rank list) when genreId is passed as argument" do
			headers = {"Accept­Encoding" => "gzip, deflate, sdch",
				"Accept­Language" => "en­US,en;q=0.8,lv;q=0.6",
				"User-Agent" => "iTunes/11.1.1 (Windows; Microsoft Windows 7 x64 Ultimate Edition Service Pack 1 (Build 7601)) AppleWebKit/536.30.1",
				"Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
				"Cache­Control" => "max­age=0",
				"X­Apple­Store­Front" => "143441­1,17"}
			top_rank_response = @itunes_api.view_top({genreId:6001, popId:30, dataOnly: 'true', l: 'en'}, headers)
			
			httparty_response = HTTParty.get('https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?genreId=6001&popId=30&dataOnly=true&l=en', 
							headers: headers)
			
			expect(top_rank_response).to eql httparty_response
		end

		it "raises ArgumentError when genreId is not informed as argument" do
		  expect {
		  	@itunes_api.view_top({popId:30, dataOnly: 'true', l: 'en'})
		  }.to raise_error(ArgumentError)
		end
	end

	describe "lookup" do

		it "returns information from iTunes Search API, lookup method" do
			app_response = @itunes_api.lookup({id:517329357})
			
			httparty_response = HTTParty.get('https://itunes.apple.com/lookup?id=517329357')["results"]
			
			expect(app_response).to eql httparty_response
		end

		it "raises ArgumentError when no argument is informed" do
		  expect {
		  	@itunes_api.lookup({})
		  }.to raise_error(ArgumentError)
		end
	end

	describe "search" do

		it "returns information from iTunes Search API, search method" do
			app_response = @itunes_api.search({term:'yelp', country:'us', entity:'software'})
			
			httparty_response = HTTParty.get('https://itunes.apple.com/search?term=yelp&country=us&entity=software')["results"]
			
			expect(app_response).to eql httparty_response
		end

		it "raises ArgumentError when no argument is informed" do
		  expect {
		  	@itunes_api.search({})
		  }.to raise_error(ArgumentError)
		end
	end
end