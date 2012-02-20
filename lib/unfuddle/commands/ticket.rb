# Ticket CLI commands
class Unfuddle::Command::TicketCommand < Unfuddle::Command
  # Show all available tickets
  def index
    display "Site: #{Unfuddle::Resources::Ticket.site}"
    tickets = Unfuddle::Resources::Ticket.all
    unless tickets.empty?
      display 'Tickets:'
      tickets.each { |p| display "##{p.id}: #{p.summary}" }
    else
      display 'You dont have any tickets yet'
    end
  end
  
  # Create a new ticket
  def create
    display 'Create a new ticket'
    display "Site: #{Unfuddle::Resources::Ticket.site}"
    repo = Unfuddle::Resources::Ticket.create(
      :ticket => {
        :summary => ask('Summary', :required => true),
        :description => ask('Description', :required => false),
        :priority => ask('Priority (1-5)', :required => true)
      }
    )
  end
  
end