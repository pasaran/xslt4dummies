# XSLT

Stylesheet --- это набор правил-шаблонов, работающих в контексте определенной ноды.
В процессе xslt-преобразования мы обходим в определенном порядке исходное xml-дерево
(т.е. перемещаем текущий контекст от одной ноды к другой) и к каждой контекстной ноде
применяем подходящий шаблон.

## Шаблоны

Каждый шаблон состоит из двух частей:

*   контекста, в котором он работает и
*   действия в этом контексте

Простой пример:

    <xsl:template match="/">
        <html>
            <body>
                <h1>Hello, World</h1>
            </body>
        </html>
    </xsl:template>

### Контекст

Содержимое атрибута `match` --- это xpath, определяющий контекст.
Если в процессе обхода дерева мы попадем в ноду, соответствующую ему,
то будет исполнен этот шаблон.

Важный момент --- если к данной ноде будет несколько подходящих шаблонов,
то будет исполнен только один --- самый подходящий.

### Аналогия с CSS

Правила css устроены похожим образом. У них есть часть, отвечающая за контекст ---
к каким нодам будет применено это правило, и действие --- собственно стили, которые
будут применены к этим нодам.

Отличия:

*   Если несколько css-правил подходят для некоторой ноды, то они будут
    применены все. В xslt это не так --- применяется всегда ровно одно правило.

*   В css отсутствует обход дерева. Т.е. если есть нода и правило, подходящее к ней,
    то оно будет применено. В xslt может быть так, что есть и нода, и шаблон, но при обходе
    дерева контекст не попадет в эту ноду и шаблон не применится.

### Действие

Все, что находится между тегами `<xsl:template>` и `</xsl:template>` описывает результат применения
шаблона к ноде. Более сложный пример:

    <xsl:template match="page">
        <html>
            <head>
                <title><xsl:value-of select="@title"/></title>
            </head>
            <body>
                <xsl:if test="@name = 'index'">
                    <xsl:attribute name="class">index</xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

Что вообще бывает внутри шаблона:

*   Literate result elements --- т.е. это просто html-разметка,
    которая будет скопирована в результирующее дерево.
    Все, что не в неймспейсе xsl просто копируется (если ничего специально не сделано).

*   XSLT-конструкции, которые создают разметку или текст:

    *   xsl:value-of
    *   xsl:text
    *   xsl:element
    *   xsl:attribute
    *   xsl:copy
    *   xsl:copy-of

*   Управляющие xslt-конструкции:

    *   xsl:if
    *   xsl:choose
    *   xsl:for-each

*   XSLT-конструкции "передающие управление":

    *   xsl:apply-templates
    *   xsl:call-template
    *   xsl:apply-imports

## Обход дерева

1.  Начальный контекст устанавливается в ноду документа --- `/`.
2.  Ищется шаблон, подходящий для контекстной ноды. Если нет явно заданного шаблона,
    используется дефолтный.
3.  Если в процессе выполнения шаблона встречаются конструкции

    *   xsl:apply-templates
    *   xsl:call-template
    *   xsl:apply-imports

    то контекст меняется соответственно и переходим к п.2
4.  Если же этих конструкций нет, то результат --- literate result elements и
    сгенеренные xsl-конструкциями элементы --- копируется в выходной дерево и
    управление переходит в то место, откуда был вызван шаблон (вверх по стеку).

## Дефолтные шаблоны

    <xsl:template match="/ | *" mode="MODE">
        <xsl:apply-templates mode="MODE"/>
    </xsl:template>

    <xsl:template match="@* | text()">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="comment() | processing-instruction() | namespace::*"/>

## Literate result elements

Можно вывести любой html-код. Но. Содержимое шаблона должно быть
валидным xml-фрагментом. В частности, шаблон не может вывести только, скажем,
открывающий тег, или неправильно вложенные теги. Т.е. это не любой html-код,
а любой фрагмент html-дерева.

### Вычисляемые атрибуты

    <xsl:template match="page">
        <html>
        <body class="page page_{@name}">
        ...

Синтаксис внутри атрибута: {XPATH} --- будет заменено на строку,
полученную в результате вычисления этого XPATH'а (в текущем контексте,
если xpath не абсолютный).

## XSL-конструкции, которые создают разметку или текст

### xsl:value-of

Выводит строку --- результат вычисления xpath'а:

    <xsl:value-of select="XPATH"/>

### xsl:text

Выводит заданную строку текста:

    <xsl:text>Тут какой-то текст</xsl:text>

Нужно, главным образом, для того, чтобы не выводить лишних пробелов.

### xsl:element

Создает заданный элемент:

    <xsl:element name="strong">
        ...содержимое элемента...
    </xsl:element>

В данном случае в точности тоже самое, что и:

    <strong>
        ...содержимое элемента...
    </strong>

Осмысленный способ применения с динамически заданным именем элемента:

    <xsl:element name="{/some/xpath/element/name}">
        ...содержимое элемента...
    </xsl:element>

### xsl:attribute

Создает атрибут:

    <div>
        <xsl:attribute name="class">my-class</xsl:attribute>
        ...
    </div>

    <div>
        <xsl:attribute name="{xpath}">...</xsl:attribute>
    </div>

Важный момент: атрибуты должны быть первыми потомками элемента. Вот так направильно:

    <div>
        <b>Текст</b>
        <xsl:attribute name="class">my-div-class</xsl:attribute>
    </div>

### xsl:copy

Копирует текущую ноду:

    <xsl:template match="*[@class = 'before']">
        <xsl:copy>
            <xsl:attribute name="class">after</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

### xsl:copy-of

Копирует заданную ноду со всем ее содержимым. Например, копируем все атрибуты ноды:

    <xsl:template match="div">
        <p>
            <xsl:copy-of select="@*">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

## Управляющие xslt-конструкции

### xsl:if

Выполнение блока, если выполнено условие:

    <xsl:template match="page">
        <div class="page">
            <xsl:if test="@name = 'index'">
                <xsl:attribute name="class">page page_index</xsl:attribute>
            </xsl:if>
            ...
        </div>
    </xsl:template>

В атрибуте `test` содержится xpath, который приводится к типу boolen.
У `xsl:if` отсутствует блок `else`, характерный для всех языков программирования.
Вместо него нужно использовать конструкцию `xsl:choose`.

### xsl:choose

    <xsl:template match="page">
        <div>
            <xsl:choose>
                <xsl:when test="@name = 'index'">
                    <xsl:attribute name="class">page page_index</xsl:attribute>
                </xsl:when>
                <xsl:when test="@name = 'about'">
                    <xsl:attribute name="class">page page_about</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">page</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            ...
        </div>
    </xsl:template>

### xsl:for-each

Цикл по нодесету, соответствующему заданному xpath'у:

    <xsl:template match="items">
        <xsl:for-each select="item">
            ...сделать что-нибудь с каждым item'ом...
        </xsl:for-each>
    </xsl:template>

Содержимое тега `xsl:for-each` представляет собой шаблон, применяющийся для каждой ноды,
соответствующей xpath'у в атрибуте `select`. Т.е. мы проходим по всем нодам xpath'а,
меняем контекст на соответствующую ноду и применяем шаблон к этим нодам.

Аналогичный результат, но без `xsl:for-each`:

    <xsl:template match="items">
        <xsl:apply-templates select="item"/>
    </xsl:template>

    <xsl:template match="items/item">
        ...сделать что-нибудь с каждым item'ом...
    </xsl:template>

## XSLT-конструкции "меняющие контекст"

### xsl:apply-templates

    <xsl:apply-templates select="XPATH"/>

    Применяет дальше шаблоны подходящие к результату xpath записанного в select.

### xsl:call-template

    <xsl:call-template name="NAME"/>

    Вызывает именованный шаблон, важно, что контекст при этом не меняется, а содержимое вызванного шаблона работает в текущем.

### xsl:apply-imports

    <xsl:apply-imports/>

    Вставляет результат работы тех шаблонов, которые соответствуют текущему элементу и находятся в файлах, подключённых через `xsl:import`.

## Простейшие паттерны

### Identity transform

Шаблон, копирующий все исходное дерево в результирующее дерево:

    <xsl:template match="*|@*|text()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>

### "Проксирующий" запрос

Это identity transform плюс дополнительные шаблоны.
В данном примере заменяем `b` на `strong`, а все остальное копируем как есть:

    <xsl:template match="*|@*|text()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="b">
        <strong>
            <xsl:apply-templates select="*|@*|text()"/>
        </strong>
    </xsl:template>

### Null transform

Обходим все дерево, но ничего не выводим:

    <xsl:template match="*|@*">
        <xsl:apply-templates select="*|@*|text()"/>
    </xsl:template>

    <xsl:template match="text()"/>

### "Фильтрующий шаблон"

Это null transform плюс дополнительные шаблоны. Выводим все ссылки из `<a href="...">`:

    <xsl:template match="*|@*">
        <xsl:apply-templates select="*|@*|text()"/>
    </xsl:template>

    <xsl:template match="text()"/>

    <xsl:template match="a[@href]">
        <xsl:value-of select="@href"/>
    </xsl:template>


