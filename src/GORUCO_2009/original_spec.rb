# frozen_string_literal: true

describe PatentJob do
  it 'should download the csv file from the ftp server' do
  end

  it 'should replace existing patents with new patents' do
    downldr = mock('Downloader')
    f = "#{fixture_path}/patents.csv"
    downldr.should_receive(:download_file).once.and_return(f)
    @job = PatentJob.new(downldr)
    @job.run
    Patent.find(:all).size.should
    Patent.find_by_name('Anti-Gravity Simulator').should_not be_nil
    Patent.find_by_name('Exo-Skello Jello').should_not be_nil
    Patent.find_by_name('Nap Compressor').should_not be_nil
  end
end
