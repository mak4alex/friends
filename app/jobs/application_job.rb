class ApplicationJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    task = job.arguments.first
    start_time = Time.now.to_i
    while task.running? do
      begin
        block.call
        sleep task.delay
      rescue Exception => exc
        Rails.logger.error(exc)
        task.error
      ensure
        task.cycle_update(start_time)
      end
    end
  end
end
