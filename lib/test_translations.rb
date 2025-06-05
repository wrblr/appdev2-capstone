require 'bundler/setup'
require 'httparty'
require 'json'
require 'dotenv/load'


# response = HTTParty.post("https://api.openai.com/v1/chat/completions",
#   headers: {
#     "Authorization" => "Bearer #{ENV["TRANSLATION_API_KEY"]}",
#     "Content-Type" => "application/json"
#   },
#   body: {
#     model: "gpt-4",
#     messages: [
#       { role: "system", content: "Translate from English to Spanish" },
#       { role: "user", content: "Hello, how are you?" }
#     ]
#   }.to_json
# )

# puts response.parsed_response

source_lang = "en"
target_lang = "es"
original_text = "Hello, how are you?"

puts "Source Lang: #{source_lang}"
puts "Target Lang: #{target_lang}"
puts "Original Text: #{original_text}"

response = HTTParty.post("https://api.openai.com/v1/chat/completions",
  headers: {
    "Authorization" => "Bearer #{ENV["TRANSLATION_API_KEY"]}",
    "Content-Type" => "application/json"
  },
  body: {
    model: "gpt-4-0613",
    messages: [
      {
        role: "system",
        content: "Translate this message from #{source_lang} to #{target_lang}"
      },
      {
        role: "user",
        content: original_text
      }
    ]
  }.to_json
)

puts "API Call Successful? #{response.success?}"
puts "Translated Response:"
puts response.parsed_response["choices"].first["message"]["content"] rescue puts "Error: #{response}"
