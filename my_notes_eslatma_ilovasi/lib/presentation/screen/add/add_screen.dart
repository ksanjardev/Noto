import 'dart:convert';

import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:gap/gap.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/components/format_btn.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/res/app_strings.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/add/bloc/add_bloc.dart';

import '../../../utils/status_enum.dart';
import '../../dialog/dialogs.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> with WidgetsBindingObserver {
  final TextEditingController titleController = TextEditingController();
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final bloc = AddBloc();
  late String initialTitle;
  late String initialDescription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    WidgetsBinding.instance.addObserver(this);
    initialTitle = titleController.text;
    initialDescription = jsonEncode(
      _controller.document.toDelta().toJson(),
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    titleController.dispose();
    bloc.close();
    super.dispose();
  }

  void _showSaveDiscardDialog(
      BuildContext context, bool isPreview, bool isLoading) {
    final bloc = context.read<AddBloc>(); // Capture here
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SaveDiscardDialog(
          onSaveClick: () {
            bloc.add(OnAddClick(
              title: titleController.text,
              description: jsonEncode(_controller.document.toDelta().toJson()),
            ));
            if (!isPreview) context.pop();
          },
          onDiscardClick: () {
            titleController.text =
                initialTitle; // Reset title field to the initial title
            try {
              final doc =
                  quill.Document.fromJson(jsonDecode(initialDescription));
              _controller.document.replace(0, _controller.document.length,
                  doc.toDelta()); // Reset quill document to initial description
            } catch (e) {
              debugPrint("Failed to reset note description: $e");
            }
            if (isPreview) context.pop();
          },
          isLoading: isLoading,
        );
      },
    );
  }
  bool _hasChanges() {
    final currentTitle = titleController.text;
    final currentDescription =
    jsonEncode(_controller.document.toDelta().toJson());
    return currentTitle != initialTitle ||
        currentDescription != initialDescription;
  }
  Future<bool> _onWillPop(BuildContext context, bool isLoading) async {
    if (_hasChanges()) {
      _showSaveDiscardDialog(context, false, isLoading);
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<AddBloc, AddState>(listener: (context, state) {
        switch (state.status) {
          case Status.loading:
            break;
          case Status.success:
            context.pop();
            break;
          case Status.fail:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg.toString()),
                backgroundColor: Colors.red,
              ),
            );
          case Status.initial:
            break;
        }
      }, builder: (context, state) {
        return WillPopScope(
          onWillPop: (){
            return _onWillPop(context, state.status == Status.loading);
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF252525),
            appBar: AppBar(
                backgroundColor: const Color(0xFF252525),
                automaticallyImplyLeading: false,
                title: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B3B3B),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ).onTap(() {
                  if (_hasChanges()) {
                    _showSaveDiscardDialog(context, false, state.status == Status.loading);
                  } else {
                    context.pop();
                  }
                }),
                actions: [
                  if (state.isEditing) ...[
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const Icon(Icons.remove_red_eye_outlined,
                          color: Colors.white),
                    ).onTap(() {
                      if (_hasChanges()) {
                        _showSaveDiscardDialog(
                            context, true, state.status == Status.loading);
                        context.read<AddBloc>().add(ToggleEditing(false));
                      } else {
                        context.read<AddBloc>().add(ToggleEditing(false));
                      }
                    }),
                    Gap(10),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const Icon(Icons.save_outlined, color: Colors.white),
                    ).onTap(() {
                      if (_hasChanges()) {
                        _showSaveDiscardDialog(
                            context, false, state.status == Status.loading);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.lightGreen,
                            content: Text(
                              "Up to date. No need to save",
                              style: TextStyle(fontSize: 22, color: Colors.black),
                            )));
                      }
                    }),
                    Gap(10)
                  ] else ...[
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ).onTap(() {
                      context.read<AddBloc>().add(ToggleEditing(true));
                    }),
                    Gap(10),
                  ]
                ]),
            body: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    // Title field
                    TextField(
                      controller: titleController,
                      readOnly: !state.isEditing,
                      maxLines: null,
                      showCursor: state.isEditing,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: AppStrings.title,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: Color(0xFF9a9a9a).withOpacity(0.4)),
                        border: InputBorder.none,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                        child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white, decorationColor: Colors.white),
                      child: quill.QuillEditor(
                        focusNode: _focusNode,
                        scrollController: ScrollController(),
                        controller: _controller,
                        config: quill.QuillEditorConfig(
                            placeholder: AppStrings.noteDsc,
                            customStyles: quill.DefaultStyles(
                              paragraph: quill.DefaultTextBlockStyle(
                                  Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          decorationColor: Color(0xFF9a9a9a)),
                                  const quill.HorizontalSpacing(0.0, 0.0),
                                  const quill.VerticalSpacing(0, 0),
                                  const quill.VerticalSpacing(0, 0),
                                  BoxDecoration()),
                            ),
                            expands: true,
                            autoFocus: true,
                            showCursor: state.isEditing,
                            padding: EdgeInsets.zero,
                            keyboardAppearance: Brightness.dark,
                            scrollable: true),
                      ),
                    )),
                  ],
                ).paddingAll(12)),
                if (state.isEditing) ...[
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      return SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FormatButton(
                                  icon: Icons.format_bold,
                                  controller: _controller,
                                  attribute: quill.Attribute.bold),
                              FormatButton(
                                  icon: Icons.format_italic,
                                  controller: _controller,
                                  attribute: quill.Attribute.italic),
                              FormatButton(
                                  icon: Icons.format_underline,
                                  controller: _controller,
                                  attribute: quill.Attribute.underline),
                              FormatButton(
                                  icon: Icons.format_strikethrough,
                                  controller: _controller,
                                  attribute: quill.Attribute.strikeThrough),
                              FormatButton(
                                  icon: Icons.format_quote,
                                  controller: _controller,
                                  attribute: quill.Attribute.blockQuote),
                              FormatButton(
                                  icon: Icons.code,
                                  controller: _controller,
                                  attribute: quill.Attribute.codeBlock),
                              FormatButton(
                                icon: Icons.format_list_bulleted,
                                controller: _controller,
                                attribute: quill.Attribute(
                                    'list', quill.AttributeScope.block, 'bullet'),
                              ),
                              FormatButton(
                                icon: Icons.format_list_numbered,
                                controller: _controller,
                                attribute: quill.Attribute('list',
                                    quill.AttributeScope.block, 'ordered'),
                              ),
                              FormatButton(
                                icon: Icons.format_color_fill,
                                controller: _controller,
                                attribute: quill.Attribute('background',
                                    quill.AttributeScope.inline, 'yellow'),
                              ),
                              FormatButton(
                                icon: Icons.text_fields,
                                controller: _controller,
                                attribute: quill.Attribute(
                                    'size', quill.AttributeScope.inline, 'large'),
                              ),
                              FormatButton(
                                  icon: Icons.vertical_align_bottom,
                                  controller: _controller,
                                  attribute: quill.Attribute.subscript),
                              FormatButton(
                                  icon: Icons.vertical_align_top,
                                  controller: _controller,
                                  attribute: quill.Attribute.superscript),
                              const SizedBox(width: 8),
                            ],
                          ).paddingSymmetric(
                              horizontal: 8), // using awesome_extensions
                        ),
                      );
                    },
                  ),
                ]
              ],
            ),
          ),
        );
      }),
    );
  }
}
