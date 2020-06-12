import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udschallengeapp/app/app_bloc.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';
import 'package:udschallengeapp/app/shared/components/loading_action_button.dart';
import 'package:udschallengeapp/app/shared/validator/string_validator.dart';

class CreateTopicPage extends StatefulWidget {
  @override
  _CreateTopicPageState createState() => _CreateTopicPageState();
}

class _CreateTopicPageState extends State<CreateTopicPage> {
  final _formKey = GlobalKey<FormState>();

  // Title
  final _titleController = TextEditingController();
  final _titleNode = FocusNode();

  // Description
  final _descriptionController = TextEditingController();
  final _descriptionNode = FocusNode();

  // Details
  final _detailsController = TextEditingController();
  final _detailsNode = FocusNode();

  // Author
  final _authorController = TextEditingController();
  final _authorNode = FocusNode();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    final _appBloc = AppModule.to.bloc<AppBloc>();
    final user = _appBloc.userStream.value;
    if (user != null) {
      _authorController.text = user.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Criar pauta",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: _titleController,
                    focusNode: _titleNode,
                    decoration: InputDecoration(
                      labelText: "Título",
                      helperText: " ",
                      prefixIcon: Icon(MdiIcons.tagTextOutline),
                    ),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descriptionNode);
                    },
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.next,
                    validator: StringValidator("Título", 3).validate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    focusNode: _descriptionNode,
                    decoration: InputDecoration(
                      labelText: "Breve descrição",
                      helperText: " ",
                      prefixIcon: Icon(MdiIcons.textShort),
                    ),
                    minLines: 1,
                    maxLines: 2,
                    maxLength: 50,
                    scrollPadding: EdgeInsets.all(40),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_detailsNode);
                    },
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.next,
                    validator: StringValidator("Breve descrição", 10).validate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    controller: _detailsController,
                    focusNode: _detailsNode,
                    decoration: InputDecoration(
                      labelText: "Detalhes",
                      helperText: " ",
                      prefixIcon: Icon(MdiIcons.textSubject),
                    ),
                    enabled: !_isLoading,
                    expands: false,
                    minLines: 9,
                    maxLines: 9,
                    textInputAction: TextInputAction.newline,
                    scrollPadding: EdgeInsets.only(bottom: 170),
                    onFieldSubmitted: (_) async {
                      FocusScope.of(context).requestFocus(_authorNode);
                    },
                    validator: StringValidator("Detalhes", 10).validate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 30),
                  child: TextFormField(
                    controller: _authorController,
                    focusNode: _authorNode,
                    decoration: InputDecoration(
                      labelText: "Autor",
                      helperText: " ",
                      prefixIcon: Icon(Icons.person),
                    ),
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.done,
                    scrollPadding: EdgeInsets.only(bottom: 100),
                    onFieldSubmitted: (_) async {
                      await _save();
                    },
                    validator: StringValidator("Autor", 3).validate,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: LoadingActionButton(
        onPressed: _save,
        icon: Icons.check,
        isLoading: _isLoading,
        tooltip: "Criar pauta",
      ),
    );
  }

  Future<void> _save() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      // TODO - Save topic
      Navigator.of(context).pop();
    }
  }
}
