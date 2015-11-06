require 'scatter_swap'
require 'uid/reset'
require 'uid/sequence'

namespace :uid do
  include UID::Reset
  include UID::Sequence


  namespace :sequence_7 do

    # ./bin/rake uid:sequence_7:index
    #
    desc 'Get the current UID sequence index'
    task :index do
      puts "#{UID.configuration.sequence_source} -> #{UID::Sequence.uid_current_index(UID.configuration.sequence_7_name)}"
    end


    # ./bin/rake uid:sequence_7:next
    #
    desc 'Display the next UID and its sequence index value.'
    task :next do
      puts UID::Sequence.uid_next_with_index(UID.configuration.sequence_7_name)
    end


    # ./bin/rake uid:sequence_7:reset_index[100]
    #
    desc 'Reset the sequence index value back to 1, or to the specified optional argument value'
    task :reset_index, [:value]  do |_, args|
      value = (args[:value] || 0).to_i
      reset_sequence_index(UID.configuration.sequence_7_name, value)
    end


    # ./bin/rake uid:sequence_7:hash[123]
    #
    desc 'Hash the given value for this sequence'
    task :hash, [:value]  do |_, args|
      value = (args[:value] || 0).to_i
      result = ScatterSwap.hash(value, UID.configuration.sequence_7_seed, 7)
      puts "Sequence 7:  #{value} -> #{result}"
    end


    # ./bin/rake uid:sequence_7:reverse[123]
    #
    desc 'Hash the given value for this sequence'
    task :reverse, [:value]  do |_, args|
      value = (args[:value] || 0).to_i
      result = ScatterSwap.reverse_hash(value, UID.configuration.sequence_7_seed, 7).to_i
      puts "Sequence 7 reverse:  #{value} -> #{result}"
    end
  end


  namespace :sequence_9 do

    # ./bin/rake uid:sequence_9:index
    #
    desc 'Get the current UID sequence index'
    task :index do
      puts "#{UID.configuration.sequence_source} -> #{UID::Sequence.uid_current_index(UID.configuration.sequence_9_name)}"
    end


    # ./bin/rake uid:sequence_9:next
    #
    desc 'Display the next UID and its sequence index value.'
    task :next do
      puts UID::Sequence.uid_next_with_index(UID.configuration.sequence_9_name)
    end


    # ./bin/rake uid:sequence_9:reset_index[100]
    #
    desc 'Reset the sequence index value back to 1, or to the specified optional argument value'
    task :reset_index, [:value]  do |_, args|
      value = (args[:value] || 0).to_i
      reset_sequence_index(UID.configuration.sequence_9_name, value)
    end


    # ./bin/rake uid:sequence_9:hash[123]
    #
    desc 'Hash the given value for this sequence'
    task :hash, [:value]  do |_, args|
      value = (args[:value] || 0).to_i
      result = ScatterSwap.hash(value, UID.configuration.sequence_9_seed, 9)
      puts "Sequence 9:  #{value} -> #{result}"
    end


    # ./bin/rake uid:sequence_9:reverse[123]
    #
    desc 'Hash the given value for this sequence'
    task :reverse, [:value]  do |_, args|
      value = (args[:value] || 0).to_i
      result = ScatterSwap.reverse_hash(value, UID.configuration.sequence_9_seed, 9).to_i
      puts "Sequence 9 reverse:  #{value} -> #{result}"
    end
  end

  #---------------------------------------------------------------------------
  private

  def reset_sequence_index(sequence_name, value)
    begin
      value = 1 if value == 0 && UID.configuration.postgres?
      raise "Sequence reset value '#{value}' is not valid!" if value < 0
      STDOUT.print "Are you sure you want to reset #{UID.configuration.sequence_source} sequence '#{sequence_name}' index value from #{UID::Sequence.current_index(sequence_name)} to #{value} [Yn]  "
      choice = STDIN.gets.chomp.strip
      if !choice.blank? && choice[0].downcase == 'y'
        diff = UID::Reset.reset(sequence_name, value)
        puts "#{UID.configuration.sequence_source.to_s.capitalize} sequence '#{sequence_name}' index value RESET from #{diff.first} to #{diff.last}"
      else
        puts "#{UID.configuration.sequence_source.to_s.capitalize} sequence '#{sequence_name}' index value remains at #{UID::Sequence.current_index(sequence_name)}"
      end
    rescue Exception => e
      puts e.message
    end
  end
end
