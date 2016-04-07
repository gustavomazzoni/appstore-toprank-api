require 'itunes_api'

class Publisher
	include ActiveModel::Model
  	attr_accessor :publisherId, :publisherName, :numberOfApps, :apps, :rank
end