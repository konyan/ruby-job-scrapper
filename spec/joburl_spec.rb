require "joburl"

RSpec.describe JobUrl do
  let(:jobUrl) { JobUrl.new("https://www.jobnet.com.mm/job-details/customer-development-manager-colgate-palmolive-myanmar-ltd/43758") }

  it "has a url" do
    expect(jobUrl.url).to eq("https://www.jobnet.com.mm/job-details/customer-development-manager-colgate-palmolive-myanmar-ltd/43758")
  end

  it "can read docs" do
    expect(jobUrl.url_to_document).to include("body")
  end
end
