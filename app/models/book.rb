class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments, dependent: :destroy
  has_many :read_counts, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :favorites_count, ->{left_joins(:favorites).group('books.id').order('COUNT(favorites.id) DESC')}

  scope :today, -> {where(created_at: Time.current.all_day)}
  scope :yesterday, -> {where(created_at: Time.zone.yesterday.all_day)}
  scope :week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.current.end_of_day)}
  scope :lastweek, -> {where(created_at: (Time.current - 13.days).beginning_of_day..(Time.current - 7.days).end_of_day)}

  scope :sixago, -> {where(created_at: 6.day.ago.all_day)}
  scope :fiveago, -> {where(created_at: 5.day.ago.all_day)}
  scope :fourago, -> {where(created_at: 4.day.ago.all_day)}
  scope :threeago, -> {where(created_at: 3.day.ago.all_day)}
  scope :twoago, -> {where(created_at: 2.day.ago.all_day)}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    elsif
      @book = Book.all
    end
  end
end
