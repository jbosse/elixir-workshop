## 00.md Introduction to Elixir Workshop
This is a small Elixir workshop I put together.
I have fallen in love with Elixir. Mostly for pattern matching which we will get to eventially, but also because I have found that I like building code using functions rather than objects. Elixir is a functional language built on top of Erlang but looks alot like Ruby. In fact, Elixir was created by Jose Valim who was a Ruby developer and worked on popular Ruby gems like Devise, which is the defacto authentication gem for Rails.

## 01 Overview

## 02 Installation

## 03 Basic Types

### Basic arithmetic

Open up `iex` and type the following expressions:

```elixir
iex> 1 + 2
3
iex> 5 * 5
25
iex> 10 / 2
5.0
```

Notice that `10 / 2` returned a float `5.0` instead of an integer `5`. This is expected. In Elixir, the operator `/` always returns a float. If you want to do integer division or get the division remainder, you can invoke the `div` and `rem` functions:

```elixir
iex> div(10, 2)
5
iex> div 10, 2
5
iex> rem 10, 3
1
```

Notice that Elixir allows you to drop the parentheses when invoking named functions. This feature gives a cleaner syntax when writing declarations and control-flow constructs.

Elixir also supports shortcut notations for entering binary, octal, and hexadecimal numbers:

```elixir
iex> 0b1010
10
iex> 0o777
511
iex> 0x1F
31
```

Float numbers require a dot followed by at least one digit and also support `e` for scientific notation:

```elixir
iex> 1.0
1.0
iex> 1.0e-10
1.0e-10
```

Floats in Elixir are 64-bit double precision.

You can invoke the `round` function to get the closest integer to a given float, or the `trunc` function to get the integer part of a float.

```elixir
iex> round(3.58)
4
iex> trunc(3.58)
3
```

### Booleans

Elixir supports `true` and `false` as booleans:

```elixir
iex> true
true
iex> true == false
false
```

Elixir provides a bunch of predicate functions to check for a value type. For example, the `is_boolean/1` function can be used to check if a value is a boolean or not:

```elixir
iex> is_boolean(true)
true
iex> is_boolean(1)
false
```

You can also use `is_integer/1`, `is_float/1` or `is_number/1` to check, respectively, if an argument is an integer, a float, or either.

### Atoms

An atom is a constant whose value is its own name. Some other languages call these symbols. They are often useful to enumerate over distinct values, such as:

```elixir
iex> :apple
:apple
iex> :orange
:orange
iex> :watermelon
:watermelon
```

Atoms are equal if their names are equal.

```elixir
iex> :apple == :apple
true
iex> :apple == :orange
false
```

Often they are used to express the state of an operation, by using values such as `:ok` and `:error`.

The booleans `true` and `false` are also atoms:

```elixir
iex> true == :true
true
iex> is_atom(false)
true
iex> is_boolean(:false)
true
```

Elixir allows you to skip the leading `:` for the atoms `false`, `true` and `nil`.


Finally, Elixir has a construct called aliases which we will explore later. Aliases start in upper case and are also atoms:

```elixir
iex> is_atom(Hello)
true
```

## Strings

Strings in Elixir are delimited by double quotes, and they are encoded in UTF-8:

```elixir
iex> "hellö"
"hellö"
```

> Note: if you are running on Windows, there is a chance your terminal does not use UTF-8 by default. You can change the encoding of your current session by running `chcp 65001` before entering IEx.

Elixir also supports string interpolation:

```elixir
iex> string = :world
iex> "hellö #{string}"
"hellö world"
```

Strings can have line breaks in them. You can introduce them using escape sequences:

```elixir
iex> "hello
...> world"
"hello\nworld"
iex> "hello\nworld"
"hello\nworld"
```

You can print a string using the `IO.puts/1` function from the `IO` module:

```elixir
iex> IO.puts "hello\nworld"
hello
world
:ok
```

Notice that the `IO.puts/1` function returns the atom `:ok` after printing.

Strings in Elixir are represented internally by contiguous sequences of bytes known as binaries:

```elixir
iex> is_binary("hellö")
true
```

We can also get the number of bytes in a string:

```elixir
iex> byte_size("hellö")
6
```

Notice that the number of bytes in that string is 6, even though it has 5 graphemes. That's because the grapheme "ö" takes 2 bytes to be represented in UTF-8. We can get the actual length of the string, based on the number of graphemes, by using the `String.length/1` function:

```elixir
iex> String.length("hellö")
5
```

The [String module](https://hexdocs.pm/elixir/String.html) contains a bunch of functions that operate on strings as defined in the Unicode standard:

```elixir
iex> String.upcase("hellö")
"HELLÖ"
```

### (Linked) Lists

Elixir uses square brackets to specify a list of values. Values can be of any type:

```elixir
iex> [1, 2, true, 3]
[1, 2, true, 3]
iex> length [1, 2, 3]
3
```

### Tuples

Elixir uses curly brackets to define tuples. Like lists, tuples can hold any value:

```elixir
iex> {:ok, "hello"}
{:ok, "hello"}
iex> tuple_size {:ok, "hello"}
2
```

Tuples store elements contiguously in memory. This means accessing a tuple element by index or getting the tuple size is a fast operation. Indexes start from zero:

```elixir
iex> tuple = {:ok, "hello"}
{:ok, "hello"}
iex> elem(tuple, 1)
"hello"
iex> tuple_size(tuple)
2
```

It is also possible to put an element at a particular index in a tuple with `put_elem/3`:

```elixir
iex> tuple = {:ok, "hello"}
{:ok, "hello"}
iex> put_elem(tuple, 1, "world")
{:ok, "world"}
iex> tuple
{:ok, "hello"}
```

Notice that `put_elem/3` returned a new tuple. The original tuple stored in the `tuple` variable was not modified. Like lists, tuples are also immutable. Every operation on a tuple returns a new tuple, it never changes the given one.


## 04 Anonymous Functions

Elixir also provides anonymous functions. Anonymous functions allow us to store and pass executable code around as if it was an integer or a string. They are delimited by the keywords `fn` and `end`:

```elixir
iex> add = fn a, b -> a + b end
#Function<12.71889879/2 in :erl_eval.expr/5>
iex> add.(1, 2)
3
iex> is_function(add)
true
```

In the example above, we defined an anonymous function that receives two arguments, `a` and `b`, and returns the result of `a + b`. The arguments are always on the left-hand side of `->` and the code to be executed on the right-hand side. The anonymous function is stored in the variable `add`.

Parenthesised arguments after the anonymous function indicate that we want the function to be evaluated, not just its definition returned.  Note that a dot (`.`) between the variable and parentheses is required to invoke an anonymous function. The dot ensures there is no ambiguity between calling the anonymous function matched to a variable `add` and a named function `add/2`. We will explore named functions when dealing with [Modules and Functions](/getting-started/modules-and-functions.html), since named functions can only be defined within a module. For now, just remember that Elixir makes a clear distinction between anonymous functions and named functions.

Anonymous functions in Elixir are also identified by the number of arguments they receive. We can check if a function is of any given arity by using `is_function/2`:

```elixir
# check if add is a function that expects exactly 2 arguments
iex> is_function(add, 2)
true
# check if add is a function that expects exactly 1 argument
iex> is_function(add, 1)
false
```

Finally, anonymous functions are also closures and as such they can access variables that are in scope when the function is defined. Let's define a new anonymous function that uses the `add` anonymous function we have previously defined:

```elixir
iex> double = fn a -> add.(a, a) end
#Function<6.71889879/1 in :erl_eval.expr/5>
iex> double.(2)
4
```

A variable assigned inside a function does not affect its surrounding environment:

```elixir
iex> x = 42
42
iex> (fn -> x = 0 end).()
0
iex> x
42
```

## 05 Pattern Matching: Match Operator

We have used the `=` operator a couple times to assign variables in Elixir:

```elixir
iex> x = 1
1
iex> x
1
```

In Elixir, the `=` operator is actually called *the match operator*. Let's see why:

```elixir
iex> x = 1
1
iex> 1 = x
1
iex> 2 = x
** (MatchError) no match of right hand side value: 1
```

Notice that `1 = x` is a valid expression, and it matched because both the left and right side are equal to 1. When the sides do not match, a `MatchError` is raised.

A variable can only be assigned on the left side of `=`:

```elixir
iex> 1 = unknown
** (CompileError) iex:1: undefined function unknown/0
```

Since there is no variable `unknown` previously defined, Elixir assumed you were trying to call a function named `unknown/0`, but such a function does not exist.

## 06 Pattern Matching: Descructuring

The match operator is not only used to match against simple values, but it is also useful for destructuring more complex data types. For example, we can pattern match on tuples:

```elixir
iex> {a, b, c} = {:hello, "world", 42}
{:hello, "world", 42}
iex> a
:hello
iex> b
"world"
```

A pattern match error will occur if the sides can't be matched, for example if the tuples have different sizes:

```elixir
iex> {a, b, c} = {:hello, "world"}
** (MatchError) no match of right hand side value: {:hello, "world"}
```

And also when comparing different types:

```elixir
iex> {a, b, c} = [:hello, "world", 42]
** (MatchError) no match of right hand side value: [:hello, "world", 42]
```

More interestingly, we can match on specific values. The example below asserts that the left side will only match the right side when the right side is a tuple that starts with the atom `:ok`:

```elixir
iex> {:ok, result} = {:ok, 13}
{:ok, 13}
iex> result
13

iex> {:ok, result} = {:error, :oops}
** (MatchError) no match of right hand side value: {:error, :oops}
```

We can pattern match on lists:

```elixir
iex> [a, b, c] = [1, 2, 3]
[1, 2, 3]
iex> a
1
```

A list also supports matching on its own head and tail:

```elixir
iex> [head | tail] = [1, 2, 3]
[1, 2, 3]
iex> head
1
iex> tail
[2, 3]
```


### The pin operator

Variables in Elixir can be rebound:

```elixir
iex> x = 1
1
iex> x = 2
2
```
However, there are times when we don't want variables to be rebound.

Use the pin operator `^` when you want to pattern match against a variable's _existing value_ rather than rebinding the variable.

```elixir
iex> x = 1
1
iex> ^x = 2
** (MatchError) no match of right hand side value: 2
```

Because we have pinned `x` when it was bound to the value of `1`, it is equivalent to the following:

```elixir
iex> 1 = 2
** (MatchError) no match of right hand side value: 2
```

Notice that we even see the exact same error message.

We can use the pin operator inside other pattern matches, such as tuples or lists:

```elixir
iex> x = 1
1
iex> [^x, 2, 3] = [1, 2, 3]
[1, 2, 3]
iex> {y, ^x} = {2, 1}
{2, 1}
iex> y
2
iex> {y, ^x} = {2, 2}
** (MatchError) no match of right hand side value: {2, 2}
```

Because `x` was bound to the value of `1` when it was pinned, this last example could have been written as:

```elixir
iex> {y, 1} = {2, 2}
** (MatchError) no match of right hand side value: {2, 2}
```

If a variable is mentioned more than once in a pattern, all references should bind to the same value:

```elixir
iex> {x, x} = {1, 1}
{1, 1}
iex> {x, x} = {1, 2}
** (MatchError) no match of right hand side value: {1, 2}
```

In some cases, you don't care about a particular value in a pattern. It is a common practice to bind those values to the underscore, `_`. For example, if only the head of the list matters to us, we can assign the tail to underscore:

```elixir
iex> [head | _] = [1, 2, 3]
[1, 2, 3]
iex> head
1
```

The variable `_` is special in that it can never be read from. Trying to read from it gives a compile error:

```elixir
iex> _
** (CompileError) iex:1: invalid use of _. "_" represents a value to be ignored in a pattern and cannot be used in expressions
```

Although pattern matching allows us to build powerful constructs, its usage is limited. For instance, you cannot make function calls on the left side of a match. The following example is invalid:

```elixir
iex> length([1, [2], 3]) = 3
** (CompileError) iex:1: cannot invoke remote function :erlang.length/1 inside match
```

This finishes our introduction to pattern matching. As we will see in the next chapter, pattern matching is very common in many language constructs.

## 07 Lists

Two lists can be concatenated or subtracted using the `++/2` and `--/2` operators respectively:

```elixir
iex> [1, 2, 3] ++ [4, 5, 6]
[1, 2, 3, 4, 5, 6]
iex> [1, true, 2, false, 3, true] -- [true, false]
[1, 2, 3, true]
```

List operators never modify the existing list. Concatenating to or removing elements from a list returns a new list. We say that Elixir data structures are *immutable*. One advantage of immutability is that it leads to clearer code. You can freely pass the data around with the guarantee no one will mutate it in memory - only transform it.

Throughout the tutorial, we will talk a lot about the head and tail of a list. The head is the first element of a list and the tail is the remainder of the list. They can be retrieved with the functions `hd/1` and `tl/1`. Let's assign a list to a variable and retrieve its head and tail:

```elixir
iex> list = [1, 2, 3]
iex> hd(list)
1
iex> tl(list)
[2, 3]
```

Getting the head or the tail of an empty list throws an error:

```elixir
iex> hd []
** (ArgumentError) argument error
```

_KEYWORD LISTS ARE A THING BUT WE ARE SKIPPING_

## 08 Maps

Whenever you need a key-value store, maps are the "go to" data structure in Elixir. A map is created using the `%{}` syntax:

```elixir
iex> map = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}
iex> map[:a]
1
iex> map[2]
:b
iex> map[:c]
nil
```

Compared to keyword lists, we can already see two differences:

  * Maps allow any value as a key.
  * Maps' keys do not follow any ordering.

In contrast to keyword lists, maps are very useful with pattern matching. When a map is used in a pattern, it will always match on a subset of the given value:

```elixir
iex> %{} = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}
iex> %{:a => a} = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}
iex> a
1
iex> %{:c => c} = %{:a => 1, 2 => :b}
** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}
```

As shown above, a map matches as long as the keys in the pattern exist in the given map. Therefore, an empty map matches all maps.

Variables can be used when accessing, matching and adding map keys:

```elixir
iex> n = 1
1
iex> map = %{n => :one}
%{1 => :one}
iex> map[n]
:one
iex> %{^n => :one} = %{1 => :one, 2 => :two, 3 => :three}
%{1 => :one, 2 => :two, 3 => :three}
```

[The `Map` module](https://hexdocs.pm/elixir/Map.html) provides a very similar API to the `Keyword` module with convenience functions to manipulate maps:

```elixir
iex> Map.get(%{:a => 1, 2 => :b}, :a)
1
iex> Map.put(%{:a => 1, 2 => :b}, :c, 3)
%{2 => :b, :a => 1, :c => 3}
iex> Map.to_list(%{:a => 1, 2 => :b})
[{2, :b}, {:a, 1}]
```

Maps have the following syntax for updating a key's value:

```elixir
iex> map = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}

iex> %{map | 2 => "two"}
%{2 => "two", :a => 1}
iex> %{map | :c => 3}
** (KeyError) key :c not found in: %{2 => :b, :a => 1}
```

The syntax above requires the given key to exist. It cannot be used to add new keys. For example, using it with the `:c` key failed because there is no `:c` in the map.

When all the keys in a map are atoms, you can use the keyword syntax for convenience:

```elixir
iex> map = %{a: 1, b: 2}
%{a: 1, b: 2}
```

Another interesting property of maps is that they provide their own syntax for accessing atom keys:

```elixir
iex> map = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}

iex> map.a
1
iex> map.c
** (KeyError) key :c not found in: %{2 => :b, :a => 1}
```

Elixir developers typically prefer to use the `map.field` syntax and pattern matching instead of the functions in the `Map` module when working with maps because they lead to an assertive style of programming. [This blog post by José Valim](https://dashbit.co/blog/writing-assertive-code-with-elixir) provides insight and examples on how you get more concise and faster software by writing assertive code in Elixir.

## 09 Structs
* `iex> c "./scripts/account.exs"`
To define a struct, the `defstruct` construct is used:

```elixir
iex> defmodule User do
...>   defstruct name: "John", age: 27
...> end
```

The keyword list used with `defstruct` defines what fields the struct will have along with their default values.

Structs take the name of the module they're defined in. In the example above, we defined a struct named `User`.

We can now create `User` structs by using a syntax similar to the one used to create maps (if you have defined the struct in a separate file, you can compile the file inside IEx before proceeding by running `c "file.exs"`; be aware you may get an error saying `the struct was not yet defined` if you try the below example in a file directly due to when definitions are resolved):

```elixir
iex> %User{}
%User{age: 27, name: "John"}
iex> %User{name: "Jane"}
%User{age: 27, name: "Jane"}
```

Structs provide *compile-time* guarantees that only the fields (and *all* of them) defined through `defstruct` will be allowed to exist in a struct:

```elixir
iex> %User{oops: :field}
** (KeyError) key :oops not found in: %User{age: 27, name: "John"}
```

### Accessing and updating structs

When we discussed maps, we showed how we can access and update the fields of a map. The same techniques (and the same syntax) apply to structs as well:

```elixir
iex> john = %User{}
%User{age: 27, name: "John"}
iex> john.name
"John"
iex> jane = %{john | name: "Jane"}
%User{age: 27, name: "Jane"}
iex> %{jane | oops: :field}
** (KeyError) key :oops not found in: %User{age: 27, name: "Jane"}
```

When using the update syntax (`|`), the <abbr title="Virtual Machine">VM</abbr> is aware that no new keys will be added to the struct, allowing the maps underneath to share their structure in memory. In the example above, both `john` and `jane` share the same key structure in memory.

Structs can also be used in pattern matching, both for matching on the value of specific keys as well as for ensuring that the matching value is a struct of the same type as the matched value.

```elixir
iex> %User{name: name} = john
%User{age: 27, name: "John"}
iex> name
"John"
iex> %User{} = %{}
** (MatchError) no match of right hand side value: %{}
```


### Default values and required keys

If you don't specify a default key value when defining a struct, `nil` will be assumed:

```elixir
iex> defmodule Product do
...>   defstruct [:name]
...> end
iex> %Product{}
%Product{name: nil}
```

You can define a structure combining both fields with explicit default values, and implicit `nil` values. In this case you must first specify the fields which implicitly default to nil:

```elixir
iex> defmodule User do
...>   defstruct [:email, name: "John", age: 27]
...> end
iex> %User{}
%User{age: 27, email: nil, name: "John"}
```

Doing it in reverse order will raise a syntax error:

```elixir
iex> defmodule User do                          
...>   defstruct [name: "John", age: 27, :email]
...> end
** (SyntaxError) iex:107: syntax error before: email
```

You can also enforce that certain keys have to be specified when creating the struct:

```elixir
iex> defmodule Car do
...>   @enforce_keys [:make]
...>   defstruct [:model, :make]
...> end
iex> %Car{}
** (ArgumentError) the following keys must also be given when building struct Car: [:make]
    expanding struct: Car.__struct__/1
```

## 10 If

Besides `case` and `cond`, Elixir also provides the macros `if/2` and `unless/2` which are useful when you need to check for only one condition:

```elixir
iex> if true do
...>   "This works!"
...> end
"This works!"
iex> unless true do
...>   "This will never be seen"
...> end
nil
```

If the condition given to `if/2` returns `false` or `nil`, the body given between `do/end` is not executed and instead it returns `nil`. The opposite happens with `unless/2`.

They also support `else` blocks:

```elixir
iex> if nil do
...>   "This won't be seen"
...> else
...>   "This will"
...> end
"This will"
```

> Note: An interesting note regarding `if/2` and `unless/2` is that they are implemented as macros in the language; they aren't special language constructs as they would be in many languages. You can check the documentation and the source of `if/2` in [the `Kernel` module docs](https://hexdocs.pm/elixir/Kernel.html). The `Kernel` module is also where operators like `+/2` and functions like `is_function/2` are defined, all automatically imported and available in your code by default.

## 11 Case

`case` allows us to compare a value against many patterns until we find a matching one:

```elixir
iex> case {1, 2, 3} do
...>   {4, 5, 6} ->
...>     "This clause won't match"
...>   {1, x, 3} ->
...>     "This clause will match and bind x to 2 in this clause"
...>   _ ->
...>     "This clause would match any value"
...> end
"This clause will match and bind x to 2 in this clause"
```

If you want to pattern match against an existing variable, you need to use the `^` operator:

```elixir
iex> x = 1
1
iex> case 10 do
...>   ^x -> "Won't match"
...>   _ -> "Will match"
...> end
"Will match"
```

Clauses also allow extra conditions to be specified via guards:

```elixir
iex> case {1, 2, 3} do
...>   {1, x, 3} when x > 0 ->
...>     "Will match"
...>   _ ->
...>     "Would match, if guard condition were not satisfied"
...> end
"Will match"
```

The first clause above will only match when `x` is positive.

Keep in mind errors in guards do not leak but simply make the guard fail:

```elixir
iex> hd(1)
** (ArgumentError) argument error
iex> case 1 do
...>   x when hd(x) -> "Won't match"
...>   x -> "Got #{x}"
...> end
"Got 1"
```

If none of the clauses match, an error is raised:

```elixir
iex> case :ok do
...>   :error -> "Won't match"
...> end
** (CaseClauseError) no case clause matching: :ok
```

Consult [the full documentation for guards](https://hexdocs.pm/elixir/patterns-and-guards.html#guards) for more information about guards, how they are used, and what expressions are allowed in them.

Note anonymous functions can also have multiple clauses and guards:

```elixir
iex> f = fn
...>   x, y when x > 0 -> x + y
...>   x, y -> x * y
...> end
#Function<12.71889879/2 in :erl_eval.expr/5>
iex> f.(1, 3)
4
iex> f.(-1, 3)
-3
```

The number of arguments in each anonymous function clause needs to be the same, otherwise an error is raised.

```elixir
iex> f2 = fn
...>   x, y when x > 0 -> x + y
...>   x, y, z -> x * y + z
...> end
** (CompileError) iex:1: cannot mix clauses with different arities in anonymous functions

## 12 Cond
`case` is useful when you need to match against different values. However, in many circumstances, we want to check different conditions and find the first one that does not evaluate to `nil` or `false`. In such cases, one may use `cond`:

```elixir
iex> cond do
...>   2 + 2 == 5 ->
...>     "This will not be true"
...>   2 * 2 == 3 ->
...>     "Nor this"
...>   1 + 1 == 2 ->
...>     "But this will"
...> end
"But this will"
```

This is equivalent to `else if` clauses in many imperative languages (although used much less frequently here).

If all of the conditions return `nil` or `false`, an error (`CondClauseError`) is raised. For this reason, it may be necessary to add a final condition, equal to `true`, which will always match:

```elixir
iex> cond do
...>   2 + 2 == 5 ->
...>     "This is never true"
...>   2 * 2 == 3 ->
...>     "Nor this"
...>   true ->
...>     "This is always true (equivalent to else)"
...> end
"This is always true (equivalent to else)"
```

Finally, note `cond` considers any value besides `nil` and `false` to be true:

```elixir
iex> cond do
...>   hd([1, 2, 3]) ->
...>     "1 is considered as true"
...> end
"1 is considered as true"
```

## 13 Modules and Functions
`iex> c "./scripts/matxh.exs"`

In Elixir we group several functions into modules. 

Common core modules are String, Enum, and IO

In order to create our own modules in Elixir, we use the `defmodule` macro. We use the `def` macro to define functions in that module

Inside a module, we can define functions with `def/2` and private functions with `defp/2`. A function defined with `def/2` can be invoked from other modules while a private function can only be invoked locally.

### Default arguments

Named functions in Elixir also support default arguments:

```elixir
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
```

Any expression is allowed to serve as a default value, but it won't be evaluated during the function definition. Every time the function is invoked and any of its default values have to be used, the expression for that default value will be evaluated:

```elixir
defmodule DefaultTest do
  def dowork(x \\ "hello") do
    x
  end
end
```

```elixir
iex> DefaultTest.dowork
"hello"
iex> DefaultTest.dowork 123
123
iex> DefaultTest.dowork
"hello"
```

If a function with default values has multiple clauses, it is required to create a function head (without an actual body) for declaring defaults:

```elixir
defmodule Concat do
  # A function head declaring defaults
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
IO.puts Concat.join("Hello")               #=> Hello
```

*The leading underscore in `_sep` means that the variable will be ignored in this function; see [Naming Conventions](https://hexdocs.pm/elixir/master/naming-conventions.html#underscore-_foo).*

When using default values, one must be careful to avoid overlapping function definitions. Consider the following example:

```elixir
defmodule Concat do
  def join(a, b) do
    IO.puts "***First join"
    a <> b
  end

  def join(a, b, sep \\ " ") do
    IO.puts "***Second join"
    a <> sep <> b
  end
end
```

If we save the code above in a file named "concat.ex" and compile it, Elixir will emit the following warning:

    warning: this clause cannot match because a previous clause at line 2 always matches

The compiler is telling us that invoking the `join` function with two arguments will always choose the first definition of `join` whereas the second one will only be invoked when three arguments are passed:

```console
$ iex concat.ex
```

```elixir
iex> Concat.join "Hello", "world"
***First join
"Helloworld"
```

```elixir
iex> Concat.join "Hello", "world", "_"
***Second join
"Hello_world"
```

## 14 & 15 Pattern Matching Functions
* `iex> c "./scripts/jimmy.exs"`

## 16 My Favorite Operator
`iex> c "./scripts/favorite.exs"`

## 17 Processes

### spawn
In Elixir, all code runs inside processes. Processes are isolated from each other, run concurrent to one another and communicate via message passing. Processes are not only the basis for concurrency in Elixir, but they also provide the means for building distributed and fault-tolerant programs.

Elixir’s processes should not be confused with operating system processes. Processes in Elixir are extremely lightweight in terms of memory and CPU (even compared to threads as used in many other programming languages). Because of this, it is not uncommon to have tens or even hundreds of thousands of processes running simultaneously.

### send/receive
We can send messages to a process with send/2 and receive them with receive/1:

### links
The majority of times we spawn processes in Elixir, we spawn them as linked processes. Before we show an example with spawn_link/1, let’s see what happens when a process started with spawn/1 fails:

```elixir
iex> spawn fn -> raise "oops" end
#PID<0.58.0>
[error] Process #PID<0.58.00> raised an exception
** (RuntimeError) oops
    (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6
```

It merely logged an error but the parent process is still running. That’s because processes are isolated. If we want the failure in one process to propagate to another one, we should link them. This can be done with spawn_link/1:

```elixir
iex> self()
#PID<0.41.0>
iex> spawn_link fn -> raise "oops" end

** (EXIT from #PID<0.41.0>) evaluator process exited with reason: an exception was raised:
    ** (RuntimeError) oops
        (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6

[error] Process #PID<0.289.0> raised an exception
** (RuntimeError) oops
    (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6
```
Because processes are linked, we now see a message saying the parent process, which is the shell process, has received an EXIT signal from another process causing the shell to terminate. IEx detects this situation and starts a new shell session.

## 18 Tasks
Tasks build on top of the spawn functions to provide better error reports and introspection:
```elixir
iex(1)> Task.start fn -> raise "oops" end
{:ok, #PID<0.55.0>}

15:22:33.046 [error] Task #PID<0.55.0> started from #PID<0.53.0> terminating
** (RuntimeError) oops
    (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6
    (elixir) lib/task/supervised.ex:85: Task.Supervised.do_apply/2
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Function: #Function<20.99386804/0 in :erl_eval.expr/5>
    Args: []
```
Instead of spawn/1 and spawn_link/1, we use Task.start/1 and Task.start_link/1 which return {:ok, pid} rather than just the PID. This is what enables tasks to be used in supervision trees. Furthermore, Task provides convenience functions, like Task.async/1 and Task.await/1, and functionality to ease distribution.

## 19 State
```elixir
iex> c "./scripts/parrot.exs"
iex> parrot = Parrot.start_link(%{name: "Polly", health: 0})
iex> send(parrot, {:say, "Pretty bird!"})
iex> send(parrot, :hello)
iex> send(parrot, {:feed, 3})
iex> send(parrot, {:feed, 2})
```

## 20 Agent
Elixir is an immutable language where nothing is shared by default. If we want to share information, which can be read and modified from multiple places, we have two main options in Elixir:

Agents are simple wrappers around state. If all you want from a process is to keep state, agents are a great fit. Let’s start an iex session inside the project with:
```elixir
iex> {:ok, agent} = Agent.start_link fn -> [] end
{:ok, #PID<0.57.0>}
iex> Agent.update(agent, fn list -> ["eggs" | list] end)
:ok
iex> Agent.get(agent, fn list -> list end)
["eggs"]
iex> Agent.stop(agent)
:ok
```

## 21 GenServer
GenServer provides industrial strength functionality for building servers in both Elixir and OTP.

There are two types of requests you can send to a GenServer: calls and casts. Calls are synchronous and the server must send a response back to such requests. While the server computes the response, the client is waiting. Casts are asynchronous: the server won’t send a response back and therefore the client won’t wait for one. Both requests are messages sent to the server, and will be handled in sequence. In the above implementation, we pattern-match on the :create messages, to be handled as cast, and on the :lookup messages, to be handled as call.

```elixir
iex> c "./scripts/parrot_server.exs"
iex> {:ok, parrot} = GenServer.start_link(Parrot, %{name: "Polly", health: 0})
iex> GenServer.call(parrot, {:say, "Pretty bird!"})
iex> GenServer.call(parrot, :hello)
iex> GenServer.cast(parrot, {:feed, 3})
iex> GenServer.cast(parrot, {:feed, 2})
iex> GenServer.call(parrot, :health)
```

## 22 Erlang Term Storage
ETS allows us to store any Elixir term in an in-memory table. Working with ETS tables is done via Erlang’s :ets module:
```
iex> table = :ets.new(:buckets_registry, [:set, :protected])
#Reference<0.1885502827.460455937.234656>
iex> :ets.insert(table, {"foo", self()})
true
iex> :ets.lookup(table, "foo")
[{"foo", #PID<0.41.0>}]
```

When creating an ETS table, two arguments are required: the table name and a set of options. From the available options, we passed the table type and its access rules. We have chosen the :set type, which means that keys cannot be duplicated. We’ve also set the table’s access to :protected, meaning only the process that created the table can write to it, but all processes can read from it. The possible access controls:

:public — Read/Write available to all processes. :protected — Read available to all processes. Only writable by owner process. This is the default. :private — Read/Write limited to owner process.

Be aware that if your Read/Write call violates the access control, the operation will raise ArgumentError. Finally, since :set and :protected are the default values, we will skip them from now on.

ETS tables can also be named, allowing us to access them by a given name:

```
iex> :ets.new(:buckets_registry, [:named_table])
:buckets_registry
iex> :ets.insert(:buckets_registry, {"foo", self()})
true
iex> :ets.lookup(:buckets_registry, "foo")
[{"foo", #PID<0.41.0>}]
```

## 23 Mix
Mix is a build tool that provides tasks for creating, compiling, and testing Elixir projects, managing its dependencies, and more.

If you’re familiar with Ruby, Mix is Bundler, RubyGems, and Rake combined. It’s a crucial part of any Elixir project and in this lesson we’re going to explore just a few of its great features. To see all that Mix has to offer in the current environment run mix help.

## 24 Game of Life


https://www.freecodecamp.org/news/how-to-build-a-distributed-game-of-life-in-elixir-9152588100cd/

```
# Alias the module so it can be called as Bar instead of Foo.Bar
alias Foo.Bar, as: Bar

# Require the module in order to use its macros
require Foo

# Import functions from Foo so they can be called without the `Foo.` prefix
import Foo

# Invokes the custom code defined in Foo as an extension point
use Foo
```

```elixir
# test/game_of_life/cell_test.exs
defmodule GameOfLife.CellTest do
  use ExUnit.Case, async: true

  test "alive cell with no neighbours dies" do
    alive_cell = {1, 1}
    alive_cells = [alive_cell]
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with 1 neighbour dies" do
    alive_cell = {1, 1}
    alive_cells = [alive_cell, {0, 0}]
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with more than 3 neighbours dies" do
    alive_cell = {1, 1}
    alive_cells = [alive_cell, {0, 0}, {1, 0}, {2, 0}, {2, 1}]
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with 2 neighbours lives" do
    alive_cell = {1, 1}
    alive_cells = [alive_cell, {0, 0}, {1, 0}]
    assert GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with 3 neighbours lives" do
    alive_cell = {1, 1}
    alive_cells = [alive_cell, {0, 0}, {1, 0}, {2, 1}]
    assert GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "dead cell with three live neighbours becomes a live cell" do
    alive_cells = [{2, 2}, {1, 0}, {2, 1}]
    dead_cell = {1, 1}
    assert GameOfLife.Cell.become_alive?(alive_cells, dead_cell)
  end

  test "dead cell with two live neighbours stays dead" do
    alive_cells = [{2, 2}, {1, 0}]
    dead_cell = {1, 1}
    refute GameOfLife.Cell.become_alive?(alive_cells, dead_cell)
  end

  test "find dead cells (neighbours of alive cell)" do
    alive_cells = [{1, 1}]
    dead_neighbours = GameOfLife.Cell.dead_neighbours(alive_cells) |> Enum.sort()

    expected_dead_neighbours =
      [{0, 0}, {1, 0}, {2, 0}, {0, 1}, {2, 1}, {0, 2}, {1, 2}, {2, 2}] |> Enum.sort()

    assert dead_neighbours == expected_dead_neighbours
  end

  test "find dead cells (neighbours of alive cells)" do
    alive_cells = [{1, 1}, {2, 1}]
    dead_neighbours = GameOfLife.Cell.dead_neighbours(alive_cells) |> Enum.sort()

    expected_dead_neighbours =
      [{0, 0}, {1, 0}, {2, 0}, {3, 0}, {0, 1}, {3, 1}, {0, 2}, {1, 2}, {2, 2}, {3, 2}]
      |> Enum.sort()

    assert dead_neighbours == expected_dead_neighbours
  end
end

# lib/game_of_life/cell.ex
defmodule GameOfLife.Cell do
  def keep_alive?(alive_cells, {x, y} = _alive_cell) do
    # TODO  
  end
end


# test/game_of_life/board.exs
defmodule GameOfLife.BoardTest do
  use ExUnit.Case, async: true

  test "add new cells to alive cells without duplicates" do
    alive_cells = [{1, 1}, {2, 2}]
    new_cells = [{0, 0}, {1, 1}]
    actual_alive_cells = GameOfLife.Board.add_cells(alive_cells, new_cells)
                          |> Enum.sort
    expected_alive_cells = [{0, 0}, {1, 1}, {2, 2}]
    assert actual_alive_cells == expected_alive_cells
  end


  test "remove cells which must be killed from alive cells" do
    alive_cells = [{1, 1}, {4, -2}, {2, 2}, {2, 1}]
    kill_cells = [{1, 1}, {2, 2}]
    actual_alive_cells = GameOfLife.Board.remove_cells(alive_cells, kill_cells)
    expected_alive_cells = [{4, -2}, {2, 1}]
    assert actual_alive_cells == expected_alive_cells
  end


  test "alive cell with 2 neighbours lives on to the next generation" do
    alive_cells = [{0, 0}, {1, 0}, {2, 0}]
    expected_alive_cells = [{1, 0}]
    assert GameOfLife.Board.keep_alive_tick(alive_cells) == expected_alive_cells
  end


  test "dead cell with three live neighbours becomes a live cell" do
    alive_cells = [{0, 0}, {1, 0}, {2, 0}, {1, 1}]
    born_cells = GameOfLife.Board.become_alive_tick(alive_cells)
    expected_born_cells = [{1, -1}, {0, 1}, {2, 1}]
    assert born_cells == expected_born_cells
  end
end

# lib/game_of_life/board.ex
defmodule GameOfLife.Board do
  def add_cells(alive_cells, new_cells) do
    #TODO
  end

  def remove_cells(alive_cells, kill_cells) do
    #TODO
  end

  def keep_alive_tick(alive_cells) do
    #TODO
  end

  def become_alive_tick(alive_cells) do
    #TODO
  end
end
```

Cheat: `cp = for x <- [1, 2, 3], y <- [1, 2, 3], do: {x, y}`
