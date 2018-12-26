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
 
   zip = valid_suffixes.zip(templates)
   ziphash = Hash[zip]

   debug = false

   if ARGV.empty?
      puts "Error: No filename"
      exit
   else
      filename=ARGV[0]
   end
   puts "filename is #{filename}" if debug

   tsuffix = filename.split('.')[1]
   
   if tsuffix
      tfilename = ziphash["#{tsuffix}"]
      if tfilename
         puts "template filename is #{tfilename}"
      else
         puts "No template found for #{filename} "
         puts "(Suffix .#{tsuffix} not recognized.)"
      end
   else
      puts "No template for #{filename}"
   end

end

gen_proto
