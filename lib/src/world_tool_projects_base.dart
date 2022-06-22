import 'package:world_tool_projects/src/galaxy/galaxy.dart';
import 'package:xml/xml.dart';

/// This class represents a World Tool Project.
class Project {
  /// The name of the project.
  late String name;

  /// The description of the project.
  late String desc;

  late List<Galaxy> galaxies;

  Project(this.name, this.desc) : galaxies = [];

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
    var galaxies = project.getElement("galaxies");

    String descStr = "";
    if (desc != null) {
      if (desc.children.length != 0) {
        if (desc.children.length > 1) {
          throw "incorrect project format";
        }
        if (desc.children[0].nodeType != XmlNodeType.TEXT) {
          throw "incorrect project format";
        }
      }

      descStr = desc.innerText;
    }

    List<Galaxy> galaxiesArr = [];
    if (galaxies != null) {
      for (var elem in galaxies.children) {
        galaxiesArr.add(Galaxy.fromXml(elem.toString()));
      }
    }

    this.name = name;
    this.desc = descStr;
    this.galaxies = galaxiesArr;
  }

  @override
  String toString() {
    var builder = XmlBuilder();
    builder.element("project", nest: () {
      builder.attribute("name", name);
      builder.element("description", nest: () {
        builder.text(desc);
      });
      builder.element("galaxies", nest: () {
        for (var element in galaxies) {
          builder.xml(element.toString());
        }
      });
    });
    return builder.buildDocument().toString();
  }
}
