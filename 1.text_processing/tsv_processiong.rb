#!/usr/bin/ruby

def main(tsv_file)
  lines = open(tsv_file)
  lines.each do |line|
    # 行に対する処理をここに書く
    rows = line.split("\t").map do |cell|
      # セルに関する処理をここに書く
    end
    puts rows.join("\t")
  end
end

if(__FILE__ == $0)
  main(ARGV[0])
end
