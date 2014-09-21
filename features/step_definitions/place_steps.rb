Given 'I\'m on the place creation page' do
  visit new_place_path
end

Given 'I\'m on the place edit page' do
  @place = FactoryGirl.create(:place)
  visit edit_place_path(@place)
end

When 'I change the place data' do
  new_data = FactoryGirl.attributes_for(:place)
  @place.update_attributes(new_data)

  fill_in 'Nombre', :with => @place.name
  fill_in 'Dirección', :with => @place.address
  fill_in 'Descripción', :with => @place.description
  fill_in 'Teléfono móvil', :with => @place.mobile_phone
  fill_in 'Teléfono fijo', :with => @place.land_line

  click_button 'Enviar'
end

When 'I add a new place' do
  @place = FactoryGirl.build(:place)

  fill_in 'Nombre', :with => @place.name
  fill_in 'Dirección', :with => @place.address
  fill_in 'Descripción', :with => @place.description
  fill_in 'Teléfono móvil', :with => @place.mobile_phone
  fill_in 'Teléfono fijo', :with => @place.land_line

  click_button 'Enviar'
end

Then 'I should see the page for my newly created place' do
  @place = Place.find_by(name: @place.name, address: @place.address)
  current_path.must_equal edit_place_path(@place)
end

Then 'I should see the page for my newly edited place' do
  @place = Place.find_by(name: @place.name, address: @place.address)
  current_path.must_equal edit_place_path(@place)
end


And(/^the notice "(.*?)"$/) do |string|
  page.has_content?(string).must_equal true
end
