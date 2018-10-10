class Repository < ApplicationRecord
  after_create :create_contributors
  has_many :contributors

  def create_link(link)
    self.link = "https://api.github.com/repos/#{link.gsub("https://github.com/", "")}/contributors"
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
    3.times do |i|
      self.contributors.create(name: cont_names[i], quantity: cont_quantities[i], place: i)
    end
  end
end