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
      rescue SocketError, Net::HTTP::Persistent::Error => exc
        log_exc(task.logger, exc)
        sleep 60
      rescue Exception => exc
        log_exc(task.logger, exc)
        task.error
      ensure
        task.cycle_update(start_time)
      end
    end
  end

  def log_exc(logger, exc)
    logger.error(exc.class.name)
    logger.error(exc.message)
    logger.error(exc.backtrace[0..10].join("\n"))
  end
end
