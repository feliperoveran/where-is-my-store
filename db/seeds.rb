# Load stores from stores.json file
# Skips invalid stores

stores = File.read 'stores.json'

JSON.parse(stores)['pdvs'].each do |store_json|
  Store.from_json! store_json
rescue ActiveRecord::RecordInvalid => e
  puts 'Skipping creation of an invalid store.'
  puts "Error: #{e.message}"
  puts "Store's JSON for debugging: #{store_json}"
end
