require 'spec_helper' 

describe Eribium::Namespace do
  let(:application) { Eribium::Application.new }

  context "when new" do
    let(:namespace) { Eribium::Namespace.new(application, :public) }

    it "should have an application instance" do
      namespace.application.should == application
    end

    it "should have a name" do
      namespace.name.should == :public
    end
  end

end
