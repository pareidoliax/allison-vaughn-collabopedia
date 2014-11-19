class Collaborator < ActiveRecord::Base
  #attr_accessor :user_id, :wiki_id 
  belongs_to :wiki
  has_many :users, through: :collaborators
  belongs_to :user

  def is_owner_of?(wiki)
    wiki.user_id == id
  end 
end
