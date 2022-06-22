import 'package:xml/xml.dart';

/// This class represents a World Tool galaxy.
class Galaxy {
  /// The name of the galaxy.
  late String name;

  /// The description of the galaxy.
  late String desc;

  Galaxy(this.name, this.desc);

  /// Creates a galaxy from the xml passed in [input].
  ///
  /// If [input] cant be parsed into a galaxy it throws a [String] as an error
  Galaxy.fromXml(String input) {
    var document = XmlDocument.parse(input).findAllElements("galaxy");
    if (document.length > 1) {
      throw "too many galaxy tags";
    }
    var galaxy = document.first;

    var name = galaxy.getAttribute("name")!;
    var desc = galaxy.getElement("description");

    String descStr;
    if (desc == null) {
      descStr = "";
    } else {
      if (desc.children.isNotEmpty) {
        if (desc.children[0].nodeType != XmlNodeType.TEXT) {
          throw "incorrect galaxy format";
        }
        if (desc.children.length != 1) {
          throw "incorrect galaxy format";
        }
      }

      descStr = desc.innerText;
    }

    this.name = name;
    this.desc = descStr;
  }

  @override
  String toString() {
    final builder = XmlBuilder();
    builder.element("galaxy", nest: () {
      builder.attribute("name", name);
      builder.element("description", nest: () {
        builder.text(desc);
      });
    });
    return builder.buildDocument().toString();
  }
}
