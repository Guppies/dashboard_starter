class Email < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user
  has_many :mailboxes, dependent: :destroy
  has_many :users, through: :mailboxes

  before_validation :fill_user_email

  validates :to, :user, :subject, :body, presence: true

  after_commit :send_mailgun, on: :create

  scope :authored, (->(user) { where(author: user) })
  scope :recieved, (->(user) { joins(:mailboxes).where('mailboxes.user_id = ?', user.id) })

  attr_accessor :to_users

  def to_hash
    { id:      id,
      from:    author_email,
      to:      to,
      cc:      cc,
      bcc:     bcc,
      subject: subject,
      body:    body }
  end

  def author_email
    author.email
  end

  private

  def send_mailgun
    MailgunWorker.execute(id)
  end

  def fill_user_email
    return unless to_users.present?
    self.to = User.where(id: to_users).map(&:email)
  end
end
