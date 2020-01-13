# frozen_string_literal: true

require "open-uri"
require "nokogiri"
require "colorize"
require "./lib/position"
require "./lib/job"
require "./lib/joburl"

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
".yellow.center(1)

running = true

while running
  positionJobUrl = JobUrl.new("https://www.jobnet.com.mm/jobs-in-myanmar")
  document = positionJobUrl.url_to_document
  position_data = Nokogiri::HTML(document).css(".hero-wrapper").css(".select-wrapper").first
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

  checkPosition = false
  positionValue = nil
  until checkPosition
    puts "Enter No: to choose your position :".red
    positionValue = gets

    if (positionValue.to_i != 0) && (positionValue.to_i.is_a? Integer)
      checkPosition = true
    end
  end

  pos = positionList[positionValue.to_i - 1]
  posValue = pos.position
  posName = pos.name

  jobUrl = JobUrl.new("https://www.jobnet.com.mm/jobs-in-myanmar?jobfunction=#{posValue}")
  job_content = jobUrl.url_to_document
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

  jobDetailUrl = JobUrl.new("https://www.jobnet.com.mm/#{link}")
  detail_document = jobDetailUrl.url_to_document

  selectJob = Job.new(detail_document)
  jobTitle = selectJob.title
  jobCompany = selectJob.company
  jobDescription = selectJob.description
  jobRequirement = selectJob.requirement

  puts "
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                      #{jobTitle}                                
                    (#{jobCompany})
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  ".yellow
  puts "
  Job Description
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  #{jobDescription}
  "
  puts "
  Job Requirements
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  #{jobRequirement}
  "

  sleep 10
  puts "
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  +             Did you want to continue.....Choose one               +
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  ".red

  puts "0. Quite Program"
  puts "1. Restart program"

  value = gets
  puts value
  if value.to_i.eql?(0)
    running = false
  end
end
