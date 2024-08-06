# frozen_string_literal: true

# PattentJob main logic
class PatentJob
  attr_reader :downloader

  def initialize(downloader = PatentJobDownloader.new)
    @downloader = downloader
  end

  def run
    temp = downloader.download_file
    rows = parse(temp)
    update_patents(rows)
  end

  def parse(temp)
    FasterCSV.read(temp, headers: true)
  end

  def update_patents(rows)
    Patent.connection.transaction do
      Patent.delete_all
      rows.each { |r| Patent.create!(r.to_hash) }
    end
  end
end

# Downloader
class PatentJobDownloader
  def download_file
    temp = Tempfile.new('patents')
    tempname = temp.path
    temp.close

    Net::FTP.open('localhost', 'foo', 'foopw') do |ftp|
      ftp.getbinaryfile('Public/prod/patents.csv', tempname)
    end

    tempname
  end
end

# ==============================================================================
# Split PatentConfig

class PatentConfig
  attr_reader :env

  def initialize(env = Rails.env)
    @env = env
  end

  def ftp_host
    'localhost'
  end

  def ftp_path
    "Public/" (env == 'production' ? 'prod' : 'test')
  end
end

# => Hmm, there are no absaction for above code

# ==============================================================================

# patent.yml
defaults: &defaults
  ftp_host: localhost
  ftp_user: foo
  ftp_password: foopw
  ftp_filename: patents.csv
  ftp_path: Public/test

test:
  <<: *defaults

production:
  ftp_path: Public/prd
  <<: *defaults

development:
  <<: *defaults

# patent_config.rb
class PatentConfig
  attr_reader :env, :data

  def initialize(env = Rails.env)
    @env = env
    @data = YAML::load_file('config/patent.yml')
  end

  def ftp_host
    data[env]['ftp_host']
  end

  def ftp_path
    data[env]['ftp_path']
  end
end

# => This class is not DRY with prefix ftp function

# ==============================================================================
class Config
  attr_reader :env, :data

  def self.config_path
    File.join("config", "external_resources")
  end

  def initialize(opts)
    @env = opts[:env] ||= Rails.env
    filename = opts[:filename]
    @data = YAML::load_file(File.join(self.class.config_path, filename))
    defnine_methods_for_environment(data[env].keys)
  end

  def define_methods_for_environment(names)
    names.each do |key|
      class_eval <<-EOS
        def #{name}
          data[env]['#{name}']
        end
      EOS
    end
  end
end

class FtpDownloader
  attr_reader :config

  def initialize(config = Config.new(filename: 'patent.yml'))
    @config = config
  end

  def download_file
    temp = Tempfile.new(config.ftp_filename)
    tempname = temp.path
    temp.close

    Net::FTP.open(config.ftp_host, config.ftp_user, config.ftp_password) do |ftp|
      ftp.getbinaryfile("#{config.ftp_path}/#{config.ftp_filename}", tempname)
    end

    tempname
  end
end

class PatentJob
  attr_reader :downloader

  def initialize(downloader = FtpDownloader.new)
    @downloader = downloader
  end

  def run
    temp = downloader.download_file
    rows = parse(temp)
    update_patents(rows)
  end

  def parse(temp)
    FasterCSV.read(temp, headers: true)
  end

  def update_patents(rows)
    Patent.connection.transaction do
      Patent.delete_all
      rows.each { |r| Patent.create!(r.to_hash) }
    end
  end
end

# This code has a problem. FtpDownloader knows the default filename for the patent.yml file.
# If you put an object more likely will change on an object less likely to change, you are asking for trouble.
# An object is less changing, but you put a dependency, which is more likely to change on it => Bad idea
# ==============================================================================
class PatentJob
  attr_reader :downloader

  def initialize(opts)
    config = opts[:config] ||= Config.new(filename: 'patent.yml')
    @downloader = opts[:downloader] ||= FtpDownloader.new(config) # This can be changed to: config.downloader_class.constantize.new(config)
  end

  def run
    temp = downloader.download_file
    rows = parse(temp)
    update_patents(rows)
  end

  def parse(temp)
    FasterCSV.read(temp, headers: true)
  end

  def update_patents(rows)
    Patent.connection.transaction do
      Patent.delete_all
      rows.each { |r| Patent.create!(r.to_hash) }
    end
  end
end

class FtpDownloader
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def download_file
    temp = Tempfile.new(config.ftp_filename)
    tempname = temp.path
    temp.close

    Net::FTP.open(config.ftp_host, config.ftp_user, config.ftp_password) do |ftp|
      ftp.getbinaryfile("#{config.ftp_path}/#{config.ftp_filename}", tempname)
    end

    tempname
  end
end
