class ApplicationJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    task = job.arguments.first
    while task.running? do
      start_time = Time.now.to_i
      begin
        block.call
      rescue Exception => exc
        task.log.error(exc.class.name)
        task.log.error(exc.message)
        task.log.error(exc.backtrace[0..10].join("\n"))
        task.sleep(30)
      ensure
        task.cycle_update(start_time)
      end
      task.delay > 0 ? task.sleep : task.stop
    end
  end
end
