# ruby-initializer-variables package

Atom package to turn arguments in a Ruby class initializer into instance variables. Variables will be created for the arguments that are in the current selection.

eg:

```
class MyAmazingClass
  def initialize(arg1, arg2: 'value', arg3 = nil)
  end
end

```

will become

```
class MyAmazingClass
  def initialize(arg1, arg2: 'value', arg3 = nil)
    @arg1 = arg1
    @arg2 = arg2
    @arg3 = arg3
  end
end
```
