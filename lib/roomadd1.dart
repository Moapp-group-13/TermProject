import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providerclass.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<Cleaning>(context!, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room'),
      ),
      body: const MyListPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/roomadd');

          // showModalBottomSheet(
          //   // groundColor: Colors.grey,
          //     context: context,
          //     isScrollControlled: true,
          //     builder: (context) {
          //       return ChangeNotifierProvider.value(
          //           value: viewModel,
          //           child: ConfirmModal());
          //     }
          // );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final roomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: 300.0,
                child: TextField(
                  controller: roomController,
                  decoration: const InputDecoration(
                    labelText: 'Room ',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      context.read<Cleaning>().Room.add(roomController.text);
                      context.read<Cleaning>().LastPerson.add('Unknown');
                      roomController.clear();
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Enter')),
            ],
          ),
        ),

      ),
    );
  }
}


class ConfirmModal extends StatefulWidget {
  const ConfirmModal({Key? key}) : super(key: key);

  @override
  State<ConfirmModal> createState() => _ConfirmModalState();
}

class _ConfirmModalState extends State<ConfirmModal> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2,  right: 2,  left: 2,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox( height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Room Name : '),
              Container(
                width: 120.0,
                child: TextFormField(
                  controller: nameController,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  context.read<Cleaning>().Room.add(nameController.text);
                  context.read<Cleaning>().LastPerson.add('Unknown');
                  nameController.clear();
                  Navigator.pushNamed(context, '/rlist');
                  Navigator.pop(context);
                });
              },
              child: const Text('Enter')),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: context.watch<Cleaning>().Room.length,
      itemBuilder: (c, i){
        return Dismissible(
          key: ValueKey(context.watch<Cleaning>().Room[i]),
          background: Container(
            color: Colors.green,
          ),
          // child: ListTile(
          //   title: Text(context.read<Cleaning>().Room[i]),
          // ),
          child: Card(
            child: ListTile(
              leading: const CircleAvatar(
                radius:50,
                backgroundImage: AssetImage('1.PNG'),
              ),
              title: Text(context.watch<Cleaning>().Room[i],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(
                  '\n마지막으로 치운 사람: ${context.watch<Cleaning>().LastPerson[i]}' ,
              ),
              trailing: const Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              (context.read <Cleaning>().Room.removeAt(i));
            });
          },
        );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          // listPoint.insert(newIndex, listPoint.removeAt(oldIndex));
        });
      },
    );
  }
}