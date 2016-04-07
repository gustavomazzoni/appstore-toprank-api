require 'httparty'

class ITunesAPI
	include HTTParty
	base_uri 'https://itunes.apple.com'
  format :json
	
  def view_top(query = {}, headers = {})
    raise ArgumentError, 'You must inform a genreId' if query[:genreId].nil?

    # make the request and return the elements (NOTE: this doesn't handle errors at this point)
    self.class.get('/WebObjects/MZStore.woa/wa/viewTop', headers: headers, query: query)
  end

  def lookup(query = {})
    raise ArgumentError, 'You must lookup for something' if query.empty?
    self.class.get("/lookup", :query => query)['results']
  end

  def search(query = {})
    raise ArgumentError, 'You must search for something' if query.empty?
    self.class.get("/search", :query => query)['results']
  end
end