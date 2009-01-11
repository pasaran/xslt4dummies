## XML

### Представление в виде текста и дерева

Мы пишем xml руками в виде текста, храним его в текстовых файлах,
пересылаем эти файлы по сети.

    <?xml version="1.0" encoding="utf-8"?>
    <?xsl-stylesheet type="text/xsl" href="index.xsl"?>

    <!-- main page -->
    <page name="index" xmlns:lego="https://lego.yandex-team.ru">
        <lego:l-head>
            <lego:b-head-logo>
                <lego:name>Видео</lego:name>
            </lego:b-head-logo>
            <lego:b-head-tabs lego:theme="gray">
                ...
            </lego:b-head-tabs>
            ...
        </lego:l-head>
        ...
    </page>

Но xml-процессоры, получая на вход текст, парсят его и используют
внутреннее представление в виде **дерева**.

Дерево --- это набор **нод**,
связанных друг с другом отношением parent--child.
Ноды --- 
У каждой ноды есть ровно один родитель и список (возможно пустой) детей.

### Типы нод

* document
* element
* attribute
* text
* comment
* processing instruction
* namespace

### Неймспейсы


