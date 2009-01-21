## Задачи по XSLT

Есть xml:

    <items>
        <item>First</item>
        <item>Second</item>
        <item current="">Third</item>
        <item>Last</item>
    </items>

И есть xsl:

    <xsl:template match="items">
        <xsl:apply-templates select="item"/>
        <!--
            для каждого item'а вызовется один из нижеследующих шаблонов,
            спрашивается какой именно
        -->
    </xsl:template>

    <xsl:template match="/item">
        <xsl:text>1. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="item[1]">
        <xsl:text>2. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*/*[..//*[@current]]">
        <xsl:text>3. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*[@*]">
        <xsl:text>4. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:text>5. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="items/item">
        <xsl:text>6. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="item/@current">
        <xsl:text>7. </xsl:text>
        <xsl:apply-templates select="." mode="mode"/>
    </xsl:template>

    <xsl:template match="item[@current]">
        <xsl:text>8. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="item" mode="mode">
        <xsl:text>9. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="@item">
        <xsl:text>10. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="item[following-sibling::item[2]]">
        <xsl:text>11. </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

Спрашивается, что будет выведено при наложении одного на другое.

---

Есть xml:

    <html>
    <body>
        <div class="head">Заголовок</div>
        <div class="block">
            <b class="my-class"><i>Я</i> написал такой код:</b>
            <div class="code">
                <b>html</b> это <i style="color:red">пыщ</i>-пыщ.
            </div>
        </div>
    </body>
    </html>

Задания:

*   Заменить все `<b>` на `<strong>`, `<i>` на `<em>`.
*   Плюс к предыдущему заменить `<div class="code">` на `<pre>`, `<div class="head">` на `<h1>`.
*   Плюс к предыдущему удалить все атрибуты `class` и `style`.
*   Плюс к предыдущему разметку внутри `<div class="code">` сохранить в исходном виде.
*   Удалить всю разметку (включая атрибуты `class` и `style`), оставив только теги `b` и `i`.

---

Есть xml вида:

    <page name="catalog">
        <menu>
            <item name="index"/>
            <item name="catalog"/>
            <item name="about"/>
            <item name="help"/>
        </menu>
        <links>
            <link name="about" href="/about/">О проекте</link>
            <link name="catalog" href="/catalog/">Каталог</link>
            <link name="help" href="/help/">Помощь</link>
            <link name="index" href="/">Главная</link>
            <link name="setup" href="/settings/">Настройки</link>
        </links>
        <content>
            <list>
                <item><p>Тут какой-то <b>текст</b></p></item>
                <item><p>И еще <b>текста</b> куча</p></item>
                <item><p>И еще что-то написано</p></item>
            </list>
        </content>
    </page>

В атрибуте `name` у элемента `page` указана "текущая" страница.

Задания:

*   Нарисовать меню в виде:

        <ul class="b-menu">
            <li class="item"><a href="/">Главная</a></li>
            <li class="item current"><strong>Каталог</li>
            <li class="item"><a href="/about/">О проекте</a></li>
            <li class="item"><a href="/help/">Помощь</a></li>
        </ul>

*   Плюс к предыдущему вывести после меню "контент" в виде:

        <div class="b-page">
            <div class="b-section">
                <p>Тут какой-то <b>текст</b></p>
            </div>
            ...
        </div>

*   Плюс к предыдущему вывести после контента "навигацию" в виде:

        <div class="b-navigation">
            <a href="/">Предыдущая</a>
            <a href="/about/">Следующая</a>
        </div>

Если предыдущей или следующей страницы нет, то соответствующая ссылка не выводится.

---

Написать именованный шаблон, принимающий три параметра --- натуральных числа.
Пример вызова:

    <xsl:call-template name="pages">
        <xsl:with-param name="start" select="4"/>
        <xsl:with-param name="end" select="10"/>
        <xsl:with-param name="current" select="7"/>
    </xsl:call-template>

На выходе должен получиться "пейджер":

    <div>
        <a href="/?p=4">4</a>
        <a href="/?p=5">5</a>
        <a href="/?p=6">6</a>
        <b>7</b>
        <a href="/?p=8">8</a>
        ...
    </div>

---
