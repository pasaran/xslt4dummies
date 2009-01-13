Есть вот такой xml:

    <addressBook>
        <address>
            <firstName>John</firstName>
            <surname>Smith</surname>
            <email>smithj@world.org</email>
            <tel type="work">234-123-222</tel>
        </address>
        <address>
            <firstName>Alice</firstName>
            <surname>Brown</surname>
            <email>Alice.Brown@europe.com</email>
            <tel type="home">22-33-444</tel>
            <tel type="work">11-43-222</tel>
        </address>
        <address>
            <firstName>George</firstName>
            <surname>White</surname>
            <email>gw@rock.com</email>
        </address>
    </addressBook>

1. Выбрать нодесет, содержащий телефоны --- по одному на каждого человека (если есть хотя бы один).
   При этом, если у человека есть домашний телефон, то выбрать его, а если нет, то рабочий.

2. Выбрать все ноды, "глубина залегания" которых является четным числом (для корневого элемента это 1).

3. Выбрать все ноды, у которых есть "старший брат" и "младший брат".

4. Выбрать все ноды, у "деда" которых ровно 5 потомков.

5. Выбрать все ноды, у которых есть предок и потомок с одинаковым именем.

6. Выбрать ноду с максимальным количеством атрибутов.
 
