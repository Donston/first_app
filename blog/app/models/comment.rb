class Comment < ActiveRecord::Base
  belongs_to :blog_post, :counter_cache => true
  
  validates_presence_of :author, :author_email, :status, :content
  validates_length_of :author, :within => 3..25
  validates_inclusion_of :status, :in => %w{new improve spam}
  validates_format_of :author_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  scope :sorted, order('comments.created_at ASC')
  
  def before_validation
    self.author.strip!
  end
  
  private
  
  def validate
    errors.add(:author, " can't Be Kevin.") if self.author == "JP"
    errors.add_to_base("Keving can't be the author.") if self.comment.author == "JP"

  end
end
