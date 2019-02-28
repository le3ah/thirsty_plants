# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
task :rainy_day_texts => :environment do
  num_texts = RainyDayJob.set.perform_now
  puts "#{num_texts} texts sent"
end

task get_weather_data: :environment do
  Weather.get_all_weather_data
  puts "Weather data set!"
end

task :generate_waterings => :environment do
  Scheduler.generate_waterings_for_a_week_from_today
  puts "waterings generated"
end

task :notify_missing_waterers => :environment do
  UnwateredNotifierJob.perform_later
end
