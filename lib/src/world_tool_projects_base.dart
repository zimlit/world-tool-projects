import 'package:xml/xml.dart';

/// This class represents a World Tool Project.
class Project {
  /// The name of the project.
  late String name;

  /// The description of the project.
  late String desc;

  Project(this.name, this.desc);

  /// Creates a project from the xml passed in [input].
  ///
  /// If [input] cant be parsed into a project it throws a [String] as an error
  Project.fromXml(String input) {
    var document = XmlDocument.parse(input).findAllElements("project");
    if (document.length > 1) {
      throw "too many project tags";
    }
    var project = document.first;

    var name = project.getAttribute("name")!;
    var desc = project.getElement("description");

    String descStr;
    if (desc == null) {
      descStr = "";
    } else {
      if (desc.children[0].nodeType != XmlNodeType.TEXT) {
        throw "incorrect project format";
      }
      if (desc.children.length != 1) {
        throw "incorrect project format";
      }
      descStr = desc.innerText;
    }

    this.name = name;
    this.desc = descStr;
  }

  @override
  String toString() {
    final builder = XmlBuilder();
    builder.element("project", nest: () {
      builder.attribute("name", name);
      builder.element("description", nest: () {
        builder.text(desc);
      });
    });
    return builder.buildDocument().toString();
  }
}
