module SuperUpload
  module CommentsController
    def self.create(env)
      request     = Rack::Request.new env
      query_hash  = CGI.parse(env["QUERY_STRING"])
      sid         = query_hash["sid"].first if query_hash["sid"]
      path        = SuperUpload::FileManager.find_path(sid)
      title       = path.split('/').last if path
      comment     = request.params["comment"]
      [200, {"Content-Type" => "text/html" }, [%|Thanks for submitting #{title} - it's stored at <a href="#{path}">#{path}</a>. You were all like: "#{comment}"|] ]
    end
  end
end