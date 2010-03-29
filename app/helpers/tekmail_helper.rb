module TekmailHelper
  def linkified(message)
    message.gsub(/#(\d{4,})/) { |ticket| 
      t = ticket
      link_to("#{t}", :controller => '/view', :id => t[1,t.length-1].to_i)
    }
  end
end
