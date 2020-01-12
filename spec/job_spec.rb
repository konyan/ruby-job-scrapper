require "job"

RSpec.describe Job do
  let(:job) { Job.new("Ruby Job", "It is description", "It is requirement", "Ruby", "male") }

  it "has a title" do
    expect(job.title).to eq("Ruby Job")
  end

  it "has a Job description" do
    expect(job.description).to eq("It is description")
  end

  it "has a Job requirement" do
    expect(job.requirement).to eq("It is requirement")
  end

  it "has background company name" do
    expect(job.company_name).to eq("Ruby")
  end

  it "acceptance gender" do
    expect(job.accept_gender).to eq("male")
  end
end
