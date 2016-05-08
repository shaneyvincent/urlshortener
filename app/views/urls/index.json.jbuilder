json.array!(@urls) do |url|
  json.extract! url, :id, :originalurl, :short
  json.url url_url(url, format: :json)
end
