<?xml version="1.0" encoding="UTF-8" ?>

<!--
 - Copyright (c) 2012, OmniFaces
 - All rights reserved.
 -
 - Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
 - following conditions are met:
 -
 -     * Redistributions of source code must retain the above copyright notice, this list of conditions and the
 -       following disclaimer.
 -     * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
 -       following disclaimer in the documentation and/or other materials provided with the distribution.
 -     * Neither the name of OmniFaces nor the names of its contributors may be used to endorse or promote products
 -       derived from this software without specific prior written permission.
 -
 - THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 - INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 - DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 - OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 - DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 - STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 - EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<!--
 - Creates the function detail page, listing the known information for a given function in a tag library.
 -
 - @author Bauke Scholtz
-->
<xsl:stylesheet
	xmlns:javaee="http://xmlns.jcp.org/xml/ns/javaee"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="2.0"
>
	<xsl:output method="html" indent="yes"
		doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
		doctype-system="http://www.w3.org/TR/html4/loose.dtd" />

	<xsl:include href="templates.xsl" />

	<xsl:param name="id" />
	<xsl:param name="functionName" />

	<xsl:template match="/">
		<html lang="en">
			<xsl:call-template name="head">
				<xsl:with-param name="pageTitle" select="$functionName" />
				<xsl:with-param name="cssLocation" select="/javaee:vdldoc/javaee:config/@subfolder-css-location" />
			</xsl:call-template>
			<body>
				<xsl:call-template name="top-content">
					<xsl:with-param name="pageType" select="'Function'" />
				</xsl:call-template>
				<div>
					<xsl:call-template name="sidebar-content">
						<xsl:with-param name="namespace" select="$id" />
						<xsl:with-param name="pageType" select="'Function'" />
					</xsl:call-template>

					<div id="main_content" class="mainContent">
						<xsl:apply-templates select="/javaee:vdldoc/javaee:facelet-taglib[@id=$id]/javaee:function/javaee:function-name[text()=$functionName]/parent::javaee:function" />
					</div>

				</div>
				<xsl:call-template name="bottom-content">
					<xsl:with-param name="pageType" select="'Function'" />
				</xsl:call-template>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/javaee:vdldoc/javaee:facelet-taglib/javaee:function">

		<div class="header">
			<h1 title="Library" class="title">
				<xsl:value-of select="$id" />
			</h1>
			<h2 class="title">
				Function <xsl:value-of select="javaee:function-name" />
			</h2>
		</div>

		<div class="contentContainer">
			<div class="description">
				<ul class="blockList">
					<li class="blockList">
						<dl>
							<dt>Signature:</dt>
							<dd>
								<code>
									<xsl:value-of select='substring-before(normalize-space(javaee:function-signature)," ")' />
									<b>&#160;<xsl:value-of select="javaee:function-name" /></b>(<xsl:value-of select='substring-after(normalize-space(javaee:function-signature),"(")' />
								</code>
							</dd>
						</dl>

						<dl>
							<dt>Description:</dt>
							<dd>
								<div class="block">
									<xsl:choose>
										<xsl:when test="normalize-space(javaee:description)">
											<xsl:value-of select="javaee:description" disable-output-escaping="yes" />
										</xsl:when>
										<xsl:otherwise>
											<i>No Description</i>
										</xsl:otherwise>
									</xsl:choose>
								</div>
							</dd>
						</dl>
					</li>
				</ul>
			</div>

			<div class="detail">
				<table class="overviewSummary" border="0" cellpadding="3" cellspacing="0"
					summary="Function Summary table, listing function information">
					<caption>
						<span>Function Information</span>
						<span class="tabEnd">&#160;</span>
					</caption>
					<thead>
						<tr>
							<th class="colFirst" scope="col">Info</th>
							<th class="colLast" scope="col">Value</th>
						</tr>
					</thead>
					<tbody>
						<tr class="rowColor">
							<td class="colFirst">Function Class</td>
							<td class="colLast">
								<xsl:choose>
									<xsl:when test="normalize-space(javaee:function-class)">
										<code><xsl:value-of select="javaee:function-class" /></code>
									</xsl:when>
									<xsl:otherwise>
										<i>None</i>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr class="altColor">
							<td class="colFirst">Function Signature</td>
							<td class="colLast">
								<xsl:choose>
									<xsl:when test="normalize-space(javaee:function-signature)">
										<code><xsl:value-of select="javaee:function-signature" /></code>
									</xsl:when>
									<xsl:otherwise>
										<i>None</i>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr class="rowColor">
							<td class="colFirst">Display Name</td>
							<td class="colLast">
								<xsl:choose>
									<xsl:when test="normalize-space(javaee:display-name)">
										<xsl:value-of select="javaee:display-name" />
									</xsl:when>
									<xsl:otherwise>
										<i>None</i>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

	</xsl:template>

</xsl:stylesheet>