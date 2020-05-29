---
layout: post
title: "UML diagrams in GitLab"
description: Create UML diagrams in GitLab issue/MR description and comments
summary: I like UML visual style to explain ideas. As I use GitLab, there is the best approach to have UML diagrams as a tool.
tags: uml gitlab
---

We use GitLab in our team. It's handy to use UML in the process on any stage.
But drawing takes too much time. That's why it's better to use plain text online editor
[PlantUML](http://www.plantuml.com/plantuml/uml/) to compose in pure declarative way the UML diagram or ER-diagram schema.

```
@startuml
' hide the spot
hide circle

' avoid problems with angled crows feet
skinparam linetype ortho

entity "Entity01" as e01 {
  *e1_id : number <<generated>>
  --
  *name : text
  description : text
}

entity "Entity02" as e02 {
  *e2_id : number <<generated>>
  --
  *e1_id : number <<FK>>
  other_details : text
}

entity "Entity03" as e03 {
  *e3_id : number <<generated>>
  --
  e1_id : number <<FK>>
  other_details : text
}

e01 ||..o{ e02
e01 |o..o{ e03
@enduml
```

The tool can generate PNG file, that we can attach to a description or a comment in GitLab.

![ER-diagram example](/assets/images/2020-05-29-er-diagram.png "ER-diagram example")

Besides, we can save plain-text source of diagram to the file and commit it.
Later, correct it and even check by *git diff*, which is not possible with diagram in the form of a PNG image.

More examples:

```
@startuml
participant User

User -> A: DoWork
activate A

A -> B: << createRequest >>
activate B

B -> C: DoWork
activate C
C --> B: WorkDone
destroy C

B --> A: RequestCreated
deactivate B

A -> User: Done
deactivate A
@enduml
```

![Sequence Diagram  example](/assets/images/2020-05-29-sequence-diagram.png "Sequence Diagram example")
