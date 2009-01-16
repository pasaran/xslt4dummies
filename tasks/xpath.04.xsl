<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<xsl:output method="text" indent="no"/>

<!-- // markdown

### Задача 04

Выбрать все ноды, у которых есть предок и потомок с одинаковым классом.

-->

<!-- ############################################################################################################## -->

<xsl:template match="/">
    <xsl:apply-templates select="//*[.//*/@class = ancestor::*/@class]"/>
</xsl:template>

<xsl:template match="*">
    name()=<xsl:value-of select="name()"/>, @id=<xsl:value-of select="@id"/><xsl:text>
</xsl:text>
</xsl:template>

<!-- ############################################################################################################## -->

</xsl:stylesheet>

