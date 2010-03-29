module QueueHelper
  def queue_name
    case params[:action] 
      when "index"
        return "Work"
      when "pc"
        return "PC"
      else
        params[:action].capitalize
    end
  end
end
