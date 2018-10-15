# -*- encoding : utf-8 -*-

class SlackNotifier
  include Sidekiq::Worker
  sidekiq_options :retry => 2

  def perform(message)
    config = YAML.load_file('config/webhooks.yml')
    notifier = Slack::Notifier.new config["slack"]["webhook"],
      channel: "#webhooks",
      username: "fluenza"

    notifier.post(text: message)
  end
end
