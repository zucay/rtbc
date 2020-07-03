#!/usr/bin/ruby

require 'open-uri'
require 'pry'

def exec
  url = "https://www.kurunavi.jp/municipality/27.html"
  html = open(url); sleep(1) # 絶対待つ
  html.each do |line| #←FAX：0725-21-0412</td>
    if line =~ /FAX/
      print line
    end
  end
end

if __FILE__ == $0
  exec
end
