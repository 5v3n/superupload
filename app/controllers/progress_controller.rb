module SuperUpload
  module ProgressController
    def self.show(env)
      response = SuperUpload::Progress.generate_json_response env
      [200, {"Content-Type" => "application/json"}, [response] ] 
    end
  end
end