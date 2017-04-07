module Jekyll
  class Post
    def tags
      @tags + data.pluralized_array("category", "categories")
    end
  end
end
