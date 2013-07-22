require 'tgate/credentials'

describe Tgate::Credentials, "#amount" do
  it "initiallizes" do
    creds = Tgate::Credentials.new(
      UserName: 111,
      Password: 222)
    creds.UserName.should eq("111")
    creds.Password.should eq("222")
  end
end
