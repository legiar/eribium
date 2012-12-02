require 'spec_helper'

describe Eribium do
  it "should respond to 'config'" do
    Eribium.should respond_to :config
  end

  %w(resource workspace routes).each do |method|
    it "delegates ##{method} to application" do
      Eribium.application.should_receive(method)
      Eribium.send(method)
    end
  end
end
