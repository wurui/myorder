<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:oxm="https://www.openxsl.com">
    <xsl:template match="/root" name="wurui.myorder">
        <!-- className 'J_OXMod' required  -->
        <div class="J_OXMod oxmod-myorder" ox-mod="myorder">
            
            <xsl:variable name="dsid" select="substring(data/orders/attribute::ADAPTERID,2)"/>

            <xsl:if test="count(data/orders/i) = 0">
                <div class="nodata">暂无订单</div>
            </xsl:if>
            <xsl:if test="count(data/orders/i) &gt; 0">

                <table class="myorder" cellpadding="0" cellspacing="0">
                    <thead>
                        <tr>
                            <th width="50%">商品信息</th>
                            <th>数量</th>
                            <th>金额</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="data/orders/i">
                            <xsl:variable name="status-desc">
                                <xsl:choose>
                                    <xsl:when test="actions/refund/success">退款成功</xsl:when>
                                    <xsl:when test="actions/refund/complete/fmt_cn">退款完成</xsl:when>
                                    <xsl:when test="actions/refund/accept/fmt_cn">退款处理中</xsl:when>
                                    <xsl:when test="actions/refund/apply/fmt_cn">退款中</xsl:when>
                                    <xsl:when test="actions/close/fmt_cn">订单已关闭</xsl:when>
                                    <xsl:when test="actions/complete/fmt_cn">订单已完成</xsl:when>
                                    <xsl:when test="actions/deliver/time/fmt_cn">已发货</xsl:when>
                                    <xsl:when test="actions/accept/fmt_cn">商家已接单</xsl:when>
                                    <xsl:when test="actions/pay/time/fmt_cn">已付款</xsl:when>
                                    <xsl:when test="time/fmt_cn">待支付</xsl:when>
                                    <xsl:otherwise></xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <tr>
                                <td class="tradeno" colspan="2">
                                    <xsl:value-of select="time/fmt_cn"/>
                                </td>                           
                            </tr>
                            <tr>
                                <td class="title"><a href="{LINK/detail}"><xsl:value-of select="title"/></a></td>
                                <td class="buyer">
                                    &#215;<xsl:value-of select="totalcount"/>
                                    <br/>
                                    <xsl:value-of select="seller"/>
                                </td>
                                <td class="last">
                                    <em class="price">&#165;<xsl:value-of select="totalfee"/></em>
                                    <br/>
                                    <span class="status-desc">
                                        <xsl:choose>
                                            <xsl:when test="$status-desc = '待支付'"><a href="http://pay.openxsl.com/p/pay/custom?dsname=orders&amp;dsid={$dsid}&amp;oid={_id}">付款</a></xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="$status-desc"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </span>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </xsl:if>
        </div>
    </xsl:template>
</xsl:stylesheet>
