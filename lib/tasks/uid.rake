require 'uid/reset'
require 'uid/sequence'

namespace :uid do
  include UID::Reset
  include UID::Sequence

  # ./bin/rake uid:sequence_index
  #
  desc 'Get the current UID sequence index'
  task :sequence_index do
    puts "#{UID.configuration.sequence_source} -> #{UID::Sequence.current_uid_index}"
  end


  # ./bin/rake uid:next
  #
  desc 'Display the next UID and its sequence index value.'
  task :next do
    puts UID::Sequence.next_uid_with_index
  end


  # ./bin/rake uid:reset_sequence_index
  #
  # Reset with a custom value, such as 100.
  # Note "quotes" around rake task to pass arguments!
  #
  # ./bin/rake "uid:reset_sequence_index[100]"
  #
  desc 'Reset the sequence index value back to 1, or to the specified optional argument value'
  task :reset_sequence_index, [:value]  do |_, args|
    begin
      value = (args[:value] || 0).to_i
      value = 1 if value == 0 && UID.configuration.postgres?
      raise "Sequence reset value '#{value}' is not valid!" if value < 0
      STDOUT.print "Are you sure you want to reset #{UID.configuration.sequence_source} sequence index value from #{UID::Sequence.current_uid_index} to #{value} [Yn]  "
      choice = STDIN.gets.chomp.strip
      if !choice.blank? && choice[0].downcase == 'y'
        diff = UID::Reset.reset(value)
        puts "#{UID.configuration.sequence_source.to_s.capitalize} sequence index value RESET from #{diff.first} to #{diff.last}"
      else
        puts "#{UID.configuration.sequence_source.to_s.capitalize} sequence index value remains at #{UID::Sequence.current_uid_index}"
      end
    rescue Exception => e
      puts e.message
    end
  end


  # ./bin/rake uid:generate
  #
  desc 'Generate the UIDs'
  task :generate do
    puts 'Generating random UID list...'
    min            = 1_000_000  # Smallest number
    max            = 9_999_999  # Largest number
    digits         = UID.configuration.digits
    path           = UID.configuration.path
    seed           = UID.configuration.seed || Random.new_seed
    per_file       = UID.configuration.per_file
    file_prefix    = UID.configuration.file_prefix
    file_extension = UID.configuration.file_extension

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

      # Get the path to the file.
      # Copied from /lib/uid/sequence.rb #file_path
      file = "#{path}/#{file_prefix}#{file_number.to_s.rjust(2, '0')}#{file_extension}"

      open(file, 'w') do |f|
        range.each { |n| f.puts "#{uids[n].to_s.rjust(digits, '0')}" if uids[n] }
      end
    end
  end
end
