<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<xsl:output method="text" indent="no"/>

<!-- // markdown

### Задача 05

Выбрать для каждого контакта его рабочий телефон, если нет рабочего, то мобильный,
если нет никакого телефона, то email.

-->

<!-- ############################################################################################################## -->

<xsl:template match="/">
    <xsl:apply-templates select="/contacts/contact/phone[@type = 'work' or (@type = 'mobile' and not(../phone[@type = 'work']))] | /contacts/contact/email[not(../phone)]"/>
</xsl:template>

<xsl:template match="*">
    name=<xsl:value-of select="ancestor::contact/name"/>, contact=<xsl:value-of select="."/><xsl:text>
</xsl:text>
</xsl:template>

<!-- ############################################################################################################## -->

</xsl:stylesheet>

