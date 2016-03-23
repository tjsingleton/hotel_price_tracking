# Hotel Price Tracking

A collection of tools that I built to help me figure out when to travel to San Francisco and where to stay.

## Usage

```bash
bin/build-index --start 2016-03-28 --weeks 2 --output spg.csv
```

writes 2 weeks of pricing data starting 2016-03-28 to spg.csv like this
```csv
2016-03-28,2016-04-01,Aloft San Francisco Airport,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=3719,$265
2016-03-28,2016-04-01,Four Points by Sheraton Hotel & Suites San Francisco Airport,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1156,$194
2016-03-28,2016-04-01,Four Points by Sheraton San Francisco Bay Bridge,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=913,$184
2016-03-28,2016-04-01,Le Méridien San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1957,$430
2016-03-28,2016-04-01,"Palace Hotel, a Luxury Collection Hotel, San Francisco",http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=373,$425
2016-03-28,2016-04-01,Sheraton Fisherman's Wharf Hotel,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=315,$294
2016-03-28,2016-04-01,The Park Central San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1981,$353
2016-03-28,2016-04-01,The St. Regis San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1511,$494
2016-03-28,2016-04-01,The Westin San Francisco Airport,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1007,$240
2016-03-28,2016-04-01,The Westin St. Francis San Francisco on Union Square,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1010,$336
2016-03-28,2016-04-01,W San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1153,$429
2016-04-04,2016-04-08,Aloft San Francisco Airport,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=3719,$257
2016-04-04,2016-04-08,Four Points by Sheraton Hotel & Suites San Francisco Airport,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1156,$220
2016-04-04,2016-04-08,Four Points by Sheraton San Francisco Bay Bridge,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=913,$197
2016-04-04,2016-04-08,Le Méridien San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1957,$436
2016-04-04,2016-04-08,"Palace Hotel, a Luxury Collection Hotel, San Francisco",http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=373,$390
2016-04-04,2016-04-08,Sheraton Fisherman's Wharf Hotel,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=315,$314
2016-04-04,2016-04-08,The Park Central San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1981,$372
2016-04-04,2016-04-08,The St. Regis San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1511,$545
2016-04-04,2016-04-08,The Westin San Francisco Airport,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1007,$341
2016-04-04,2016-04-08,The Westin St. Francis San Francisco on Union Square,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1010,$353
2016-04-04,2016-04-08,W San Francisco,http://www.starwoodhotels.com/preferredguest/property/overview/index.html?propertyID=1153,$404
```

## Running Tests

`rspec spec`
