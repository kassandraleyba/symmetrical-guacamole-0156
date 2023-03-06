require 'rails_helper'

RSpec.describe "Hotel Show Page" do

  let!(:echo) { Hotel.create!(name: "Echo Mountain Inn", location: "Echo Mountain") }
  let!(:everest) { Hotel.create!(name: "Everest View Hotel", location: "Everest Mountain") }
  let!(:charlize) { Guest.create!(name: "Charlize Theron", nights: 3) }
  let!(:scarlett) { Guest.create!(name: "Scarlett Johansson", nights: 2) }
  let!(:keanu) { Guest.create!(name: "Keanu Reeves", nights: 4) }
  let!(:presidential) { echo.rooms.create!(rate: 125, suite: "Presidential") }
  let!(:penthouse) { everest.rooms.create!(rate: 175, suite: "Penthouse") }

  before do
    GuestRoom.create!(guest: charlize, room: presidential)
    GuestRoom.create!(guest: scarlett, room: penthouse)
    GuestRoom.create!(guest: keanu, room: penthouse)

    visit "/hotels/#{everest.id}"
  end

  # Extension
  describe "When I visit /hotels/:id" do
    it "Then I see a unique list of all guests that have stayed at this hotel" do
        # create a list: 1 hotel << many guests
      expect(page).to  have_content("Hotels Show Page\n")
      expect(page).to have_content("Hotel Name: Everest View Hotel\n")
      expect(page).to have_content("Guests:\nScarlett Johansson\nKeanu Reeves")

      expect(page).to_not have_content("Hotel Name: Echo Mountain Inn")
      expect(page).to_not have_content("Guests: Charlize Theron")
      # save_and_open_page
    end
  end
end
