class Repository < ApplicationRecord
  after_create :create_contributors
  has_many :contributors, dependent: :destroy

  validates_presence_of :link, message: 'can\'t be blank.'
  validates_with LinkValidator

  def create_link(link)
    self.link = "https://api.github.com/repos/#{link.gsub("https://github.com/", "")}/contributors" unless link == ""
  end

  def call_api
    res = RestClient.get self.link
    res = JSON.parse res
    res_names = res.first(3).map {|result| result['login']}
    res_quantity = res.first(3).map {|result| result['contributions']}
    return res_names, res_quantity
  end

  def create_contributors
    cont_names, cont_quantities = call_api
    cont_names.length.times do |i|
      self.contributors.create(name: cont_names[i], quantity: cont_quantities[i], place: i)
    end
  end
  
  def create_or_show
    rep = Repository.find_by(link: self.link)
    if rep
      if rep.updated_at < 1.hours.ago
        rep.destroy!
        return false
      else
        return rep.id
      end
    else
      return false
    end
  end
end