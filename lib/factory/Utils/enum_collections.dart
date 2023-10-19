enum UserAuthenticationState{
  userLoggedIn,
  userLoggedOut,
  userValidating,
  userPreparing
}

enum LoginState{
  prepareLogin,
  loginSuccess,
  loginfailed
}

enum StudentEventResult{
  studentPrepareToFetch,
  studentPrepared,
  studentInserted,
  studentUpdated,
  studentDeleted
}