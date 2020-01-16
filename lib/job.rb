# frozen_string_literal: true
require "nokogiri"

class Job
  attr_accessor :title, :company, :requirement, :description, :doc
  attr_reader :parseDoc

  def initialize(document)
    @doc = document
    @parseDoc = Nokogiri::HTML(@doc)
      .css(".content-sidebar-wrapper")
      .css(".content-wrapper")
    @title = @parseDoc
      .css(".job-info-wrapper")
      .css(".job-detail-header")
      .css("h1").inner_html
    @company = @parseDoc
      .css(".job-info-wrapper")
      .css(".job-detail-header")
      .css("h2")
      .css("a")
      .css("span").inner_html
    @requirement = @parseDoc
      .css(".job-description-wrapper")
      .css(".description-item")
      .first
      .css("div")
      .css("p")
      .inner_html.strip.gsub(/<br\s*\/?>/, "\n").gsub(/\s*/, " ").gsub(/•\s*/, "• ").gsub(/-\s*/, "- ")
    @description = @parseDoc
      .css(".job-description-wrapper")
      .css(".description-item:nth-child(3)")
      .css("p").inner_html.strip.gsub(/<br\s*\/?>/, "\n").gsub(/•\s*/, "• ").gsub(/-\s*/, "- ").gsub(/\s*/, " ")
  end
end
