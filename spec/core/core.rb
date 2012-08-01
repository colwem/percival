require 'spec_helper'

class Control < Percival::Controller
  def action a
    true
  end
end

      
describe "Router" do
  before(:each) do 
    @p = Percival::Router
    @msg = double("message")
    @msg.stub(:bot => "bot")
  end
  describe "#self.camelize" do
    it "capitalizes the first letter" do
      @p.camelize( "blah" ).should  == 'Blah'
    end

    it "removes underscores" do
      @p.camelize( "blah_blah" ).should == 'BlahBlah'
    end

    it "capitalizes the letter after underscores" do
      @p.camelize( "ab_yz" ).should == 'AbYz'
    end

    it "downcases all other letters" do
      @p.camelize( 'BLAH' ).should == 'Blah'
    end
    
  end
  
  describe "#draw" do
    it "respond_to draw" do
      Percival::Router.respond_to?(:draw).should be_true
    end

    it "adds a match" do
      Percival::Router.draw do |r|
        r.route 'pattern', controller: :control, action: :action
      end
    end

    it "has nested routes" do
      Percival::Router.draw do |r|
        r.route 'pattern', controller: :control do |r2|
          r2.route 'pattern', controller: :control 
        end
      end
    end

    it "accepts prefixes" do
      Percival::Router.draw do |r|
        r.prefix 'cf', controller: :connect_four do |r|
          r.route 'pattern', action: :action
        end
      end
    end

    it "dispactches" do
      Percival::Router.draw do |r|
        r.route 'pattern', controller: :control, action: :action
      end
      Percival::Router.dispatch(@msg, 'pattern' ).should be_true
    end
    
  end
end


