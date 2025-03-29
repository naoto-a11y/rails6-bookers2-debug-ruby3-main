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
