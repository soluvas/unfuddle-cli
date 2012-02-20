# Ticket CLI commands
class Unfuddle::Command::TicketCommand < Unfuddle::Command
  # Show all available tickets
  def index
    display "Site: #{Unfuddle::Resources::Ticket.site}"
    tickets = Unfuddle::Resources::Ticket.all
    unless tickets.empty?
      display 'Tickets:'
      tickets.each { |p| display "##{p.id}: #{p.summary}" }
      system '/usr/bin/notify-send',
        '--icon=/usr/share/icons/gnome/48x48/status/info.png',
        "Unfuddle: #{tickets.count} tickets found"
    else
      display 'You dont have any tickets yet'
    end
  end
  
  # Create a new ticket
  def create
    display 'Create a new ticket'
    display "Site: #{Unfuddle::Resources::Ticket.site}"
    
    summary = ask('Summary', :required => true)
    description = ask('Description', :required => false)
    priority = ask('Priority (1=Lowest - 5=Highest)', :required => true)
    
    people = Unfuddle::Resources::Person.all
    display "People: " + people.map { |p| p.username }.sort.join(' ')
    reporter_username = ask('Reported by', :required => true)
    reporter_id = people.detect { |p| p.username == reporter_username }.id 
    assignee_username = ask('Assigned to', :required => true)
    assignee_id = people.detect { |p| p.username == assignee_username }.id
      
    ticket = Unfuddle::Resources::Ticket.create(
      :ticket => {
        :summary => summary,
        :description => description,
        :priority => priority,
        :reporter_id => reporter_id,
        :assignee_id => assignee_id,
      }
    )
    display "Ticket created: ##{ticket.id} - #{ticket.summary}"
    system '/usr/bin/notify-send',
      '--icon=/usr/share/icons/gnome/48x48/actions/document-new.png',
      "Unfudde Ticket created: ##{ticket.id} - #{ticket.summary}"
  end
  
end