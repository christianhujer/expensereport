<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <xsl:output
        method="text"
    />

    <xsl:template match="expenses">
        <xsl:text>Expenses:&#xa;</xsl:text>
        <xsl:for-each select="expense">
            <xsl:choose>
                <xsl:when test="@type = 'DINNER'">
                    <xsl:text>Dinner</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'BREAKFAST'">
                    <xsl:text>Breakfast</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'CAR_RENTAL'">
                    <xsl:text>Car Rental</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:text>&#x9;</xsl:text>
            <xsl:value-of select="@amount"/>
            <xsl:text>&#x9;</xsl:text>
            <xsl:choose>
                <xsl:when test="@type = 'DINNER' and @amount > 5000 or @type = 'BREAKFAST' and @amount > 1000">
                    <xsl:text>X</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
        <xsl:text>Meal Expenses: </xsl:text>
        <xsl:value-of select="sum(expense[@type = 'DINNER' or @type = 'BREAKFAST']/@amount)"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>Total: </xsl:text>
        <xsl:value-of select="sum(expense/@amount)"/>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

</xsl:transform>
