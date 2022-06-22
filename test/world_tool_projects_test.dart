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

    test("deserialize galaxies", () {
      var xml =
          '<project name="name"><description>this is a description\nthis is a lin</description><galaxies><galaxy name=""><description></description></galaxy><galaxy name=""><description></description></galaxy></galaxies></project>';
      var project = Project.fromXml(xml);
      assert(project.name == "name");
      assert(project.desc == "this is a description\nthis is a lin");
      assert(project.galaxies.length == 2);
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
