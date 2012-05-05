require 'spec_helper'

describe LittleFish do
  it 'should return info and dump file in a pulling' do
   #TODO  for somereason open-uri is not availble in spec
   # fisher  = LittleFish::Fisher.new  do |f|
   #   f.dumpfile = 'spec_test.txt'
   # end
   # info = fisher.pull
   # info.should_not be_nil
    #File.exist?('spec_test.txt').should be_true
    #File.delete 'spec_test.txt'
  end
end 
