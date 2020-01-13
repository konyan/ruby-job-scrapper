# frozen_string_literal: true

class Job
  attr_accessor :title, :description, :requirement, :company_name, :accept_gender

  def initialize(title, description, requirement, company_name, accept_gender)
    @title = title
    @description = description
    @requirement = requirement
    @company_name = company_name
    @accept_gender = accept_gender
  end
end
