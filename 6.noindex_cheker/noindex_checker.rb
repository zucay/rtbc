#!/usr/bin/ruby
require 'open-uri'

def check_noindex_and_canonical(url)
  html = open(url)
  canonical = ''
  noindex = ''
  html.each do |line|
    if line =~ /noindex/
      noindex = line
    end
    if line =~ /canonical/
      canonical = line
    end
  end
  print "#{url}\t#{noindex}\t#{canonical}"
end

def check_noindex_and_canonical_file(file)
  File.open(file).each do |line|
    check_noindex_and_canonical(line.strip)
    sleep(1) # 一気にアクセスしちゃだめ
  end
end


if __FILE__ == $0
  check_noindex_and_canonical_file(ARGV[0])
  print 'done'
end
