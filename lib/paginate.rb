module Paginate

  extend ActiveSupport::Concern

  module ClassMethods

    # returns specified subset of posts/topics
    def paginate(options)
      coll = self.all.limit(options[:per_page]).offset(options[:page] || * options[:per_page])
      coll.instance_variable_set(:@page, options[:page])
      coll.instance_variable_set(:@per_page, options[:per_page])
      coll.instance_variable_set(:@pages, (self.count / options[:per_page]).ceil)
      coll
    end

  end

  module Helpers

    # generates HTML to link between posts
    def will_paginate(collection)
      total_pages = collection.instance_variable_get(:@pages)
      return total_pages
      #return nil if total_pages = 1
      #{}"total_pages"
      #total_pages.each do |page|
      #  content_tag :a

      #  "<%= link_to page, topic_posts_path %>"
      #end
      
    end

  end

end


# @posts = Post.paginate(:page => params[:page])
# will_paginate @posts
# Post.paginate(:page => params[:page], :per_page => 30)

# options[:page]

# # for the Post model
# class Post
#   self.per_page = 10
# end

# # set per_page globally
# WillPaginate.per_page = 10

# module WillPaginate


# num_hash = {a: 1, b: 2, c: 3, d: 4}
# num_hash.fetch(:a)
# page_hash = {:page => params[:page]}
# page_hash.fetch(:page)