require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/lists'
require_relative '../apps/web/application'
require_relative '../system/import'
# require "letter_opener"

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/lists_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/lists_development'
    #    adapter :sql, 'mysql://localhost/lists_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/lists/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
    mailer do
      delivery :smtp, 
      address: ENV.fetch('SMTP_HOST'), 
      port: ENV.fetch('SMTP_PORT'),
      domain: "gmail.com", 
      user_name: "listswebapp@gmail.com", 
      password: "xena2616", 
      authentication: "plain",
      enable_starttls_auto: true
    end
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, 
      address: ENV.fetch('SMTP_HOST'), 
      port: ENV.fetch('SMTP_PORT'),
      domain: "gmail.com", 
      user_name: "listswebapp@gmail.com", 
      password: "xena2616",
      authentication: "plain",
      enable_starttls_auto: true
    end
  end
end
