## XPath

XPath --- способ извлечения информации из xml-документа.

*   Выборка/адресация нужных нод. Результат --- nodeset.
*   Вычисление выражений. Результат --- string, number, boolean.

Несмотря на то, что в названии xpath есть буква *x*, синтаксис xpath-выражений не xml'ный.
XPath --- это просто строка символов. С другой стороны, *path* указывает на сходство
с другими сходными технологиями: пути в файловой системе, урлы и т.д.

### Location Paths --- простейшие xpath'ы

Пример xml'я:

    <page name="index" xmlns:lego="https://lego.yandex-team.ru">
        <lego:l-head>
            <lego:b-head-logo>
                <lego:name>Видео</lego:name>
            </lego:b-head-logo>
        </lego:l-head>
    </page>

Самый простой --- `/`. Выбирает document-ноду.

Простой путь: `/page/lego:l-head`. Т.е. мы выбираем все элементы с именем `lego:l-head`,
которые являются непосредственным потомком элемента `page`, который, с свою очередь,
является непосредственным потомком document-ноды.

Более длинный путь --- `/page/lego:l-head/lego:b-head-logo/lego:name`. Т.е. location path ---
это несколько имен элементов, разделенных символом `/`, который обозначает отношение
"непосредственный потомок".

Практически полный аналог --- это файловая система. Например, `/usr/local/www/lego` ---
обозначает путь в файловой системе. Мы начинаем с корня --- `/`. Затем в корне мы ищем папка
с именем `usr`, если она существует, то в ней ищем папку `local`. И т.д.

Основной отличие: в файловой системе на каждом уровне может быть только один файл с заданным именем,
в xml на любом уровне может быть несколько нод --- результатом является множество нод --- nodeset.

Пример:

    <page name="index" xmlns:lego="https://lego.yandex-team.ru">
        <lego:l-head>
            <lego:b-head-logo>
                <lego:name>Видео</lego:name>
            </lego:b-head-logo>
        </lego:l-head>
        <lego:l-head>
            <lego:b-head-logo>
                <lego:name>Видео</lego:name>
            </lego:b-head-logo>
        </lego:l-head>
    </page>

Применяем тот же xpath --- `/page/lego:l-head/lego:b-head-logo/lego:name`.
Получаем множество, состоящее из двух нод `lego:name`.

`/page/lego:b-head-logo` --- является валидным xpath'ом, несмотря на то, что у элемента `page`
нет непосредственного потомка с именем `lego:b-head-logo`. Такой путь просто вернет
пустое множество нод.

Еще один аналог --- css-селекторы. Например: `div span a b`. Этот селектор выбирает
все элементы `b`, которые находятся внутри элементов `a`, которые находятся внутри `span`...
Правда в xpath разделитель `/` означает непосредственный потомок, а в css-селекторах
пробел означает просто потомок.

Поэтому аналогом xpath'а `/page/lego:l-head/lego:b-head-logo/lego:name`
будет селектор `div > span > a > b`.

Разделитель `//` означает отношение просто потомок (не обязательно непосредственный).
Селектор `/page/lego:b-head-logo` возвращает пустой нодесет, но `/page//lego:b-head-logo`
вернет все элементы `lego:b-head-logo`, находящиеся внутри корневых элементов `page`.

Путь `//lego:name` вернет все элементы `lego:name` в документе, независимо
от их расположения в документе.

Вроде как проще и удобнее писать просто `//lego:name` вместо длинного пути
`/page/lego:l-head/lego:b-head-logo/lego:name`. Но удобство дается не даром,
а за счет падения производительности. Чтобы выполнить первый xpath, нужно
проверить каждый элемент в дереве --- а не является ли он элементом с именем `lego:name`?
Второй путь намного более специфичен и количество нод, которые нужно проверить 
намного меньше. Как правило мы избегаем использовать `//`.

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


