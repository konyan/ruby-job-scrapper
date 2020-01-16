# frozen_string_literal: true

require "open-uri"

class JobUrl
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def url_to_document
    open(@url).read
  end
end
