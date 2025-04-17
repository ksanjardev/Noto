import 'dart:async';
import 'dart:convert';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:gap/gap.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/components/item_note.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/add/add_screen.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/edit/edit_screen.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/home/bloc/home_bloc.dart';

import '../../res/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isOffline = false;

  @override
  void initState() {
    bloc.add(GetNotes());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Future<void> _checkInitialConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    setState(() {
      isOffline = connectivityResult == ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF252525),
            title: Text(
              AppStrings.notes,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B3B3B),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
              Gap(10),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B3B3B),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
              Gap(10),
            ],
          ),
          backgroundColor: const Color(0xFF252525),
          body: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (isOffline) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.signal_wifi_off,
                          color: Colors.white, size: 50),
                      SizedBox(height: 10),
                      Text(
                        "No internet connection",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      Gap(16),
                    ],
                  ),
                );
              }
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: StreamBuilder(
                    stream: state.notes,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('asset/image/img_first_note.webp'),
                            Gap(16),
                            Text(
                              AppStrings.firstNote,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 20, color: Colors.white),
                            )
                          ],
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.blue,
                        ));
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            final note = snapshot.data![index];
                            final deltaJson =
                                jsonDecode(note.description) as List<dynamic>;
                            final doc = quill.Document.fromJson(deltaJson);
                            final previewController = quill.QuillController(
                              document: doc,
                              selection:
                                  const TextSelection.collapsed(offset: 0),
                            );
                            previewController.readOnly = true;
                            return Dismissible(
                              key: Key(note.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.transparent,
                              ),
                              secondaryBackground: Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.centerRight,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              onDismissed: (direction) {
                                context
                                    .read<HomeBloc>()
                                    .add(DeleteNote(noteId: note.id));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Note deleted')),
                                );
                              },
                              child: ItemNote(
                                title: note.title,
                                time: note.time,
                                index: index,
                                controller: previewController,
                              ).onTap(() {
                                context.push(EditScreen(data: note));
                              }).paddingSymmetric(horizontal: 10),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gap(20);
                          },
                          itemCount: snapshot.data!.length);
                    }),
              );
            },
          ),
          floatingActionButton: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF252525), // dark background
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
                context.push(AddScreen());
              },
            ),
          ),
        ),
      ),
    );
  }
}
