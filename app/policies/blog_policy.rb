# frozen_string_literal: true

class BlogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user_context.content_manager?
        scope.not_draft
      else
        scope.where(author_id: user_context.id)
      end
    end
  end

  def index?
    user_context.content_manager? || user_context.content_creator?
  end

  def show?
    index?
  end

  def edit?
    user_context.content_creator? ? !record.published? : index?
  end

  def update?
    edit?
  end

  def new?
    user_context.content_creator?
  end

  def create?
    new?
  end

  def destroy?
    index?
  end
end
