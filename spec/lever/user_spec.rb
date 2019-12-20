RSpec.describe Lever::User do
  describe '#initialize' do
    it "works" do
      parsed_response = {
        "id" =>  SecureRandom.uuid.to_s,
        "name" => "John Smith",
        "username" => "john.smith",
        "email" => "john.smith@example.com",
        "accessRole" => "super admin",
        "photo" => 
          "https://johnsmith.photo",
        "createdAt" => 1569274341083,
        "deactivatedAt" => nil,
        "externalDirectoryId" => nil
      }

      user = Lever::User.new(parsed_response)
      expect(user.name).to eql("John Smith")
    end
  end
end
