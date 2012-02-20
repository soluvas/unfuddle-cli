class Unfuddle::Command::ProjectCommand < Unfuddle::Command
  # Show all available projects
  def index
    projects = Unfuddle::Resources::Project.all
    unless projects.empty?
      display 'Projects:'
      projects.each { |p| display "- #{p.id}: #{p.title}" }
    else
      display 'You dont have any projects yet'
    end
  end
  
  # Show all components
  def components
    components = Unfuddle::Resources::Component.all
    unless components.empty?
      display 'Components:'
      components.each { |c| display "- #{c.id}: #{c.name}" }
    else
      display 'You dont have any components yet'
    end
  end
  
  # Show all milestones
  def milestones
    milestones = Unfuddle::Resources::Milestone.all
    unless milestones.empty?
      display 'Milestones:'
      milestones.each { |c| display "- #{c.id}: #{c.title}" }
    else
      display 'You dont have any milestones yet'
    end
  end
  
  # Show all versions
  def versions
    versions = Unfuddle::Resources::Version.all
    unless versions.empty?
      display 'Versions:'
      versions.each { |c| display "- #{c.id}: #{c.name}" }
    else
      display 'You dont have any versions yet'
    end
  end
  
end