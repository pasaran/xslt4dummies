## XPath

`/`

`/page/l-head/b-head-logo/name`

аналог в файловой системе: /usr/local/www/lego

разница: в ФС всегда ровно один файл, в xml на любом уровне может быть несколько нод - результат node-set

еще аналог - css-селекторы: div span a b

разница: в xpath на каждом шаге требуется прямой потомок, в css просто потомок.

правильный аналог: //div//span//a//b или div > span > a > b

декомпозиция/транзитивность: cd /usr/local; cd www/lego = cd /usr/local/www/lego

/page/l-head + b-head-logo/name = /page/l-head/b-head-logo/name

контекст: current dir

относительные и абсолютные пути: /page/head/logo и page/head/logo

cd /; cd usr/local; cd www/lego - первая команда меняет контекст

cd usr/local/www - результат выполнения зависит от контекста - pwd

отсутствие выделенных атрибут-селекторов а-ля #a и .a, @attr xpath

/page/@name - выбор ноды атрибута

/page/l-head/b-head-logo/name/text() - текстовая нода

значение нод name и name/text() одинаковое, а ноды разные

если нам нужно именно значение, то можно отбросить text() - шоткат

parent xpath: .. - как правило относительный xpath

/.. - пустой нодесет

../../@name, ../b-head-tabs в контексте b-head-logo

self xpath: . - собственно контекстный узел

оси: предопределенные наборы узлов в контексте, например:

потомки, атрибуты и т.д.

axis::element

оси: child, descendant, ancestor, self, attribute

шоткаты к ним: *, //, .., ., @

wildcards: *, @*, bla:*, node()

отличие * от node()

@blag:* или blah:@* - не работает

рабочий вариант через предикаты и name()/namespace-uri()

остальные оси: descendant-or-self, ancestor-or-self,

preceding-sibling, following-sibling,

preceding, following, namespace

объединение xpath'ов через |

объединение не равно последовательному выполнению

предикаты = фильтр = grep - булевское выражение,

вычисляемое в контексте ноды, фильтрующее нодесет

простые предикаты: [1], [2], [last()], [position() <= 5], [position() mod 2 = 0]

предикаты:

    [element-name]
    [@attr-name]
    [. != ''] = [text() != '']
    [. = 'some string']
    [element = 'value']
    [@attr = 'value']
    [some-function()] (contains, starts-with)

    name(), local-name(), namespace-uri()

    [some-function() =<> value] (string-length, count, substring, substring-after, substring-before)
    [node-set = 'value'], [node-set = node-set]
    [expr and expr], [expr or expr], [not(expr)]
    [a != b] vs. [not(a = b)]

на самом деле предикат это xpath

результатом xpath'а не обязательно должен быть node-set -

это может быть число, строка, булевский тип

типы: boolean, number, string, node-set

приведение всего в string и boolean (string(), boolean())

вложенные предикаты: node1[node2[expr]]

множественные предикаты: node[expr][expr]

[expr1][expr2] vs. [expr2][expr1] vs [expr1 and expr2]

функции: normalize-space, concat, translate, true, false, lang

floor, ceiling, round

current, generate-id, document


