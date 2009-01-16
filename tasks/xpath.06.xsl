<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<xsl:output method="text" indent="no"/>

<!-- // markdown

### Задача 06

Вычислить максимальное и минимальное значение в коллекции `item`'ов.

-->

<!-- ############################################################################################################## -->

<xsl:template match="/">
    <xsl:value-of select="//item[not(. &lt; //item)]"/><xsl:text>
</xsl:text>
    <xsl:value-of select="//item[not(. &gt; //item)]"/><xsl:text>
</xsl:text>
</xsl:template>

<!-- ############################################################################################################## -->

</xsl:stylesheet>

