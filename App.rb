# Loading all dependencies
require 'open-uri'
require 'nokogiri'
require 'csv'

# Main Function
def main(url)
  html = open("#{url}").read
  nokogiri_doc = Nokogiri::HTML(html)
  final_array = []

  nokogiri_doc.search(".v2-listing-card__info h3").each do |element|
    element = element.text
    final_array << element
  end

  final_array.each_with_index do |element, index|
    puts "#{index + 1} - #{element}"
  end
end

# Target URL = https://www.etsy.com/search?q=marvel
main = main('https://www.etsy.com/search?q=marvel')

# Export CSV File
filepath = "listing.csv"
csv_options = {headers: :first_row, col_sep: ','}

# Reading the CSV in App
CSV.open(filepath, 'wb', csv_options) do |csv|
  csv << ['title', 'index']
  main.each_with_index do |item, index|
    csv << [item, index]
  end
end
