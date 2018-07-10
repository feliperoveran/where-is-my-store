# Load stores from stores.json file

stores = File.read 'stores.json'

JSON.parse(stores)['pdvs'].each do |store_json|
  Store.from_json! store_json
end

