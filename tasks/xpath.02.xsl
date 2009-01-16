<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<xsl:output method="text" indent="no"/>

<!-- // markdown

### Задача 02

Выбрать все ноды, у которых есть "старший брат" и "младший брат".

-->

<!-- ############################################################################################################## -->

<xsl:template match="/">
    <xsl:apply-templates select="//*[preceding-sibling::* and following-sibling::*]"/>
</xsl:template>

<xsl:template match="*">
    name()=<xsl:value-of select="name()"/>, @id=<xsl:value-of select="@id"/><xsl:text>
</xsl:text>
</xsl:template>

<!-- ############################################################################################################## -->

</xsl:stylesheet>

