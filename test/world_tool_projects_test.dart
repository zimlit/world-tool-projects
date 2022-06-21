import 'dart:math';

import 'package:world_tool_projects/world_tool_projects.dart';
import 'package:test/test.dart';

void main() {
  group('test serialize and deserialize', () {
    test("serialize", () {
      var xml =
          '<project name="string"><description>cats</description></project>';
      var project = Project.fromXml(xml);
      assert(project.name == "string");
      assert(project.desc == "cats");
    });

    test("deserialize", () {
      var project = Project("string", "cats");
      var expected =
          '<project name="string"><description>cats</description></project>';
      assert(project.toString() == expected);
    });
  });
}
