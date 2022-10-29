abstract class AuthenticationState
{
  var attributes;
}


class Unauthenticated extends AuthenticationState
{}

class Authenticated extends AuthenticationState
{
  var attributes;

  Authenticated(this.attributes);
}

class Unknown extends AuthenticationState
{}

class AuthError extends AuthenticationState
{}