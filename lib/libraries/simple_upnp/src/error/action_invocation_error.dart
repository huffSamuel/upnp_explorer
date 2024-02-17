part of simple_upnp;

class InvocationError extends Error {
  final String description;
  final String code;

  InvocationError(
    this.description,
    this.code,
  );
}
