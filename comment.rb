Wingsocool = "Wingsocool" # GitHub 用户名
new_token = "aaee449cffcf6aa09575a9cf0f0725a77ac6ccc3"  # GitHub Token
repo_name = "github-comments-repo" # 存放 issues
sitemap_url = "https://Wingsocool.me/sitemap.xml" # sitemap
kind = "Gitalk" # "Gitalk" or "gitment"

require 'open-uri'
require 'faraday'
require 'active_support'
require 'active_support/core_ext'
require 'sitemap-parser'

sitemap = SitemapParser.new sitemap_url
urls = sitemap.to_a

conn = Faraday.new(:url => "https://api.github.com/repos/#{Wingsocool}/#{github-comments-repo}/issues") do |conn|
  conn.basic_auth(Wingsocool, aaee449cffcf6aa09575a9cf0f0725a77ac6ccc3)
  conn.adapter  Faraday.default_adapter
end

urls.each_with_index do |url, index|
  title = open(url).read.scan(/<title>(.*?)<\/title>/).first.first.force_encoding('UTF-8')
  response = conn.post do |req|
    req.body = { body: url, labels: [kind, url], title: title }.to_json
  end
  puts response.body
  sleep 15 if index % 20 == 0
end