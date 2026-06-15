# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioned_report_mentions, class_name: 'ReportMention', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :referring_reports, through: :mentioned_report_mentions, source: :mentioning_report

  has_many :mentioning_report_mentions, class_name: 'ReportMention', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :referenced_reports, through: :mentioning_report_mentions, source: :mentioned_report

  validates :title, presence: true
  validates :content, presence: true
  after_save :sync_report_mention

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  HOST_REGEXP = %r{http://localhost:3000/reports/(\d+)}
  def mentioned_reports
    ids = content.scan(HOST_REGEXP).flatten.map(&:to_i).uniq
    Report.where(id: ids)
  end

  private

  def sync_report_mention
    mentioning_report_mentions.destroy_all
    mentioned_reports.each do |report|
      ReportMention.create!(mentioning_report_id: id, mentioned_report_id: report.id)
    end
  end
end
