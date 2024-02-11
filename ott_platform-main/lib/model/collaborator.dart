// collaborator model with feild id and username

class Collaborator {
  String id;
  String username;

  Collaborator({required this.id, required this.username});

  static List<Collaborator> fromJsonList(List<dynamic> json) {
    List<Collaborator> collaborators = [];
    for (var collaborator in json) {
      collaborators.add(Collaborator(
        id: collaborator['id'].toString(),
        username: collaborator['username'],
      ));
    }
    return collaborators;
  }

}
