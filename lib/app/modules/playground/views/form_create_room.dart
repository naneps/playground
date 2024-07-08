import 'package:flutter/material.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';
import 'package:playground/app/common/ui/overlays/scalled_dialog.dart';
import 'package:playground/app/models/room_playground_model.dart';

class FormCreateRoom extends StatelessWidget {
  final void Function(RoomPlayGroundModel) onCreate;
  RoomPlayGroundModel room = RoomPlayGroundModel();

  FormCreateRoom({
    super.key,
    required this.onCreate,
  });
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ScaleDialog(
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Create Room',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      XInput(
                        hintText: 'Room name',
                        onChanged: (value) => room.name = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a room name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      XInput(
                        hintText: 'Room description',
                        onChanged: (value) => room.description = value,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    onCreate(room);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
