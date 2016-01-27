require 'guard/compat/plugin'
require 'guard/delayed_jobs/version'
require 'cocaine'

module Guard
  class DelayedJobs < Plugin
    include DelayedJobsVersion

    # Allowed options are:
    #
    #
    #
    #
    #
    def initialize(opt = {})
      super
      @opt = opt
    end

    def start
      stop

      args = []
      args << '--min-priority :min_priority' if @opt.key?(:min_priority)
      args << '--max-priority :max_priority' if @opt.key?(:max_priority)
      args << '--number_of_workers :number_of_workers' if @opt.key?(:number_of_workers)
      args << '--pid-dir :pid_dir' if @opt.key?(:pid_dir)
      args << '--identifier :identifier' if @opt.key?(:identifier)
      args << '--monitor' if @opt[:monitor]
      args << '--sleep-delay :sleep_delay' if @opt.key?(:sleep_delay)
      args << '--prefix :prefix' if @opt.key?(:prefix)
      keys = [
        :min_priority, :max_priority, :number_of_workers, :pid_dir,
        :identifier, :monitor, :sleep_delay, :prefix
      ]

      Cocaine::CommandLine.new(
        @opt.fetch(:command, 'bin/delayed_job'),
        'start',
        *args
      ).run(
        @opt.select {|k,_| keys.include? k }
      )
    end

    # Called on CTRL-C signal (when Guard quits)
    def stop
      Cocaine::CommandLine.new(
        @opt.fetch(:command, 'bin/delayed_job'),
        'stop'
      ).run
    end

    def restart(*)
      Cocaine::CommandLine.new(
        @opt.fetch(:command, 'bin/delayed_job'),
        'restart'
      ).run
    end

    # Called on CTRL-Z signal
    # This method should be mainly used for 'reload' actions, e.g., reloading
    # passenger, spork, bundler, etc.
    alias reload restart

    # Called on CTRL-/ signal
    # This method should be used for long-running actions, e.g., run full test
    # suite
    alias run_all restart

    # Called on file(s) modifications
    alias run_on_changes restart
  end
end
