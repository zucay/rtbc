#!/usr/bin/ruby

require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
TOKEN_PATH = 'config/token.yaml'.freeze
SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
APPLICATION_NAME = "Google Sheets API Ruby Quickstart".freeze
CREDENTIALS_PATH = "config/credentials.json".freeze

def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = "default"
  credentials = authorizer.get_credentials user_id
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts "Open the following URL in the browser and enter the " \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

def read_spreadsheet(spreadsheet_id, range)
  service = Google::Apis::SheetsV4::SheetsService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize


  response = service.get_spreadsheet_values spreadsheet_id, range
  puts "No data found." if response.values.empty?
  response.values.each do |row|
    # Print columns A and E, which correspond to indices 0 and 4.
    puts "#{row[0]}, #{row[2]}"
  end
end

def main()
  # google's sample spreadsheet
  read_spreadsheet('1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms', 'Class Data!A1:D10')
end

if(__FILE__ == $0)
  main
end
