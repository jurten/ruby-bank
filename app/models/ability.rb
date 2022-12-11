# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
    if user.present?
      if user.role == 'client'
        can [:index], Branch
        can [:index, :show, :create], Turn, user_id: user.id, status: [:finished, :pending]
        can [:destroy,:update], Turn, user_id: user.id, status: :pending
      end
      if user.role == 'staff'
        can [:index, :show], Branch
        can [:index, :show], User, role: 'client'
        can [:index, :show], Turn, branch_id: user.branch_id, status: :finished, date: Date.today..Date.today + 1.day
        can [:index, :show,:update], Turn, branch_id: user.branch_id, status: :pending, date: Date.today..Date.today + 1.day
      end
      if user.role == 'admin'
        can :manage, :all
        cannot :edit, Turn, status: [:finished, :canceled]
        cannot [:index,:show], Turn, status: :canceled
        cannot [:edit,:destroy], User, role: :admin
      end
    end
  end
end
