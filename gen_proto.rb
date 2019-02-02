#!/usr/bin/env ruby
 require "erb"

class Program
   attr_accessor :basename
   attr_accessor :classname
   attr_accessor :header_defines

   def initialize(filename)
      basename = filename.split('.').first
      @basename = basename
      @classname = basename.slice(0,1).capitalize + basename.slice(1..-1)
      @header_defines = '_' + basename.gsub('.','_').upcase + '_H_'
   end

   # Expose private binding() method 
   def get_binding
      binding()
   end
end

def gen_proto
   valid_suffixes = [
      "class_cpp",
      "class_h",
      "cpp",
      "rb"
   ]
   templates = [
      "class_cpp.erb",
      "class_h.erb",
      "cpp.erb",
      "rb.erb"
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

   tsuffix = filename.split('.').last

   if tsuffix
      tfilename = "templates/" + ziphash["#{tsuffix}"]
      if tfilename
         puts "Template filename is #{tfilename}" if debug

         program = Program.new(filename)
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
