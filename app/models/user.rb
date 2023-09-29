class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

    has_many :work_experiences, dependent: :destroy
    has_many :connections, dependent: :destroy

    validates :first_name, :last_name, :profile_title, presence: true
    validates :username, presence: true, uniqueness: true
    
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
      return nil if city.blank? && state.blank? && country.blank? && pincode.blank?
      "#{city}, #{state} - #{pincode}, #{country}".strip
    end

    def my_connection(user)
      Connection.where("(user_id = ? AND connected_user_id = ? ) OR (user_id = ? AND connected_user_id = ? )", user.id, id, id, user.id)
    end
    
    def check_if_already_connected?(user)
      self!= user && !my_connection(user).present?
    end

    def mutually_connected_ids(user)
      self.connected_user_ids.intersection(user.connected_user_ids)
    end
end
