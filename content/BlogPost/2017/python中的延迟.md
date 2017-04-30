> python版本3.5.2

python提供了工具在需要时才产生结果，即一次产生一个结果项，而不是在内存中一次产生全部结果列表。

延迟的核心是迭代器。

后面的内容包括以下几个部分，可迭代对象和迭代器，生成器，map和zip，filter和reduce，序列range，enumerate，文件迭代器，字典视图迭代器。

## 可迭代对象和迭代器

一个可迭代对象需要支持`__iter__()`和`__next__()`这两个方法，这两个方法构成迭代协议。

`__iter__()`返回迭代器对象本身,它允许对象（容器containers和迭代器iterators）在for和in表达式中直接使用；

`__next__()`返回容器container中的下一个元素，如果没有更多元素，则会引起`StopIteration`异常。

生成器是实现迭代协议的一种便利方式，如果一个容器对象的`__iter__()`是以生成器实现的，它会自动返回一个生成器对象。

> 在之后的阅读中始终注意，哪些对象本身就是迭代器，哪些对象需要使用iter(self)来返回迭代器。

## 生成器

**一个生成器的迭代器是生成器自身**。

**一个生成器运行到完成，必须产生一个新的生成器以再次开始**。

有两种语言结构尽可能的延迟结果创建，无需一次构建所有对象：生成器函数和生成器表达式。

1. 生成器函数

   举例说明，有如下定义：

   ```python
   def gen():
       for i in range(5):
           x = yield i
           print("x:",x)
   ```

   理解`yield`：

   yield表达式只在定义生成器函数时使用，而且也只能在函数体中使用。使用了yield表达式的函数会被特别的解释为生成器。yield语句挂起该函数并向调用者发送回一个值，同时保留足够的状态使得函数从离开的地方继续。

   当通过调用生成器的某个方法继续时，函数在yield返回后立即继续执行，继续时yield表达式的值取决于调用的方法，如果调用的是`__next__()`即内置函数`next()`,yield表达式的值为`None`,如果是`send()`，则yield表达式的值为传递给send方法的值。

   理解`yield from`：

   将后面的表达式视为子迭代器，子迭代器的所有返回值都会直接返回给当前生成器的调用者；同理，外部调用`send()`和`throw()`也可直接传递到子迭代器(也是生成器的话)内部。下面的两条语句作用是一致的：

   ```python
   yield from iterable
   for item in iterable: yield item
   ```

   当一个生成器函数被调用时，返回一个生成器作为迭代器，在一个list内置调用中包含一个生成器表达式以迫使其生成包含所有结果的列表：

   ```python
   >>>g = gen()
   >>>list(g)
   [0, 1, 2, 3, 4]
   ```

   也可以通过next方法依次获取,直到StopIteration异常，生成器运行完成：

   ```python
   >>>g = gen()
   >>>next(g)
   0
   >>>next(g)
   x: None
   1
   ···
   >>>next(g)
   StopIteration
   ```

   生成器函数协议中增加了一个send方法，send方法的行为可以这么理解:

   1. 将值发送给生成器，即回到生成器函数内部的，yield表达式返回发送的值：

      ```python
      >>>g = gen()
      >>>next(g)
      0
      >>>g.send(100)
      x: 100
      1
      ```

   2. 如果没有调用send，正常调用next，那么在生成器函数内部yield表达式返回None：

      ```Python
      >>>g = gen()
      >>>next(g)
      0
      >>>next(g)
      x: None
      1
      ```

   通过一个实例更好的理解`yield from`和生成器的`send`方法，定义如下两个生成器：

   ```Python
   def accumulate():
       tally = 0
       while 1:
           next = yield
           if next is None:
               return tally
           tally += next

   def gather_tallies(tallies):
       while 1:
           tally = yield from accumulate()
           tallies.append(tally)
   ```
   按如下方式进行调用：
   ```python
   tallies = []
   acc = gather_tallies(tallies)
   next(acc)  # Ensure the accumulator is ready to accept values

   for i in range(4):
       acc.send(i)
   acc.send(None)  # Finish the first tally

   for i in range(5):
       acc.send(i)
   acc.send(None)  # Finish the second tally

   >>>tallies
   [6, 10]
   ```

2. 生成器表达式

   迭代器和列表解析的概念形成生成器表达式，与列表解析不同，生成器表达式包含在园括号(parentheses)而不是方括号(brackets or curly braces)中，如(x ** 2 for x in range(4))。