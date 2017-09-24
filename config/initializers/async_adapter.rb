Rails.application.config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new({
  min_threads: 2,
  max_threads: 2 * Concurrent.processor_count,
  idletime: 600.seconds
})
