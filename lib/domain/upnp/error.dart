class ActionInvocationError extends Error {
  final String description;
  final String code;

  ActionInvocationError(
    this.description,
    this.code,
  );
}
