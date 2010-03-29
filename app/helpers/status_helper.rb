module StatusHelper
  def bookmark_link
    "http://htdb.sub.ttu.edu/status/lookup?key=#{@ticket.status.key}"
  end
end
