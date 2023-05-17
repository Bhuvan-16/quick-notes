// Login Exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class UserDisabledAuthException implements Exception {}

// Register Exceptions
class EmailAlreadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class OperationNotAllowedAuthException implements Exception{}

// Generic exceptions 
class GenericAuthException implements Exception{}

class UserNotLoggedInAuthException implements Exception{}