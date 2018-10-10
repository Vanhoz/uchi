class ContributorPdf < Prawn::Document
  def initialize(contributor_name, contributor_place, contributions)
    super(top_margin: 70)
    text "PDF for #{contributor_place.to_i + 1} place!"
    text "The award goes to #{contributor_name}"
    text "For total of #{contributions} contributions!"
  end
end