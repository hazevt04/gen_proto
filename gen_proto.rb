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
      "class.cpp",
      "class.h",
      "cpp",
      "rb",
      "py",
      "c"
   ]
   templates = [
      "class.cpp.erb",
      "class.h.erb",
      "cpp.erb",
      "rb.erb",
      "py.erb",
      "c.erb"
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

   if filename.split('.').size == 2
      tsuffix = filename.split('.')[1] 
   elsif filename.split('.').size == 3
      tsuffix = filename.split('.')[1] + "." + filename.split('.')[2] 
   end

   if tsuffix
      puts "tsuffix is #{tsuffix}" if debug
      tfilename = ziphash["#{tsuffix}"]
      if tfilename
         tfilepath = __dir__ + "/templates/" + tfilename
         puts "Template file path is #{tfilepath}" if debug

         program = Program.new(filename)
         renderer = ERB.new(File.read(tfilepath))
         puts output = renderer.result(program.get_binding)
      end
   end

end

gen_proto
