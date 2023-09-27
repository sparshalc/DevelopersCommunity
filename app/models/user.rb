class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

    has_many :work_experiences, dependent: :destroy
    has_many :connections, dependent: :destroy
    
    PROFILE_TITLE = [
      "Senior Ruby on Rails Developer",
      "Front-end Developer",
      "Full-stack Web Developer",
      "Java Developer",
      "Python Software Engineer",
      "Mobile App Developer",
      "Data Scientist",
      "Machine Learning Engineer",
      "DevOps Engineer",
      "Cloud Solutions Architect",
      "Software Development Manager",
      "Game Developer",
      "UI/UX Designer",
      "QA Engineer",
      "Blockchain Developer",
      "Embedded Systems Engineer",
      "AI Research Scientist",
      "Cybersecurity Analyst",
      "Database Administrator",
      "Network Engineer",
      "Firmware Engineer",
      "iOS Developer",
      "Android Developer",
      "Backend Developer",
      "Big Data Engineer",
      "Web Designer",
      "AR/VR Developer",
      "React Native Developer",
      "PHP Developer",
      ".NET Developer",
      "Scala Developer",
      "C++ Developer",
      "Artificial Intelligence Engineer",
      "Data Engineer",
      "System Administrator",
      "Elixir Developer",
      "Flutter Developer",
      "WordPress Developer",
      "Linux Kernel Developer",
      "Embedded Linux Developer",
      "Rust Developer",
      "Golang Developer",
      "Ruby Developer",
      "Node.js Developer",
    ].freeze
    
    def full_name
      "#{first_name} #{last_name}".strip
    end

    def self.ransackable_associations(auth_object = nil)
      []
    end

    def self.ransackable_attributes(auth_object = nil)
      ["country", "profile_title"]
    end
    
    def address
      "#{city}, #{state} - #{pincode}, #{country}".strip
    end
    
    def check_if_already_connected?(current_user, user)
      current_user != user && !current_user.connections.pluck(:connected_user_id).include?(user.id)
    end
end
