require 'spec_helper'
require 'activerecord-import-queue.rb'

describe 'lib/activerecord-import-queue.rb' do

  before(:each) do
    @importer = ActiveRecordImportQueue.new
    @new_object = Struct.new(:dummy)
  end

  describe "a new instance" do

    it "should have no pending objects" do
      expect(@importer.count_pending).to eql(0)
    end

  end

  describe "<<" do

    it "should place a new ActiveRecord object on the queue" do
      @importer << @new_object
      expect(@importer.instance_eval { @pending }).to eql({ Class => [@new_object] })
    end

    it "should not overwrite the queue when adding a new object" do
      @importer << @new_object
      @importer << @new_object
      expect(@importer.instance_eval { @pending }).to eql({ Class => [@new_object, @new_object] })
    end

    it "should increment the number of pending objects by 1" do
      @importer << @new_object
      expect(@importer.instance_eval { @count }).to eql(1)
    end

  end

  describe "finish" do

    it "should call the 'import' method for all pending objects"

    it "should reset the pending queue after processing objects" do
      pending
      @importer << @new_object
      expect(@importer.finish).to eql({})
      expect(@importer.instance_eval { @count }).to eql(0)
      expect(@importer.instance_eval { @pending }).to eql({ Class => [] })
    end

  end

  describe "incr_count" do

    it "should increment the pending object count by 1" do
      @importer.instance_eval { incr_count }
      expect(@importer.instance_eval { @count }).to eql(1)
    end

  end

  describe "decr_count" do

    it "should decrement the pending object count by 1" do
      @importer.instance_eval { incr_count }
      @importer.instance_eval { incr_count }
      @importer.instance_eval { decr_count }
      expect(@importer.instance_eval { @count }).to eql(1)
    end

  end

end

