require "open-uri"
require "nokogiri"
require "./lib/position"

positionUrl = "https://www.jobnet.com.mm/jobs-in-myanmar"

document = open(positionUrl)
content = document.read
position_data = Nokogiri::HTML(content).css(".hero-wrapper").css(".select-wrapper").first
  .css("option")

positionList = Array.new
jobDetailUrlList = Array.new

puts "
+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+
|J|o|b|s| |W|e|b| |S|c|r|a|p|p|e|r|
+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+
"

# position_data.each_with_index do |positionRow, index|
#   posTitle = positionRow.inner_html
#   if index > 0
#     positionList << Position.new(posTitle)
#     puts "#{index} | #{jobTitle}"
#   end
# end

# puts "Choose Above Position"
# positionValue = gets

# jobUrl = "https://www.jobnet.com.mm/jobs-in-myanmar?jobfunction=#{positionValue}"
# job_document = open(jobUrl)
# job_content = job_document.read
# job_data = Nokogiri::HTML(job_content).css(".serp-results-items-wrapper").css(".serp-results-items")
#   .css(".serp-item")

# job_data.each_with_index do |job, index|
#   jobTitle = job.css("h2").css("a").inner_html.strip
#   jobCompanyName = job.css("h3").css("a").inner_html.strip
#   jobDate = job.css(".item-footer").css(".posted-date").css("span").inner_html.strip
#   jobDetailUrl = job.css(".item-footer").css(".view").css("a").first.attributes["href"].value

#   jobDetailUrlList << jobDetailUrl

#   puts "#{index + 1} | #{jobTitle}"
#   puts "(#{jobDate})"
#   puts "--------------------------------------"
# end

puts "Choose Your Interest Job"
jobValue = gets

link = jobDetailUrlList[jobValue.to_i - 1]
puts link

jobDetailUrl = "https://www.jobnet.com.mm/#{link}"
puts jobDetailUrl
