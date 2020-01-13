require "open-uri"
require "nokogiri"
require "./lib/position"
require "colorize"

positionList = Array.new
jobDetailUrlList = Array.new

puts "
:......::::.......:::..::::..:::......::::.......:::........::........::::::......::::.......:::........::::......:::
:......::::.......:::..::::..:::......::::.......:::........::........::::::......::::.......:::........::::......:::
:'######:::'#######::'##::: ##::'######:::'#######::'##:::::::'########::::::::::'##::'#######::'########:::'######::
'##... ##:'##.... ##: ###:: ##:'##... ##:'##.... ##: ##::::::: ##.....::::::::::: ##:'##.... ##: ##.... ##:'##... ##:
 ##:::..:: ##:::: ##: ####: ##: ##:::..:: ##:::: ##: ##::::::: ##:::::::::::::::: ##: ##:::: ##: ##:::: ##: ##:::..::
 ##::::::: ##:::: ##: ## ## ##:. ######:: ##:::: ##: ##::::::: ######:::::::::::: ##: ##:::: ##: ########::. ######::
 ##::::::: ##:::: ##: ##. ####::..... ##: ##:::: ##: ##::::::: ##...:::::::'##::: ##: ##:::: ##: ##.... ##::..... ##:
 ##::: ##: ##:::: ##: ##:. ###:'##::: ##: ##:::: ##: ##::::::: ##:::::::::: ##::: ##: ##:::: ##: ##:::: ##:'##::: ##:
. ######::. #######:: ##::. ##:. ######::. #######:: ########: ########::::. ######::. #######:: ########::. ######::
:......::::.......:::..::::..:::......::::.......:::........::........::::::......::::.......:::........::::......:::
:......::::.......:::..::::..:::......::::.......:::........::........::::::......::::.......:::........::::......:::
".yellow

positionUrl = "https://www.jobnet.com.mm/jobs-in-myanmar"

document = open(positionUrl)
content = document.read
position_data = Nokogiri::HTML(content).css(".hero-wrapper").css(".select-wrapper").first
  .css("option")

puts "
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                 Job Position List                                 +  
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
".yellow

position_data.each_with_index do |positionRow, index|
  posTitle = positionRow.inner_html
  positionValue = positionRow.attributes["value"].value
  if index > 0 && index < 25
    positionList << Position.new(posTitle, positionValue)
    puts "#{index} | #{posTitle}"
  end
  sleep (1.0 / 12.0)
end

positionValue = nil
until (positionValue != nil) && (positionValue.is_a? Integer)
  puts "Enter No: to choose your position :".red
  positionValue = gets
end

pos = positionList[positionValue.to_i - 1]
posValue = pos.position
posName = pos.name

jobUrl = "https://www.jobnet.com.mm/jobs-in-myanmar?jobfunction=#{posValue}"
job_document = open(jobUrl)
job_content = job_document.read
job_data = Nokogiri::HTML(job_content).css(".serp-results-items-wrapper").css(".serp-results-items")
  .css(".serp-item")

puts "
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  +                 Job List for #{posName}          +  
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
".yellow

job_data.each_with_index do |job, index|
  jobTitle = job.css("h2").css("a").inner_html.strip
  jobCompanyName = job.css("h3").css("a").inner_html.strip
  jobDate = job.css(".item-footer").css(".posted-date").css("span").inner_html.strip
  jobDetailUrl = job.css(".item-footer").css(".view").css("a").first.attributes["href"].value

  jobDetailUrlList << jobDetailUrl

  puts "#{index + 1} | #{jobTitle}"
  puts "(#{jobDate})"
  puts "--------------------------------------"
  sleep (1.0 / 12.0)
end

# puts "Enter 0 for go back :".red
puts "Enter No: for your Interest Job :".red
jobValue = gets

link = jobDetailUrlList[jobValue.to_i - 1]
jobDetailUrl = "https://www.jobnet.com.mm/#{link}"
detail_document = open(jobDetailUrl).read
detail_data = Nokogiri::HTML(detail_document).css(".content-sidebar-wrapper")
  .css(".content-wrapper")

jobTitle = detail_data.css(".job-info-wrapper").css(".job-detail-header")
  .css("h1").inner_html
jobCompany = detail_data.css(".job-info-wrapper").css(".job-detail-header")
  .css("h2").css("a").css("span").inner_html
postedDate = detail_data.css(".job-info-wrapper").css(".footer")
  .css(".post-date")
jobDescription = detail_data.css(".job-description-wrapper").css(".description-item").first.css("div").css("p").inner_html.strip
jobRequirement = detail_data.css(".job-description-wrapper").css(".description-item:nth-child(3)").css("p").inner_html.strip

puts "
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                    #{jobTitle}                                
                   (#{jobCompany})
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
".yellow

puts "
Job Description
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#{jobDescription.gsub(/<br\s*\/?>/, "\n").gsub(/•\s*/, "• ")}
"

puts "
Job Requirements
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#{jobRequirement.gsub(/<br\s*\/?>/, "\n").gsub(/\s*/, " ")}
"
