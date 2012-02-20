class Unfuddle::Command::PeopleCommand < Unfuddle::Command
  # Show all people on current account
  def index
    display 'People:'
    Unfuddle::Resources::Person.all.each do |p|
      display "#{p.id.to_s.rjust(2)} #{p.username.ljust(20)}#{p.name.ljust(30)}#{p.email}"
    end
  end
end