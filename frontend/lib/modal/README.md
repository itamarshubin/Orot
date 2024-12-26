I used `json_serializable` to create this schemas so here is what you should know.

I added these packages to pubspec:

- dependencies
    - json_annotation: ^4.9.0
- dev_dependencies
    - build_runner: ^2.4.14
    - json_serializable: ^6.9.2

Then I created the schemas (simply the objects) and added their toJSON and fromJSON functions.  
Note that for each schema I added this line `part 'XXXX.g.dart';` for example in event you can find
this line `part 'event.g.dart';`.  
This line will be the name of the new file that represents the actions of toJSON and fromJSON
actions.

It is being generated automatically each time you run this line
`flutter pub run build_runner build`.  
So for any update just run it afterwards.