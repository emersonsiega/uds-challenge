import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udschallengeapp/app/modules/topics/components/topic_row_content.dart';
import 'package:udschallengeapp/app/modules/topics/components/topic_row_title.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';

class ExpandableTopicTile extends StatefulWidget {
  final Key key;
  final TopicModel topic;
  final bool isExpanded;
  final ValueChanged<bool> onTap;

  ExpandableTopicTile({
    this.key,
    @required this.topic,
    @required this.onTap,
    this.isExpanded: false,
  }) : super(key: key);

  @override
  _ExpandableTopicTileState createState() => _ExpandableTopicTileState();
}

class _ExpandableTopicTileState extends State<ExpandableTopicTile>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _contenSizeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
    );

    _contenSizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        1.0,
        curve: Curves.linear,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didUpdateWidget(ExpandableTopicTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    ///
    /// Decides if need to expand or collapse the topic tile
    ///
    if (oldWidget?.isExpanded == true && !widget.isExpanded) {
      _animationController.reverse();
    } else if (oldWidget?.isExpanded == false && widget.isExpanded) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: widget.key,
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
            color: ColorPalette.white,
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
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: _contenSizeAnimation,
                      axis: Axis.vertical,
                      axisAlignment: -1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
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
                      ),
                    );
                  },
                ),
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
