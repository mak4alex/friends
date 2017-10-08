class ApplicationJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    task = job.arguments.first
    task.set_logger
    start_time = Time.now.to_i
    while task.running? do
      begin
        block.call
        task.delay > 0 ? sleep(task.delay) : task.stop
      rescue Exception => exc
        task.logger.error(exc.message)
        task.logger.error(exc.backtrace[0..10].join("\n"))
        task.error
      ensure
        task.cycle_update(start_time)
      end
    end
  end
end
