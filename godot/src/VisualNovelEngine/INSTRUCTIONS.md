# VisualNovelEngine INSTRUCTIONS v1.0.0

VNEngine is a collection of scripts written to handle dialogs in visual novel games.

### How to store and write dialogs
Dialogs can be stored inside single or multiple files.
The best way to store dialogs would be to create a `dialogs/` folder containing languages subfolders (`it/`,`eng/`,...), and each subfolder should contain a folder for each chapter of the game.  
A *dialog file* can contain a single dialog or a collection of dialogs if multiple speakers have stage.  
Dialog files present a Json format, containing only one root `dialogs` key consisting of an Array of Json `dialog sections`.
```
#An example dialog file, could be in .../dialogs/en/chapter_1/dialog_1.res

{
  "dialogs":
    [
      {
        #dialog section 1
      },
      {
        #dialog section 2
      }
    ]
}
```

A `dialog section` consists of a JSON element with three keys:  
- `who`: the actor who is talking;  
- `where`: stage settings, place and time of the day;  
- `what`: content of the dialog spoken by the actor, collection of `diaog lines` as an Array of JSON Objects;  

```
{
  "who":{},
  "where":"{},
  "what":{}
}
```

### Who
| key | description |
|-|-|
|`name`*|the name of the speaker|
The name of the speaker should be the same name of the image file associated to the speaker.


### Where
| key | description |
|-|-|
|`place`*| the place of the dialog |
|`time`*| the time of the day |
Place and Time should respect the format of stage fiels, such as backgrounds and places, which is `place_time.png`.  
For example, if you want your stage to be a park in night time:
```
park_night.png

"where":
  {
    "place":"park",
    "time":"night"
  }
```

### What
| key | description |
|-|-|
|`type`*|the type of dialog|
|`text`*|the content of the dialog|
|`expression`*|the facial/body expression of the actor speaking|
|`action`|the action preformed by an actor|
|`options`|selectable options if the `type` of the dialog is `2 - ask`|

#### Dialog types
Dialog types are:
- 0: say,
- 1: ask,
- 2: answer

#### Expressions
The expression value represents the name of the expression file

#### Action
Actions are animations played in the AnimatorPlayer, and referenced by name.  
When the action value is not given, the engine interprets it as a basic animation which name is "_", so *always make sure to have a "_" animation in the animation player*, which represents an idle/static animation.

```
"what":
  [
    {
      # basic "say" dialog
      "type":"0",
      "text":"Hello World!",
      "expression":"normal"
    },
    {
      # basic "ask" dialog
      "type":"1",
      "text":"Hello World?",
      "expression":"question"
      "options":
        [
          "Yes it is!",
          "No it isn't."
        ]
    },
    {
      # basic "answer" dialog
      "type":"2",
      "options":
       "0":
          {
            "type":"0",
            "text":"Indeed!",
            "expression":"happy"     
          },
       "1":
          {
            "type":"0",
            "text":"Too bad.",
            "expression":"sad"     
          },
    },    
  ]
```


**note:** fields signed with the * symbol are mandatory
