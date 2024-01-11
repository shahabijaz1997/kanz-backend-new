# frozen_string_literal: true

module SearchHelper
  extend ActiveSupport::Concern

  private

  def search_params
    return if params[:search].blank?

    controller_actions = search_hash[controller_name.to_sym]
    return if controller_actions.blank?

    search_filter = controller_actions[action_name.to_sym]
    return if search_filter.blank?
    text_to_search = params[:search]
  
    params[:search] = {}
    params[:search][search_filter.to_sym] = text_to_search
  end

  # ransackable search filters for specific controller actions
   # { controller_name: { action_name: ransackable_key }}
  def search_hash
    {
      investors: { index: 'name_i_cont', deals: 'title_or_syndicate_name_i_cont' },
      deals: { index: 'title_i_cont', investors: 'name_i_cont' },
      syndicates: { index: 'name_i_cont', deals: 'title_i_cont', all: 'name_i_cont' },
      invites: { index: 'eventable_of_Deal_type_title_or_invitee_name_i_cont' },
      syndicate_members: { index: 'member_name_i_cont', investors: 'name_i_cont', applications: 'user_name_i_cont', invites: 'invitee_name_i_cont' },
      fund_raisers: { investors: 'user_name_i_cont'}
    }
  end
end
