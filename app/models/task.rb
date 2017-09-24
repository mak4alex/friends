class Task < ApplicationRecord
  STATUS = {
    :running  => 'RUNNING',
    :stopped => 'STOPPED',
    :error    => 'ERROR'
  }

  MODE_TYPES = {
    :friends_data_update  => 'FRIENDS_DATA_UPDATE',
    :online_status_update => 'ONLINE_STATUS_UPDATE',
    :chart_images_update  => 'CHART_IMAGES_UPDATE'
  }

  after_initialize :set_init_default
  before_create :set_create_default

  def self.mode_type_options
    MODE_TYPES.map { |k, v| [v.humanize, k] }
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
end
