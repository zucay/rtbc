#!/usr/bin/env ruby

require 'csv'

def csv_count_line(path)
    CSV.read(path).count
end

if __FILE__ == $0
    puts csv_count_line(ARGV[0])
end