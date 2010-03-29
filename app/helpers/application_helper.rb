# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def random_subtitle
    messages = ["Paying lip service to computer service since 2001",
                "Greg stop reading the forums and get to work",
                "Ye Olde Software Emporiume",
                "<b><u>STRONG DIGITAL DEFENSE</u></b>",
                "All hail the naked king of Shoreditch",
                "Oh god how did this get here I am not good with Rails",
                "Note: Tickets may not be redeemable for prizes",
                image_tag("psyduck.gif"),
                image_tag("bandwagon.gif"),
                image_tag("masterstroke.gif"),
                image_tag("toot.gif"),
                image_tag("unwanted.gif"),
                image_tag("unsmith.gif"),
                "Vista will be available sometime after you CHOKE AND DIE",
#                "",
#                "",
#                "",
#                "",
#                "",
               ]
    messages[rand(messages.size)]
  end
  
  def technician_dropdown(form, selected = nil, field = :technician_id)
    tech_hash = Technician.find_all_by_enabled(true).collect { |tek| [ tek.name, tek.id ] }
    form.select field, tech_hash, :selected => selected
  end
  
  def num_unread_messages
    messages = Message.find( :all, 
                             :conditions => [ "receiver_id = ? AND opened = ?", 
                                              session[:technician], 0 ] )
    link_to "#{messages.size} Unread Messages", :controller => "/tekmail"
  end
  
  def time_formatter(time)
    return "" if time.nil?
    time.to_s(:long) + " (#{distance_of_time_in_words(Time.now, time)} ago)"
  end
  
  def admin_links
    if session[:admin]
      links = "Administer: "
      links += link_to "Technicians", { :controller => '/admin/technician' }
      links += " | "
      links += link_to "Links", { :controller => '/admin/links' }
      links += " | "
      links += link_to "Reports", { :controller => '/report' }
    end # session[:admin]
  end
end
