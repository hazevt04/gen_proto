#!/usr/bin/env ruby


def gen_proto
   valid_suffixes = [
      "rb",
      "cpp",
   ]
   templates = [
      "rb.erb",
      "cpp.erb",
   ]
 

   debug = true

   if ARGV.empty?
      puts "Error: No filename"
      exit
   else
      filename=ARGV[0]
   end
   puts "filename is #{filename}" if debug

   t_map = valid_suffixes.each_with_index.map{ |suffix, idx| [suffix, templates[idx]] }

end

gen_proto
