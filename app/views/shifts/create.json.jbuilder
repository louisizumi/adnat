if @shift.persisted?
  json.inserted_item json.partial!("/organisations/shift.html.erb", shift: @shift, employments: @employments)
end