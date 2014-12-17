require_relative '../spec_helper.rb'
require 'byebug'
require 'yourub'

describe Yourub::Client do


  it "initialize a client through the config file" do
    Yourub::Config.stub(:developer_key).and_return('secret')
    Yourub::Config.stub(:application_name).and_return('youtube')
    Yourub::Config.stub(:application_version).and_return(10)

    client = Yourub::Client.new()
    expect(client.config.developer_key).to eq('secret')
    expect(client.config.application_name).to eq('youtube')
    expect(client.config.application_version).to eq(10)
  end

  it "initialize the client accepting an hash of option" do
      options = {developer_key: "Super",
                 application_name: "yourub", 
                 application_version: 2.0, 
                 log_level: 3}

      client = Yourub::Client.new(options)
      expect(client.config.developer_key).to eq('Super')
      expect(client.config.application_name).to eq('yourub')
      expect(client.config.application_version).to eq(2.0)
  end

  it "use a default for the log level, if not provided" do
     options = { developer_key: "Super"}
     client = Yourub::Client.new(options)
     expect(client.config.log_level).to eq("WARN")
  end

  it "does not raise an argument error if a config file is not present" do
  end

  it "raise an argument error if there is no way to obtain config infos" do
    options = {application_name: 'my app'}
    expect(lambda{Yourub::Client.new(options)}).to raise_error(ArgumentError)
  end

end
