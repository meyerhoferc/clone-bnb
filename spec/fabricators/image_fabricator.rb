Fabricator(:image) do
  listing {Fabricate(:listing)}
  image_url {Faker::LoremPixel.image("700x400", false, 'city')}
end
