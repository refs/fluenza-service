# -*- encoding : utf-8 -*-

class Graphs::AccountsController < Graphs::ApplicationController
  include Graphable

  def monthly_added_accounts
    payload = split_values_and_labels(AccountData.monthly_added_accounts)

    render json: payload, head: :ok
  end
end
