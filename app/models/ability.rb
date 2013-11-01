class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Article do |article|
      article.published_at.present? && article.published_at <= Time.now.utc
    end

    can :new,    :session
    can :create, :session

    can :about, :static_page
    can :cv,    :static_page
    can :oops,  :static_page

    can :show, User

    can :create, Comment

    if user
      can :destroy, :session

      can :edit,   User, id: user.id
      can :update, User

      can :new,    Comment
      can [:edit, :update, :destroy], Comment, user_id: user.id

      if user.admin?
        can :manage, :all
      end
    end
  end
end
