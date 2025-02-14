#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'uri'
require 'tempfile'
require 'fileutils'

GITHUB_REPO = "max-niederman/ttyper"
FORMULA_PATH = "ttyper.rb"  # Adjust this path as needed

def fetch_with_redirect(uri_str)
  uri = URI(uri_str)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')
  
  response = http.get(uri.request_uri)
  
  if response.code == "302" || response.code == "301"
    return fetch_with_redirect(response['location'])
  end
  
  response
end

def fetch_latest_release
  uri = URI("https://api.github.com/repos/#{GITHUB_REPO}/releases/latest")
  response = fetch_with_redirect(uri)
  
  if response.code == "200"
    JSON.parse(response.body)
  else
    raise "Failed to fetch release info: #{response.code} #{response.message}"
  end
end

def download_and_verify_sha(asset)
  sha_asset = asset['name'] + '.sha256'
  sha_url = asset['browser_download_url'] + '.sha256'
  
  response = fetch_with_redirect(URI(sha_url))
  
  if response.code == "200"
    content = response.body
    return content.strip.split(' ').first # Get just the hash part
  else
    puts "Warning: Failed to download SHA for #{asset['name']}: #{response.code} #{response.message}"
    return nil
  end
end

def update_formula
  release = fetch_latest_release
  version = release['tag_name'].sub(/^v/, '')
  
  # Map of asset patterns to their formula identifiers
  asset_mappings = {
    'aarch64-apple-darwin' => 'PLACEHOLDER_SHA_AARCH64_DARWIN',
    'x86_64-apple-darwin' => 'PLACEHOLDER_SHA_X86_64_DARWIN',
    'x86_64-unknown-linux-musl' => 'PLACEHOLDER_SHA_X86_64_LINUX_MUSL',
    'i686-unknown-linux-musl' => 'PLACEHOLDER_SHA_I686_LINUX_MUSL',
    'aarch64-unknown-linux-musl' => 'PLACEHOLDER_SHA_AARCH64_LINUX_MUSL',
    'arm-unknown-linux-musleabihf' => 'PLACEHOLDER_SHA_ARM_LINUX_MUSL'
  }
  
  shas = {}
  
  # Process each asset from the release
  release['assets'].each do |asset|
    next unless asset['name'].end_with?('.tar.gz')
    
    asset_mappings.each do |pattern, placeholder|
      if asset['name'].include?(pattern)
        sha = download_and_verify_sha(asset)
        shas[placeholder] = sha if sha
      end
    end
  end
  
  # Read current formula
  formula_content = File.read(FORMULA_PATH)
  
  # Update version
  formula_content.gsub!(/version "[^"]+"/, "version \"#{version}\"")
  
  # Update SHA256 values
  shas.each do |placeholder, sha|
    formula_content.gsub!(/#{placeholder}/, sha)
  end
  
  # Write updated formula
  File.write(FORMULA_PATH, formula_content)
  puts "Formula updated to version #{version}"
  puts "\nUpdated SHA256 values:"
  shas.each do |placeholder, sha|
    puts "#{placeholder}: #{sha}"
  end
end

begin
  update_formula
rescue => e
  puts "Error updating formula: #{e.message}"
  puts e.backtrace
  exit 1
end
