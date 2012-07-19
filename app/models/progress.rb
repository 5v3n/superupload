module SuperUpload
  class Progress
    def self.generate_json_response(env)
      sid = 'unknown'
      query_hash = CGI.parse(env["QUERY_STRING"])
      sid = query_hash["sid"].first if query_hash["sid"]
      progress = SuperUpload::FileManager.find_upload_progress(sid) || 0
      if path = SuperUpload::FileManager.find_path(sid)
        response = "{\"progress\": #{progress}, \"path\": \"#{path}\"}"
      else
        response = "{\"progress\": #{progress}}"
      end
      return response
    end
  end
end