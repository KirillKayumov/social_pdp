class AuthenticateNewUser
  include Interactor::Organizer

  organize CreateUser, ConnectAccount
end
