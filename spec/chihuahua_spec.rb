require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Chihuahua" do

  before :each do
    Chihuahua.stub(:load_enabled_features_from_yaml_file => [:awesome_feature])
  end

  context '#enabled?' do
    it "returns true when enabled" do
      Chihuahua.enabled?(:awesome_feature)
    end
    it "returns false when disabled" do
      Chihuahua.enabled?(:horrible_feature)
    end
  end

  it "#enable sets enabled properly" do
    Chihuahua.enable(:cool_feature)
    Chihuahua.enabled?(:cool_feature).should be_true
  end

  it "#disable sets enabled properly" do
    Chihuahua.disable(:lame_feature)
    Chihuahua.enabled?(:lame_feature).should be_false
  end

  context "#set" do
    it "sets enabled properly" do
      Chihuahua.set(:lame_feature, false)
      Chihuahua.enabled?(:lame_feature).should be_false
    end
    it "sets disabled properly" do
      Chihuahua.set(:cool_feature, true)
      Chihuahua.enabled?(:cool_feature).should be_true
    end
  end

  it '#reset! resets' do
    Chihuahua.set(:awesome_feature, false)
    Chihuahua.enabled?(:awesome_feature).should be_false
    Chihuahua.reset!
    Chihuahua.enabled?(:awesome_feature).should be_true
  end

end