module SuperUpload
  module CommentsController
    def self.create(env)
      comment = SuperUpload::Comment.generate env
      [200, {"Content-Type" => "text/html" }, [%|Thanks for submitting #{comment[:title]} - it's stored at <a href="#{comment[:path]}">#{comment[:path]}</a>. You were all like: "#{comment[:text]}"|] ]
    end
  end
end