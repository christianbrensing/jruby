require File.expand_path('../../../spec_helper', __FILE__)

describe "Regexp#to_s" do
  it "displays options if included" do
     /abc/mxi.to_s.should == "(?mix:abc)"
   end

   it "shows non-included options after a - sign" do
     /abc/i.to_s.should == "(?i-mx:abc)"
   end

   it "shows all options as excluded if none are selected" do
     /abc/.to_s.should == "(?-mix:abc)"
   end

   it "shows the pattern after the options" do
     /ab+c/mix.to_s.should == "(?mix:ab+c)"
     /xyz/.to_s.should == "(?-mix:xyz)"
   end

   it "displays groups with options" do
     /(?ix:foo)(?m:bar)/.to_s.should == "(?-mix:(?ix:foo)(?m:bar))"
     /(?ix:foo)bar/m.to_s.should == "(?m-ix:(?ix:foo)bar)"
   end

  it "displays single group with same options as main regex as the main regex" do
    /(?i:nothing outside this group)/.to_s.should == "(?i-mx:nothing outside this group)"
  end

  it "deals properly with uncaptured groups" do
    /whatever(?:0d)/ix.to_s.should == "(?ix-m:whatever(?:0d))"
  end

  it "deals properly with the two types of lookahead groups" do
    /(?=5)/.to_s.should == "(?-mix:(?=5))"
    /(?!5)/.to_s.should == "(?-mix:(?!5))"
  end

  it "returns a string in (?xxx:yyy) notation" do
    /ab+c/ix.to_s.should == "(?ix-m:ab+c)"
    /jis/s.to_s.should == "(?-mix:jis)"
    /(?i:.)/.to_s.should == "(?i-mx:.)"
    /(?:.)/.to_s.should == "(?-mix:.)"
  end

  it "handles abusive option groups" do
    /(?mmmmix-miiiix:)/.to_s.should == '(?-mix:)'
  end

end
