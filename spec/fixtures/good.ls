# Easy listing of implicit objects
table1 =
  * id: 1
    name: 'george'
  * id: 2
    name: 'mike'
  * id: 3
    name: 'donald'

table2 =
  * id: 2
    age: 21
  * id: 1
    age: 20
  * id: 3
    age: 26

# Implicit access, accessignment
up-case-name = (.name .= to-upper-case!)

# List comprehensions, destructuring, piping
[{id:id1, name, age} for {id:id1, name} in table1
                     for {id:id2, age} in table2
                     when id1 is id2]

# Unicode variables
Ω = 'blah'
