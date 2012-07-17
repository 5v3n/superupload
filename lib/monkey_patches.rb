=begin 
  We are using unicorn in "non-rewind"-mode. But Rack checks if StreamInput#rewind is 
  present and crashes with an assertion. Let's just give Rack::Lint what it wants. But be sure
  not to be using #rewind anywhere.
=end
module Unicorn
  class StreamInput
    def rewind
      puts "******************* Unicorn::StreamInput#rewind called - which should not happen in this app at all. Go check where it's called from and remove it!"
    end
  end
end