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
  validates :location_type, presence: true, inclusion: { in: LOCATION_TYPE, message: 'Not a valid location!' }

  validate :work_experience_last_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date, if: :current_not_working_here?
  def work_experience_last_date
    if end_date.presence && currently_working_here
      errors.add(:end_date, 'must be blank if you are still working in this company')
    end
  end  
  def presence_of_end_date
    if end_date.nil? && !currently_working_here
      errors.add(:end_date, 'must be blank if you have already left the company')
    end
  end
  def current_not_working_here?
    !currently_working_here
  end


  def company_with_employment_type
    "#{company} (#{employment_type})".strip
  end

  def job_location
    "#{location} (#{location_type})".strip
  end

  def job_duration
    months = if end_date.present?
              fetchDate(end_date)
            else
              fetchDate(Date.today)
            end
    result = months.divmod(12)

    duration = "#{result.first} #{result.first > 1 ? 'years' : 'year' } #{result.last} #{result.last > 1 ? 'months' : 'month' }"

    if currently_working_here
      "#{start_date.strftime("%b %Y")} - Present (#{duration})"
    else
      "#{start_date.strftime("%b %Y")} - #{end_date.strftime("%b %Y")} (#{duration})"
    end
  end

  def fetchDate(date)
    ((date.year - start_date.year)*12 + date.month - start_date.month - ( date.day >= start_date.day ? 0 : 1 )).round
  end

  def end_date_greater_than_start_date
    return if end_date.nil?
     if end_date < start_date
      errors.add(:end_date, 'must be greater than start date!')
     end
  end
end
