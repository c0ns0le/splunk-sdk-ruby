require "simplecov"
SimpleCov.start() do
  add_filter("test")
end

require 'test/unit'

$:.unshift File.expand_path(File.join([File.dirname(__FILE__), "..", "lib"]))

def read_splunkrc
  file = File.new(File.expand_path("~/.splunkrc"))
  options = {
      :host => 'localhost',
      :port => 8089,
      :username => 'admin',
      :password => 'changeme',
      :scheme => 'https',
      :version => '5.0'
  }
  file.readlines.each do |raw_line|
    line = raw_line.strip()
    if line.start_with?("\#") or line.length == 0
      next
    else
      raw_key, raw_value = line.split('=', limit=2)
      key = raw_key.strip().intern
      value = raw_value.strip()

      if key == 'port'
        value = Integer(value)
      end

      options[key] = value
    end
  end

  options
end