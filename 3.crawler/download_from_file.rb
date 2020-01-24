#!/usr/bin/ruby

require 'open-uri'
require 'fileutils'

def download_from_file(file)
  download_dir = File.join(File.dirname(file), "download_#{Time.now.strftime('%Y%m%d%H%M%S')}")
  FileUtils.mkdir_p(download_dir)
  open(file).each do |line|
    url = /(http[^\#\s]*)(\#)*/.match(line).to_a.values_at(1)[0]

    if url
      puts url
      download_path = File.join(download_dir, File.basename(url))
      begin
        download_from_url(url, download_path)
      rescue => e
        puts e.to_s
      end
    end
  end
end

def download_from_url(url, download_path)
  downlad_path ||= File.basename(url)
  open(download_path, 'w') do |f|
    f.write(open(url).read)
  end
  sleep(2)
end

if __FILE__ == $0
  download_from_file(ARGV[0])
end
