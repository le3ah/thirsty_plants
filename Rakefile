# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
task :rainy_day => :environment do
  RainyDayJob.set.perform_now(:just_set_up)
  puts "let the texting begin"
end

task :generate_waterings => :environment do
  Scheduler.generate_waterings(:one_week_from_today)
end
