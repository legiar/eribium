require 'spec_helper'
require 'fileutils'

describe Eribium::Application do
  let (:application) do
    Eribium::Application.new.tap do |app|
    end
  end

  it "should have a default load path of ['app/eribium']" do
    application.load_paths.should == [File.expand_path('app/eribium', Rails.root)]
  end

  it "should remove app/admin from the autoload path to remove the possibility of conflicts" do
    ActiveSupport::Dependencies.autoload_paths.should_not include(File.join(Rails.root, "app/eribium"))
  end

  it "should remove app/admin from the eager load paths (Eribium deals with loading)" do
    Rails.application.config.eager_load_paths.should_not include(File.join(Rails.root, "app/eribium"))
  end

  describe "#namespace" do

    it "should yield a new namespace" do
      application.namespace :public do |ns|
        ns.name.should == :public
      end
    end

    it "should return an instantiated namespace" do
      test = application.namespace :public
      test.should == application.namespaces[:public]
    end

    it "should yield an existing namespace" do
      expect {
        application.namespace :admin do |ns|
          ns.should == application.namespaces[:admin]
          raise "found"
        end
      }.to raise_error("found")
    end
  end

  describe "#workspace" do
    it "should resong to #workspace" do
      application.should respond_to :workspace
    end

    it "finds or create the namespace" do
      class Post
      end

      namespace = mock
      application.should_receive(:find_or_create_namespace).with("public").and_return namespace
      application.workspace(Post, namespace: "public")
    end
  end

end
