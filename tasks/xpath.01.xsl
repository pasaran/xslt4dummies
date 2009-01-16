<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<xsl:output method="text" indent="no"/>

<!-- // markdown

### Задача 01

Выбрать все ноды, "глубина залегания" которых является четным числом
(для корневого элемента "глубина" равно 0

-->

<!-- ############################################################################################################## -->

<xsl:template match="/">
    <xsl:apply-templates select="//*[count(ancestor::*) mod 2 = 0]"/>
</xsl:template>

<xsl:template match="*">
    name()=<xsl:value-of select="name()"/>, @id=<xsl:value-of select="@id"/>, глубина=<xsl:value-of select="count(ancestor::*)"/><xsl:text>
</xsl:text>
</xsl:template>

<!-- ############################################################################################################## -->

</xsl:stylesheet>

