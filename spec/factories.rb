FactoryGirl.define do
  factory :entry do
    body '<script>alert("xss")</script>'
    photo { Rails.root.join('spec', 'files', 'imas9393.jpg').open() }
  end
end
