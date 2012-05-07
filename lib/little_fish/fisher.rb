require 'rss/1.0'
require 'rss/2.0'
require 'nokogiri'
require 'open-uri'
require 'timeout'
require 'net/http'

module LittleFish
  class Fisher
    attr_accessor :url, :last_nth_item, :dumpfile, :download
    def initialize
      if block_given?
        yield self
      else
        @url = 'http://feeds.boston.com/boston/bigpicture/index'
        @last_nth_item = 0
        @dumpfile = './pic_output_' + Time.now.strftime('%H-%M-%S') + '.txt'
        @download = false
      end
    end

    def pull
      info 'opening URI ... '
      rss_string = open_url(@url)

      info 'parsing doc from text ... '
      doc  = get_doc(rss_string, @last_nth_item)

      info 'filling doc into bp_info ... '
      bp_info  = get_bp_info(doc)

      unless ['none', 'NONE', 'no', 'NO', 'false', 'FALSE'].include? @dumpfile
        info 'dumping bp_info ... '
        f = File.new(@dumpfile, 'w') 
        bp_info[:images].each do |img|
          f.puts img
        end
        info 'saved info in ' +  @dumpfile
      end

      if @download
        info 'down loading photos ... '
        urls = bp_info[:images].map{|img| img[:url]}
        download(urls, 'lf_download')
        info 'photos downloaded!'
      end

      bp_info
    end

    private 
    def info(str)
      puts "LittleFish(INFO): " + str
    end

    def warning(str)
      puts "LittleFish(WARNING): " + str
    end

    def error(str)
      puts "LittleFish(ERROR): " + str
    end

    def open_url(uri)
      retries = 3
      begin
        Timeout::timeout 10 do
          rss_string = open(@url).read
        end
      rescue Timeout::Error
        retries -= 1
        if retries > 0
          warning 'retrying .. '
          sleep 2 and retry
        else
          error "can not open url: #{@url}"
          raise
        end
      end
    end

    def get_doc(rss_str, n)
      rss = nil
      begin
        Timeout::timeout 10 do
          rss = RSS::Parser.parse(rss_str, false) 
        end
      rescue
        retries -= 1
        if retries > 0
          warning 'retrying .. '
          sleep 2 and retry
        else
          error 'cat not parse rss, maybe try it again'
          raise
        end
      end
      link = rss.items[n].link 
      doc = Nokogiri::HTML(open(link))
    end

    def get_bp_info(doc)
      bp_info = {}
      total_desc =  doc.css('.bpBody').children.first.content
      bp_info[:total_desc]=total_desc

      img_list = []
      top =  doc.css('.bpImageTop').children.children
      img_url =  top.first.attributes['src'].value
      img_info =  top[1].content
      img_list << { img_url => img_info } 

      both =  doc.css('.bpBoth')
      both.each do |e|
        img_url =  e.children[1].attributes['src'].value
        img_info = e.children.last.content
        img_list << { :url =>img_url, :desc => img_info }
      end
      bp_info[:images] = img_list
      bp_info
    end

    def download (urls, dir)
      Dir.mkdir(dir) unless Dir.exists? dir
      urls.each do |url|
        `wget -c #{url} -P #{dir}`
      end
    end
  end
end
