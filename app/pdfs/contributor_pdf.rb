class ContributorPdf < Prawn::Document
  def initialize(contributor_name, contributor_place, contributions)
    super(top_margin: 70)
    move_down 160
    text "PDF for #{contributor_place.to_i + 1} place!", align: :center, size: 26
    move_down 100
    text "The award goes to #{contributor_name}", align: :center, size: 22, style: :bold
    move_down 100
    text "For a total of #{contributions} contributions!", align: :center, size: 22
  end
end