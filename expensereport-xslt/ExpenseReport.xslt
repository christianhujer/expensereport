<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <xsl:strip-space elements="expenses expense"/>

    <xsl:output
        method="text"
    />

    <xsl:variable name="expenseTypes" select="document('expenseTypes.xml')/expenseTypes"/>
    <xsl:variable name="meals">
        <xsl:text> </xsl:text>
        <xsl:for-each select="$expenseTypes/expenseType[@isMeal]/@name">
            <xsl:value-of select="."/>
            <xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="expenses">
        <xsl:call-template name="printHeader"/>
        <xsl:call-template name="printDetails"/>
        <xsl:call-template name="printSummary"/>
    </xsl:template>

    <xsl:template name="printHeader">
        <xsl:text>Expenses:&#xa;</xsl:text>
    </xsl:template>

    <xsl:template name="printDetails">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template name="printSummary">
        <xsl:text>Meal Expenses: </xsl:text>
        <xsl:value-of select="sum(expense[contains($meals, concat(' ', @type, ' '))]/@amount)"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>Total Expenses: </xsl:text>
        <xsl:value-of select="sum(expense/@amount)"/>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

    <xsl:template match="expense">
        <xsl:variable name="expenseType" select="$expenseTypes/expenseType[@name=current()/@type]"/>
        <xsl:value-of select="$expenseType"/>
        <xsl:text>&#x9;</xsl:text>
        <xsl:value-of select="@amount"/>
        <xsl:text>&#x9;</xsl:text>
        <xsl:choose>
            <xsl:when test="$expenseType/@limit and @amount > $expenseType/@limit">
                <xsl:text>X</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

</xsl:transform>
