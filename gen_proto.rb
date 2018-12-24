#!/usr/bin/env ruby


def gen_proto
   valid_suffixes = [
      'rb'
   ]

   debug = true
   
   if ARGV.empty?
      puts "Error: No filename"
      exit
   else
      filename=ARGV[0]
   end
   puts "filename is #{filename}" if debug

   suffix = filename.split('.')[1]

   if suffix.nil?
      puts "No suffix detected in #{filename}"
      exit
   else
      puts "filename suffix is #{suffix}" if debug

      if valid_suffixes.include? suffix
         puts "Suffix #{suffix} is valid" if debug
      else
         puts "Suffix #{suffix} is not valid"
      end
   end

end

gen_proto
