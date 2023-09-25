class WorkExperience < ApplicationRecord
  belongs_to :user

  EMPLOYMENT_TYPE = [
    'Full-time', 'Part-time', 'Freelance', 'Trainee', 'Internship'
  ]
  LOCATION_TYPE = [
     'On-site', 'Hybrid', 'Remote'
  ]

  validates :company, :start_date, :employment_type, :job_title, :location, :location_type, presence: true
  validates :employment_type, presence: true, inclusion: { in: EMPLOYMENT_TYPE, message: 'Not a valid Employment type!' }
  validates :location, presence: true, inclusion: { in: LOCATION_TYPE, message: 'Not a valid location!' }

  validate :work_experience_last_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date, if: :current_not_working_here?
  def work_experience_last_date
    if end_date.presence && current_working_here
      errors.add(:end_date, 'must be blank if you are still working in this company')
    end
  end  
  def presence_of_end_date
    if end_date.nil? && !current_working_here
      errors.add(:end_date, 'must be blank if you have already left the company')
    end
  end
  def current_not_working_here?
    !currently_working_here
  end

  def end_date_greater_than_start_date
    return if end_date.nil?
     if end_date < start_date
      errors.add(:end_date, 'must be greater than start date!')
     end
  end
end
