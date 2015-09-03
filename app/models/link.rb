class Link < ActiveRecord::Base

	after_create :generate_slug, :scrape_title

	def generate_slug
    	self.slug = self.id.to_s(36)
    	self.save
  	end

  	def scrape_title
	    self.title = Mechanize.new.get(self.url).title
	    self.save
  	end

end