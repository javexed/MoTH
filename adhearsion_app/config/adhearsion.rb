# encoding: utf-8
require 'lib/drb_endpoint'

Adhearsion.config do |config|

  # Centralized way to specify any Adhearsion platform or plugin configuration
  # - Execute rake config:show to view the active configuration values
  #
  # To update a plugin configuration you can write either:
  #
  #    * Option 1
  #        Adhearsion.config.<plugin-name> do |config|
  #          config.<key> = <value>
  #        end
  #
  #    * Option 2
  #        Adhearsion.config do |config|
  #          config.<plugin-name>.<key> = <value>
  #        end

  config.development do |dev|
    dev.platform.logging.level = :debug
  end

  ##
  # Use with Rayo (eg Voxeo PRISM or FreeSWITCH mod_rayo)
  #
  # config.punchblock.username = "usera@freeswitch.local-dev.mojolingo.com" # Your XMPP JID for use with Rayo
  # config.punchblock.password = "1" # Your XMPP password

  ##
  # Use with Asterisk
  #
  config.punchblock.platform = :asterisk # Use Asterisk
  # config.punchblock.username = "manager" # Your AMI username
  # config.punchblock.password = "password" # Your AMI password
  # config.punchblock.host = "asterisk.local-dev.mojolingo.com" # Your AMI host
  config.punchblock.host = ENV["ASTERISK_PORT_5038_TCP_ADDR"]
  #config.punchblock.port = ENV["ASTERISK_PORT_5038_TCP_PORT"]

  #config.adhearsion_drb.host = "DRb service host"
  config.adhearsion_drb.host = "0.0.0.0"
  #config.adhearsion_drb.port = "DRB service port".to_i
  #config.adhearsion_drb.acl.allow = ["127.0.0.1"] # list of allowed IPs (optional)
  #config.adhearsion_drb.acl.deny = [] # list of denied IPs (optional)
  config.adhearsion_drb.shared_object = DrbEndpoint.new
end
