import 'package:flutter/material.dart';
import 'package:ott_platform_app/model/collaborator.dart';

class CollaboratorsWidget extends StatefulWidget {
  final List<Collaborator> collaborators;
  final Function(String) onTap;

  CollaboratorsWidget({required this.collaborators, required this.onTap});

  @override
  _CollaboratorsWidgetState createState() => _CollaboratorsWidgetState();
}

class _CollaboratorsWidgetState extends State<CollaboratorsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        itemCount: widget.collaborators.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.collaborators[index].username),
            onTap: () {
              setState(() {
                widget.onTap(widget.collaborators[index].username);
              });
            },
          );
        },
      ),
    );
  }
}
