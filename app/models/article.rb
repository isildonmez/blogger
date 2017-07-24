class Article < ApplicationRecord
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings

	has_attached_file :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	def tag_list
		tags.join(", ")
	end

	def tag_list=(tags_string)
	  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
	  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
	  puts new_or_found_tags
	  self.tags = new_or_found_tags
	end

	# Another alternative to fix the tag_list method. Yet, I choose to define a new `Tag#to_s` method which overrides the deafult inside the `tag.rb`
	# def tag_list
	#   self.tags.collect do |tag|
	#     tag.name
	#   end.join(", ")
	# end

end

