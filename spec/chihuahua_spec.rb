require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Chihuahua" do
  
  before :all do
    debugger
    Chihuahua.stub(:load_enabled_features_from_yaml_file => [:awesome_feature])
  end
  
  it "tests something" do
    p Chihuahua.enabled_features
  end
end