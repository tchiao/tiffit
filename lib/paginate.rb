module Paginate

  extend ActiveSupport::Concern


  module ClassMethods

    # returns specified subset of posts/topics
    def paginate(options)
      coll = self.all.limit(options[:per_page]).offset( nil || (options[:page].to_i - 1) * options[:per_page])
      coll.instance_variable_set(:@page, options[:page])
      coll.instance_variable_set(:@per_page, options[:per_page])
      coll.instance_variable_set(:@pages, (self.all.count.to_f / options[:per_page]).ceil)
      coll
    end

  end

  module Helpers

    # generates HTML to link between posts
    def will_paginate(collection)
      total_pages = collection.instance_variable_get(:@pages)
      current_url = url_for(:only_path => false)

      return nil if total_pages == 1
      array = []
      1.upto(total_pages) do |num|
        array << link_to(num, (current_url + "?page=" + num.to_s))
      end

      array.join(" ").html_safe      
    end

  end

end

# @posts = Post.paginate(:page => params[:page])
# will_paginate @posts
# @posts = Post.paginate(:page => params[:page], :per_page => 30)