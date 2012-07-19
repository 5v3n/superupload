require 'erb'

module SuperUpload
  module CommentsController
    def self.create(env)
      comment = SuperUpload::Comment.generate env
      template = ERB.new(File.read('./app/views/comments/show.erb'))
      [200, {"Content-Type" => "text/html"}, [template.result(binding)]]
    end
  end
end