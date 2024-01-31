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
    index?
  end

  def update?
    index?
  end

  def create?
    index?
  end

  def destroy?
    index?
  end
end
