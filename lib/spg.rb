require 'bundler/setup'
Bundler.require(:default)

module SPG
  module URL
    SCHEME = 'http://'
    HOST = 'www.starwoodhotels.com'
    SEARCH_PATH = '/preferredguest/search/results/detail.html'

    SF_HOTEL_IDS = [1010, 1981, 1511, 1153, 373, 1957, 315, 913, 1156, 1007, 3719]
  end

  class SearchQuery
    attr_accessor :locale, :property_ids,
                  :arrival_date, :departure_date,
                  :number_of_rooms, :number_of_adults, :number_of_children

    LOCALE_US = 'en_US'

    # @param [Date] arrival_date
    # @param [Date] departure_date
    def initialize(arrival_date, departure_date)
      @locale = LOCALE_US
      @property_ids = URL::SF_HOTEL_IDS
      @number_of_rooms = 1
      @number_of_adults = 1
      @number_of_children = 0

      @arrival_date = arrival_date
      @departure_date = departure_date
    end

    # @return [String]
    def url
      [URL::SCHEME, URL::HOST, URL::SEARCH_PATH, '?', query_parameters].join('')
    end

    QUERY_FORMAT = %w(
      localeCode
      propertyIds
      arrivalDate
      departureDate
      numberOfRooms
      numberOfAdults
      numberOfChildren
    )

    # @return [String]
    def query_parameters
      QUERY_FORMAT.zip([
                         locale, property_ids.join(','),
                         format_date(arrival_date), format_date(departure_date),
                         number_of_rooms, number_of_adults, number_of_children
                       ]).map { |k, v| "#{k}=#{v}" }.join('&')
    end

    DATE_FORMAT = '%m-%d-%Y'

    # @param [Date] date
    # @return [String]
    def format_date(date)
      date.strftime(DATE_FORMAT).gsub('-', '%2F')
    end
  end

  class Page
    attr_reader :node

    # @param [Nokogiri::XML::Node] doc
    def initialize(doc)
      @node = doc
    end

    def children_from_css(selector, klazz)
      node.css(selector).map { |n| klazz.new(n) }
    end

    # @return [Hash]
    def to_hash
      {}
    end
  end

  class SearchPage < Page
    # @return [Array<String>]
    def property_names
      properties.map!(&:name)
    end

    # @return [Property]
    def properties
      children_from_css('.property', Property)
    end

    def to_hash
      {properties: properties.map!(&:to_hash)}
    end

    class Property < Page
      # @return [String]
      def name
        node.at_css('[itemtype="http://schema.org/Product"] [itemprop="name"]')['content']
      end

      # @return [String]
      def url
        path = node.at_css('.propertyDetails a')['href']
        "#{URL::SCHEME}#{URL::HOST}#{path}"
      end

      # @return [Array<Rate>]
      def rates
        remove_starpoints children_from_css('.rateOptions .rate', Rate)
      end

      def to_hash
        {name: name, url: url, rates: rates.map!(&:to_hash)}
      end

      private
      # Starpoints don't have a different selector than currency. I don't care about starpoints.
      # @param [Array<Rate>] rates
      # @return [Array<Rate>]
      def remove_starpoints(rates)
        rates.delete_if { |n| !n.amount }
      end

      class Rate < Page
        DIGITS = /(\d+)/

        # @return [String]
        def name
          node.at_css('.ratePlan').content.strip
        end

        # @return [Integer]
        def amount
          currency_node = node.at_css('.currency')
          currency_node && currency_node.content.tr(',', '')[DIGITS, 1].to_i
        end

        def to_hash
          {name: name, amount: amount}
        end
      end
    end
  end

  class API
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36'

    # @param [HTTPClient] client
    def initialize(client = HTTPClient.new(agent_name: USER_AGENT), document_parser = Nokogiri::HTML)
      @client = client
      @document_parser = document_parser
    end

    # @param [SearchQuery] query
    # @return [SearchPage]
    def search(query)
      response = get(query.url)
      doc = @document_parser.parse(response.body)

      SPG::SearchPage.new(doc)
    end

    private
    # @param [String] url
    # @return [HTTP::Message]
    def get(url)
      @client.get(url, follow_redirect: true)
    end
  end
end
