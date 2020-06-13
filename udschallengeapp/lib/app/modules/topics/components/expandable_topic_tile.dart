import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udschallengeapp/app/modules/topics/components/topic_row_content.dart';
import 'package:udschallengeapp/app/modules/topics/components/topic_row_title.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';

class ExpandableTopicTile extends StatefulWidget {
  final TopicModel topic;
  final bool isExpanded;
  final ValueChanged<bool> onTap;

  ExpandableTopicTile({
    @required this.topic,
    @required this.onTap,
    this.isExpanded: false,
  });

  @override
  _ExpandableTopicTileState createState() => _ExpandableTopicTileState();
}

class _ExpandableTopicTileState extends State<ExpandableTopicTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ColorPalette.grey.withOpacity(
              widget.isExpanded ? 0.15 : 0.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TopicRowTitle(
                  title: "Título",
                  icon: MdiIcons.tagTextOutline,
                ),
                TopicRowContent(
                  text: widget.topic.title,
                  style: Theme.of(context).textTheme.title,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: TopicRowTitle(
                    title: "Breve descrição",
                    icon: MdiIcons.textShort,
                  ),
                ),
                TopicRowContent(
                  text: widget.topic.description,
                ),
                if (widget.isExpanded) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: TopicRowTitle(
                      title: "Detalhes",
                      icon: MdiIcons.textSubject,
                    ),
                  ),
                  TopicRowContent(
                    text: widget.topic.details,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: TopicRowTitle(
                      title: "Criado por",
                      icon: Icons.person,
                    ),
                  ),
                  TopicRowContent(
                    text: "${widget.topic.author} em $_createdAt",
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get _createdAt {
    final _dateFormatter = DateFormat("dd/MM/yyyy 'às' HH:mm");
    return _dateFormatter.format(widget.topic.createdAt);
  }

  void _onTap() {
    widget.onTap(!widget.isExpanded);
  }
}
