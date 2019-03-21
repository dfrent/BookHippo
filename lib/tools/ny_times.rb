module Tools
  class NyTimes
    CATEGORIES = %w[mass-market-paperback travel science business-books animals education hardcover-nonfiction].freeze

    def categories
      CATEGORIES
    end

    def populate_ny_times_books
      bestsellers.each do |book_info|
        isbn = book_info['book_details'][0]['primary_isbn10']
        next unless isbn
        book = Tools::Google.new(isbn).find_or_api_call
        book&.update_attribute(:ny_times_list, book_info['list_name'])
      end
    end

    private

    def bestsellers
      categories.each_with_object([]) do |category, response|
        results = fetch_ny_times_list(category).parsed_response['results']
        next if results.nil?
        response << results
      end.flatten
    end

    def fetch_ny_times_list(category)
      HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=#{category}")
    end
  end
end
