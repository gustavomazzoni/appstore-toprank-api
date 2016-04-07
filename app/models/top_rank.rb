require 'itunes_api'

class TopRank
  include ActiveModel::Model
  attr_accessor :title, :categoryName, :apps, :topPublishers
  @@itunes_api = ITunesAPI.new
  @@headers = {"Accept­Encoding" => "gzip, deflate, sdch",
				"Accept­Language" => "en­US,en;q=0.8,lv;q=0.6",
				"User-Agent" => "iTunes/11.1.1 (Windows; Microsoft Windows 7 x64 Ultimate Edition Service Pack 1 (Build 7601)) AppleWebKit/536.30.1",
				"Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
				"Cache­Control" => "max­age=0",
				"X­Apple­Store­Front" => "143441­1,17"}

  def self.find(genreId, monetization, popId)
  	top_rank_response = @@itunes_api.view_top({genreId:genreId, dataOnly: true, l: 'en'}, @@headers)

	#get category name
	category_name = top_rank_response['genre']['name']
	#get top rank list (Top Paid iPhone Apps, Top Free iPhone Apps, Top Grossing iPhone Apps)
	top_charts = top_rank_response['topCharts']
	
	#get top rank from monetization chosen by user
	top_chart = top_charts.select {|hash| hash['shortTitle'] == monetization}
	
	#initialize the TopRank object to be returned
	top_rank = TopRank.new(
		:title => top_chart[0]['title'],
		:categoryName => category_name,
		:apps => top_chart[0]['adamIds']
	)

	return top_rank
  end

  def self.find_with_metadata(genreId, monetization, popId)
  	top_rank_response = @@itunes_api.view_top({genreId:genreId, dataOnly: true, l: 'en'}, @@headers)

	#get category name
	category_name = top_rank_response['genre']['name']
	#get top rank list (Top Paid iPhone Apps, Top Free iPhone Apps, Top Grossing iPhone Apps)
	top_charts = top_rank_response['topCharts']
	
	#get top rank from monetization chosen by user
	top_chart = top_charts.select {|hash| hash['shortTitle'] == monetization}
	
	#initialize the TopRank object to be returned
	top_rank = TopRank.new(
		:title => top_chart[0]['title'],
		:categoryName => category_name,
		:apps => []
	)

	#list with adamIds (apps IDs)
	adam_ids = top_chart[0]['adamIds']
	#get additional metadata information for each adamIds via Apple lookup API
	adam_ids.each do |adam_id|
		app = App.find_by_id(adam_id)
		
		#add app to the list
		top_rank.apps.push(app)
	end

	return top_rank
  end

  def self.find_app_by_position(category_id, monetization, rankPosition)
  	top_rank = self.find(category_id, monetization, nil)

  	appId = top_rank.apps[rankPosition - 1]

  	return App.find_by_id(appId)
  end

  def self.find_top_publishers(category_id, monetization)
  	top_rank = self.find(category_id, monetization, nil)

  	#future list with top publishers with info
	top_publishers = []
  	#get additional metadata information for each adamIds via Apple lookup API
	top_rank.apps.each do |app_id|
	  	app_metadata = @@itunes_api.lookup(:id => app_id)
					
		# Create publisher with infos
		if !app_metadata.empty?
			#check if this publisher already in rank list
			publisherItem = top_publishers.select {|hash| hash.publisherId == app_metadata.first["artistId"]}
			if publisherItem.empty?
				publisher = Publisher.new(
					:publisherId => app_metadata.first["artistId"],
					:publisherName => app_metadata.first["artistName"],
					:numberOfApps => 1,
					:apps => [app_metadata.first["trackName"]]
				)
				#add publisher to the list
				top_publishers.push(publisher)
			else 
				publisherItem[0].numberOfApps += 1
				publisherItem[0].apps.push(app_metadata.first["trackName"])
			end
		end
	end
	
	#order top publishers list by number of apps they have on top rank
	top_publishers = top_publishers.sort_by {|hash| hash.numberOfApps}.reverse!
	#add rank property to each element of the list with publisher's position in the rank
	top_publishers.map.with_index{ |hash, i| hash.rank = i+1 }

	return top_publishers
  end
end