class DisciplineMonitor < ApplicationRecord
  enum semester: { first: 1, second: 2}, _prefix: :true

  validates :year, presence: true
  validates :semester, presence: true
  validates :description, presence: true
  validates :academic, presence: true
  validates :monitor_type, presence: true

  validates :discipline_ids, presence: true
  validates :professor_ids, presence: true

  belongs_to :academic
  belongs_to :monitor_type

  has_many :discipline_monitor_professors
  has_many :professors, through: :discipline_monitor_professors

  has_many :discipline_monitor_disciplines
  has_many :disciplines, through: :discipline_monitor_disciplines

  def self.human_semesters
    hash = {}
    semesters.each { |key, val| hash[I18n.t("enums.semesters.#{key}")] = val }
    hash
  end

  if Time.zone.now.month > 6 ? month_now = "second" : month_now ="first"
  end

  scope :semester_now, -> { where(semester: month_now) }
  scope :year_now, -> { where(year: Time.zone.now.year) }
end
