import 'package:world_tool_projects/world_tool_projects.dart';
import 'package:test/test.dart';

void main() {
  group('test serialize and deserialize', () {
    test("deserialize no galaxies", () {
      var xml =
          '<project name="string"><description>cats</description></project>';
      var project = Project.fromXml(xml);
      assert(project.name == "string");
      assert(project.desc == "cats");
    });

    test("serialize no galaxies", () {
      var project = Project("string", "cats");
      var expected =
          '<project name="string"><description>cats</description><galaxies/></project>';
      assert(project.toString() == expected);
    });
    test("serialize galaxies", () {
      var project = Project("string", "cats");
      project.galaxies = [Galaxy("test", "tes")];
      var expected =
          '<project name="string"><description>cats</description><galaxies><galaxy name="test"><description>tes</description></galaxy></galaxies></project>';
      assert(project.toString() == expected);
    });
  });
}
