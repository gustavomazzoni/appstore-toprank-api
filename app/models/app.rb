require 'itunes_api'

class App
  include ActiveModel::Model
  attr_accessor :appId, :appName, :description, :smallIconUrl, 
  				:publisherName, :price, :versionNumber, :averageUserRating
  @@itunes_api = ITunesAPI.new

  def self.find_by_id(id)
  	Rails.cache.fetch("/app/#{id}/find_by_id", :expires_in => 1.day) do
	  	app_metadata = @@itunes_api.lookup(:id => id)

	  	raise ArgumentError, 'Invalid id argument' if app_metadata.nil?
		
		# Create app with metadata
		if !app_metadata.empty?
			app = App.new(
				:appId => id,
				:appName => app_metadata.first["trackName"],
				:description => app_metadata.first["description"],
				:smallIconUrl => app_metadata.first["artworkUrl60"],
				:publisherName => app_metadata.first["sellerName"],
				:price => app_metadata.first["formattedPrice"],
				:versionNumber => app_metadata.first["version"],
				:averageUserRating => app_metadata.first["averageUserRating"]
			)
		# In case app not found on lookup, 
		# create app with empty metadata
		else 
			app = App.new(
				:appId => id,
				:appName => "",
				:description => "",
				:smallIconUrl => "",
				:publisherName => "",
				:price => "",
				:versionNumber => "",
				:averageUserRating => ""
			)
		end

		app
	end
  end

end