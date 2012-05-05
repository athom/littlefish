require 'optparse'

module LittleFish
  class Runner
    def initialize(arguments)
      @arguments = arguments
      @demo = LittleFish::Fisher.new
    end
    
    def run
      parse_options
      @demo.pull
    end
    
    private
    
    def parse_options
      options = OptionParser.new 
      options.banner = "Usage: littlefish [options]"
      options.on('-f', '--file FILENAME', "Dumping info into file name by datetime in current directory. NOTE: use '-f no', '-f none', or '-f false' will disable dumping into any file")  { |filename| @demo.dumpfile = filename }
      options.on('-n', '--number NUM', "Pull last x th item  by given num")  { |n| @demo.last_nth_item = n.to_i }
      options.on('-u', '--url URL',   "Redirect the url")     { |url| @demo.url = url }
      options.on('-h', '--help',          "Show this message")          { puts(options); exit }
      options.parse!(@arguments)
    end
  end
end
