class Task < ApplicationRecord
  STATUS = {
    :running  => 'RUNNING',
    :stopped => 'STOPPED',
    :error    => 'ERROR'
  }

  attr_accessor :logger

  after_initialize :set_init_default
  before_create :set_create_default

  def self.mode_type_options
    mode_types.map { |k, v| [v.humanize, k] }
  end

  def self.job_files
    Dir.entries(jobs_file_path).select { |j| j =~ /_job\.rb$/ && j != 'application_job.rb' }
  end

  def self.jobs_file_path
    File.join(Rails.root, 'app', 'jobs')
  end

  def self.mode_types
    Task.job_files.map { |jf| jf.gsub(/\_job.rb$/,'') }.inject({}) do |hash, job_name|
      hash[job_name.to_sym] = job_name.upcase
      hash
    end
  end

  def start
    self.update_attribute(:status, Task::STATUS[:running])
    get_job_class.set(wait: 1.second).perform_later(self)
  end

  def running?
    self.reload
    self.status == STATUS[:running]
  end

  def stop
    self.update_attribute(:status, Task::STATUS[:stopped])
  end

  def error
    self.update_attribute(:status, Task::STATUS[:error])
  end

  def get_job_class
    "#{self.mode_type}_job".camelize.constantize
  end

  def cycle_update(start_time)
    self.reload
    self.increment!(:duration, Time.now.to_i - start_time)
    self.increment!(:cycle_count)
  end

  def set_init_default
    self.name  ||= "New task #{Time.now}"
    self.delay ||= 15
  end

  def set_create_default
    self.status = STATUS[:stopped]
    self.duration = self.cycle_count = 0
  end

  def set_logger
    @logger = Logger.new(Rails.root.join('log', "#{self.mode_type}.log"), File::APPEND)
    @logger.formatter = Logger::Formatter.new
    @logger
  end
end
