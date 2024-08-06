# frozen_string_literal: true

RSpec.describe PatentDownloader do
  describe do
    it "should download the csv file from the ftp server" do
      upload_test_file('localhost', 'foo', 'foopw', 'patents.csv', 'Public/test')

      @conn = PatentDownloader.new
      f = File.read(@conn.download_file)
      f.should have(250).characters
      f.include?("just 3 minutes").should be_true
    end
  end
end
