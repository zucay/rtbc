#!/usr/bin/ruby

def main(tsv_file)
  lines = open(tsv_file)
  lines.each do |line|
    # 行に対する処理をここに書く
    line = line.gsub(/aaa/, 'bbb') # aaaをbbbに置換する
    puts(line)
  end
end

if(__FILE__ == $0)
  main(ARGV[0])
end
