module SuperUpload
  class Comment
    def self.generate(env)
      request     = Rack::Request.new env
      query_hash  = CGI.parse(env["QUERY_STRING"])
      sid         = query_hash["sid"].first if query_hash["sid"]
      path        = SuperUpload::FileManager.find_path(sid)
      title       = path.split('/').last if path
      text     = request.params["comment"]
      return {:path => path, :title => title, :text => text}
    end
  end
end