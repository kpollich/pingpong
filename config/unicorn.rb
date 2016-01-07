# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/var/www/pingpong"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/www/pingpong/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/var/www/pingpong/log/unicorn.log"
stdout_path "/var/www/pingpong/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.pingpong.sock"
listen "/tmp/unicorn.myapp.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
