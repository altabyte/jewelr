require 'uid_values'

namespace :uid do
  include UidValues

  # ./bin/rake uid:sequence_index
  desc 'Get the current UID sequence index'
  task :sequence_index do
    puts "#{Rails.configuration.uid.index_source} -> #{UidValues.current_uid_index}"
  end


  # ./bin/rake uid:generate_uids
  desc 'Generate UIDs for project'
  task :generate_uids do
    puts 'Generating random UID list...'
    min      = 1_000_000  # Smallest number
    max      = 9_999_999  # Largest number
    path     = Rails.configuration.uid.path
    seed     = Rails.configuration.uid.seed
    per_file = Rails.configuration.uid.per_file

    require 'fileutils'
    FileUtils.mkpath(path)

    time_start = Time.now

    # Create @uids with every sequential value between UID_MIN and UID_MAX
    # unless they contain 3 or more same sequential numbers, eg, 12_333_456
    uids = []
    (min..max).each do |number|
      number_s = number.to_s
      three_same_sequential_numbers = false
      (0..9).each { |i| three_same_sequential_numbers = true and break if number_s =~ /[#{i}]{3}/ }
      unless three_same_sequential_numbers
        uids << number
        print "   Adding: #{number}\r"
      end
    end
    count = uids.count
    total_number_of_files = (count.to_f / per_file).ceil
    time_to_compile_list = (Time.now - time_start).seconds
    puts "\nCompiling a list of #{count} UIDs took #{time_to_compile_list.round.to_i} seconds"

    uids.shuffle!(random: Random.new(seed))
    time_to_shuffle = (Time.now - time_start).seconds - time_to_compile_list
    puts "Randomizing array took #{time_to_shuffle} seconds"
    puts "Total number of files required: #{total_number_of_files}"

    # Export total number of files required minus one.
    # This will ensure each file has exactly UIDS_PER_FILE elements.
    (1..(total_number_of_files)).each do |file_number|
      range = ((per_file * (file_number - 1))...(per_file * file_number))
      open("#{Rails.configuration.uid.file_path(file_number)}", 'w') do |file|
        range.each { |n| file.puts "#{uids[n].to_s.rjust(Rails.configuration.uid.digits, '0')}" if uids[n] }
      end
    end
  end
end
