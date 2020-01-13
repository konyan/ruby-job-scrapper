require "open-uri"

class JobUrl
  attr_accessor :url, :doc

  def initialize(url)
    @url = url
  end

  def url_to_document
    open(@url).read
  end
end
