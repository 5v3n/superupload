worker_processes 4      # amount of unicorn workers to spin up
timeout 120             # restarts workers that hang for 30 seconds
rewindable_input false  # our ticket to streaming upload country: passes env[rack.input] without fully reading it first.