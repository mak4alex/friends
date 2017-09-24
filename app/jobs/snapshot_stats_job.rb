class SnapshotStatsJob < ApplicationJob
  def perform(*args)
    puts "Job runnig here..."
  end
end
