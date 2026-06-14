/// CurrentUser - Entidade que representa o usuário autenticado na sessão atual.
/// Seguindo as regras do current-user-identity-render-agent.md.
class CurrentUser {
  final String id;
  final String name;
  final String avatar;

  CurrentUser({
    required this.id,
    required this.name,
    required this.avatar,
  });
}
