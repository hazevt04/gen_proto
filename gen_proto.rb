#!/usr/bin/env ruby
 require "erb"

class Program
   attr_accessor :basename
  
   def initialize(basename)
      @basename = basename
   end

   # Expose private binding() method 
   def get_binding
      binding()
   end
end

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
   tprefix = filename.split('.')[0]

   if tsuffix
      tfilename = ziphash["#{tsuffix}"]
      if tfilename
         puts "Template filename is #{tfilename}" if debug

         program = Program.new(tprefix)
         renderer = ERB.new(File.read(tfilename))
         puts output = renderer.result(program.get_binding)

      else
         puts "No template found for #{filename} "
         puts "(Suffix .#{tsuffix} not recognized.)"
      end
   else
      puts "No template for #{filename}"
   end

end

gen_proto
