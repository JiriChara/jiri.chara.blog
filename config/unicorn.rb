# unicorn_rails -c config/unicorn.rb -E production -D

root = '/www/jiri.chara.blog/'

rails_env = ENV['RAILS_ENV'] || 'production'

# Sets the working directory for Unicorn. This ensures SIGUSR2 will start a new
# instance of Unicorn in this directory.
working_directory(root)

# Sets the current number of worker_processes.
worker_processes(rails_env == 'production' ? 2 : 1)

# Sets the path for the PID file of the unicorn master process.
pid("#{root}/tmp/pids/unicorn.pid")

stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

# Load rails + blog into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 30

if rails_env == 'production'
  listen 'unix:///tmp/jirichara.sock'
else
  listen '0.0.0.0:3000'
end

pid pid_file = "/www/jiri.chara.blog/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  #
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.
 
  old_pid = pid_file + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  #
  # Unicorn master loads the app then forks off workers - because of the way
  # Unix forking works, we need to make sure we aren't using any of the parent's
  # sockets, e.g. db connection
  ActiveRecord::Base.establish_connection
end
