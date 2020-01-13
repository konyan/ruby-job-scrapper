require "job"
require "joburl.rb"

RSpec.describe Job do
  let(:jobUrl) { JobUrl.new("https://www.jobnet.com.mm/job-details/customer-development-manager-colgate-palmolive-myanmar-ltd/43758") }
  let(:job) { Job.new(jobUrl.url_to_document) }

  it "has a title" do
    expect(job.title).to eq("Customer Development Manager")
  end

  it "has a Job description" do
    expect(job.description).to include("Category Management")
  end

  it "has a Job requirement" do
    expect(job.requirement).to include("Job Purpose")
  end

  it "has background company name" do
    expect(job.company).to eq("Colgate Palmolive (Myanmar) Ltd.")
  end
end
