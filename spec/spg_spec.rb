require_relative '../lib/spg'

RSpec.describe SPG::API, vcr: { cassette_name: :spg_search_page } do
  let(:page) do
    SPG::API.new.search SPG::SearchQuery.new(Date.new(2016, 4, 25), Date.new(2016, 4, 29))
  end

  it 'returns results for only properties in SF' do
    expect(page.property_names.sort).to eq([
      'The Westin St. Francis San Francisco on Union Square',
      'The Park Central San Francisco',
      'The St. Regis San Francisco',
      'W San Francisco',
      'Palace Hotel, a Luxury Collection Hotel, San Francisco',
      'Le Méridien San Francisco',
      "Sheraton Fisherman's Wharf Hotel",
      'Four Points by Sheraton San Francisco Bay Bridge',
      'Four Points by Sheraton Hotel & Suites San Francisco Airport',
      'The Westin San Francisco Airport',
      'Aloft San Francisco Airport'
    ].sort)
  end

  it 'provides property metadata' do
    first_property = page.properties.first

    expect(first_property.name).to eq('Aloft San Francisco Airport')
    expect(first_property.url).to eq('http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=3719')
  end

  it 'provides the rates for a property' do
    first_rate = page.properties.first.rates.first

    expect(first_rate.name).to eq('Lowest Standard Rate')
    expect(first_rate.amount).to eq(227)
  end

  it 'provides results in a serializable manner' do
    expected = { properties: [
      { name: 'Aloft San Francisco Airport',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=3719',
        rates: [{ name: 'Lowest Standard Rate', amount: 227 }] },
      { name: 'Four Points by Sheraton Hotel & Suites San Francisco Airport',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1156',
        rates: [{ name: 'Lowest Standard Rate', amount: 224 }] },
      { name: 'Four Points by Sheraton San Francisco Bay Bridge',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=913',
        rates: [{ name: 'Lowest Standard Rate', amount: 188 }] },
      { name: 'Le Méridien San Francisco',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1957',
        rates: [{ name: 'Lowest Standard Rate', amount: 428 }] },
      { name: 'Palace Hotel, a Luxury Collection Hotel, San Francisco',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=373',
        rates: [{ name: 'Lowest Standard Rate', amount: 418 }] },
      { name: "Sheraton Fisherman's Wharf Hotel",
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=315',
        rates: [{ name: 'Lowest Standard Rate', amount: 254 }] },
      { name: 'The Park Central San Francisco',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1981',
        rates: [{ name: 'Lowest Standard Rate', amount: 346 }] },
      { name: 'The St. Regis San Francisco',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1511',
        rates: [{ name: 'Lowest Standard Rate', amount: 485 }] },
      { name: 'The Westin San Francisco Airport',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1007',
        rates: [{ name: 'Lowest Standard Rate', amount: 242 }] },
      { name: 'The Westin St. Francis San Francisco on Union Square',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1010',
        rates: [{ name: 'Lowest Standard Rate', amount: 341 }] },
      { name: 'W San Francisco',
        url: 'http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1153',
        rates: [{ name: 'Lowest Standard Rate', amount: 414 }] }] }

    expect(page.to_hash).to eq(expected)
  end
end
