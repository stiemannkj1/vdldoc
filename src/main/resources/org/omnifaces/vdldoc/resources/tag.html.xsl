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
 - Creates the tag detail page, listing the known information for a given tag in a tag library.
 -
 - @author Bauke Scholtz
-->
<xsl:stylesheet
	xmlns:javaee="http://xmlns.jcp.org/xml/ns/javaee"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:vdldoc="http://vdldoc.omnifaces.org"
	version="2.0"
>
	<xsl:output method="html" indent="yes"
		doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
		doctype-system="http://www.w3.org/TR/html4/loose.dtd" />

	<xsl:include href="templates.xsl" />

	<xsl:param name="id" />
	<xsl:param name="tagName" />

	<xsl:template match="/">
		<html lang="en">
			<xsl:call-template name="head">
				<xsl:with-param name="pageTitle" select="$tagName" />
				<xsl:with-param name="cssLocation" select="/javaee:vdldoc/javaee:config/@subfolder-css-location" />
			</xsl:call-template>
			<body>
				<xsl:call-template name="top-content">
					<xsl:with-param name="pageType" select="'Tag'" />
				</xsl:call-template>
				<div>
					<xsl:call-template name="sidebar-content">
						<xsl:with-param name="namespace" select="$id" />
						<xsl:with-param name="pageType" select="'Tag'" />
					</xsl:call-template>

					<div id="main_content" class="mainContent">
						<xsl:apply-templates select="/javaee:vdldoc/javaee:facelet-taglib[@id=$id]/javaee:tag/javaee:tag-name[text()=$tagName]/parent::javaee:tag" />
					</div>

				</div>
				<xsl:call-template name="bottom-content">
					<xsl:with-param name="pageType" select="'Tag'" />
				</xsl:call-template>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/javaee:vdldoc/javaee:facelet-taglib/javaee:tag">

		<div class="header">
			<h1 title="Library" class="title">
				<xsl:value-of select="$id" />
			</h1>
			<h2 class="title">
				Tag
				<xsl:choose>
					<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
					<xsl:when test="javaee:tag-extension/vdldoc:deprecated or javaee:tag-extension/vdldoc:deprecation/vdldoc:deprecated = 'true'">
						<del>
							<xsl:value-of select="javaee:tag-name" />
						</del>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="javaee:tag-name" />
					</xsl:otherwise>
				</xsl:choose>
			</h2>
		</div>

		<div class="contentContainer">

			<!-- Tag Information -->
			<div class="description">
				<ul class="blockList">
					<li class="blockList">
						<dl>
							<dt>Description:</dt>
							<dd>
								<div class="block">
									<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
									<xsl:if test="javaee:tag-extension/vdldoc:deprecated or javaee:tag-extension/vdldoc:deprecation/vdldoc:deprecated = 'true'">
										<b>Deprecated. </b>
										<xsl:choose>
											<xsl:when test="javaee:tag-extension/vdldoc:deprecated">
												<xsl:value-of select="javaee:tag-extension/vdldoc:deprecated" />
											</xsl:when>
											<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
											<xsl:when test="javaee:tag-extension/vdldoc:deprecation/vdldoc:deprecated = 'true'">
												<xsl:value-of select="javaee:tag-extension/vdldoc:deprecation/vdldoc:description" />
											</xsl:when>
										</xsl:choose>
										<xsl:text>&#160;</xsl:text>
									</xsl:if>
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

			<xsl:if test="normalize-space(javaee:tag-extension/vdldoc:since)">
				<div class="since">
					<ul class="blockList">
						<li class="blockList">
							<dl>
								<dt>Since:</dt>
								<dd>
									<xsl:value-of select="javaee:tag-extension/vdldoc:since" disable-output-escaping="yes" />
								</dd>
							</dl>
						</li>
					</ul>
				</div>
			</xsl:if>

			<xsl:if test="normalize-space(javaee:tag-extension/vdldoc:example-url)">
				<div class="example-url">
					<ul class="blockList">
						<li class="blockList">
							<dl>
								<dt>Example usage of this component can be found at:</dt>
								<br />
								<dd>
									<a href="{javaee:tag-extension/vdldoc:example-url}" target="_blank">
										<xsl:value-of select="javaee:tag-extension/vdldoc:example-url" disable-output-escaping="yes" />
									</a>
								</dd>
							</dl>
						</li>
					</ul>
				</div>
			</xsl:if>

			<!-- Component Information -->
			<xsl:if test="normalize-space(javaee:component)">
				<xsl:apply-templates select="javaee:component" />
			</xsl:if>

			<!-- Behavior Information -->
			<xsl:if test="normalize-space(javaee:behavior)">
				<xsl:apply-templates select="javaee:behavior" />
			</xsl:if>

			<!-- Converter Information -->
			<xsl:if test="normalize-space(javaee:converter)">
				<xsl:apply-templates select="javaee:converter" />
			</xsl:if>

			<!-- Validator Information -->
			<xsl:if test="normalize-space(javaee:validator)">
				<xsl:apply-templates select="javaee:validator" />
			</xsl:if>

			<!-- Attribute Information -->
			<div class="summary">
				<table class="overviewSummary" border="0" cellpadding="3" cellspacing="0" summary="Attribute summary table, listing attribute information">
					<caption>
						<span>Attributes</span>
						<span class="tabEnd">&#160;</span>
					</caption>
					<thead>
						<tr>
							<th class="colFirst">Name</th>
							<th class="colOne">Required</th>
							<th class="colOne">Type</th>
							<th class="colLast">Description</th>
						</tr>
					</thead>
					<tbody>
						<xsl:choose>
							<xsl:when test="count(javaee:attribute) > 0">
								<xsl:apply-templates select="javaee:attribute" />
							</xsl:when>
							<xsl:otherwise>
								<td class="colOne" colspan="4">
									<i>No Attributes Defined.</i>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</tbody>
				</table>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="javaee:component">
		<xsl:call-template name="summary">
			<xsl:with-param name="caption" select="'Component Information'" />
			<xsl:with-param name="summary" select="'Component summary table, listing component information'" />
			<xsl:with-param name="id-name" select="'Component Type'" />
			<xsl:with-param name="id-value" select="javaee:component-type" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="javaee:behavior">
		<xsl:call-template name="summary">
			<xsl:with-param name="caption" select="'Behavior Information'" />
			<xsl:with-param name="summary" select="'Behavior summary table, listing behavior information'" />
			<xsl:with-param name="id-name" select="'Behavior ID'" />
			<xsl:with-param name="id-value" select="javaee:behavior-id" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="javaee:converter">
		<xsl:call-template name="summary">
			<xsl:with-param name="caption" select="'Converter Information'" />
			<xsl:with-param name="summary" select="'Converter summary table, listing converter information'" />
			<xsl:with-param name="id-name" select="'Converter ID'" />
			<xsl:with-param name="id-value" select="javaee:converter-id" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="javaee:validator">
		<xsl:call-template name="summary">
			<xsl:with-param name="caption" select="'Validator Information'" />
			<xsl:with-param name="summary" select="'Validator summary table, listing validator information'" />
			<xsl:with-param name="id-name" select="'Validator ID'" />
			<xsl:with-param name="id-value" select="javaee:validator-id" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="summary">
		<xsl:param name="caption" />
		<xsl:param name="summary" />
		<xsl:param name="id-name" />
		<xsl:param name="id-value" />

		<div class="summary">
			<table class="overviewSummary" border="0" cellpadding="3" cellspacing="0">
				<xsl:attribute name="summary">
					<xsl:value-of select="$summary" />
				</xsl:attribute>

				<caption>
					<span><xsl:value-of select="$caption" /></span>
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
						<td class="colFirst"><xsl:value-of select="$id-name" /></td>
						<td class="colLast">
							<xsl:choose>
								<xsl:when test="normalize-space($id-value)">
									<code><xsl:value-of select="$id-value" /></code>
								</xsl:when>
								<xsl:otherwise>
									<i>None</i>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr class="altColor">
						<td class="colFirst">Handler Class</td>
						<td class="colLast">
							<xsl:choose>
								<xsl:when test="normalize-space(javaee:handler-class)">
									<code><xsl:value-of select="javaee:handler-class" /></code>
								</xsl:when>
								<xsl:otherwise>
									<i>None</i>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<xsl:if test="normalize-space(javaee:component-type)">
						<tr class="rowColor">
							<td class="colFirst">Renderer Type</td>
							<td class="colLast">
								<xsl:choose>
									<xsl:when test="normalize-space(javaee:renderer-type)">
										<code><xsl:value-of select="javaee:renderer-type" /></code>
									</xsl:when>
									<xsl:otherwise>
										<i>None</i>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="normalize-space(javaee:component-type)">altColor</xsl:when>
								<xsl:otherwise>rowColor</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<td class="colFirst">Description</td>
						<td class="colLast">
							<xsl:choose>
								<xsl:when test="normalize-space(javaee:description)">
									<xsl:value-of select="javaee:description" disable-output-escaping="yes" />
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
	</xsl:template>

	<xsl:template match="javaee:attribute">
		<tr>
			<xsl:attribute name="id">
				<xsl:value-of select="javaee:name" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 0">altColor</xsl:when>
					<xsl:otherwise>rowColor</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<td class="colFirst">
				<xsl:choose>
					<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
					<xsl:when test="../javaee:tag-extension/vdldoc:deprecated or ../javaee:tag-extension/vdldoc:deprecation/vdldoc:deprecated = 'true'">
						<a>
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text><xsl:value-of select="javaee:name" />
							</xsl:attribute>
							<del>
								<code>
									<xsl:apply-templates select="javaee:name" />
								</code>
							</del>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<a>
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text><xsl:value-of select="javaee:name" />
							</xsl:attribute>
							<code>
								<xsl:apply-templates select="javaee:name" />
							</code>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="colOne">
				<code>
					<xsl:choose>
						<xsl:when test="normalize-space(javaee:required)">
							<xsl:value-of select="javaee:required" />
						</xsl:when>
						<xsl:otherwise>
							false
						</xsl:otherwise>
					</xsl:choose>
				</code>
			</td>
			<td class="colOne">
				<xsl:choose>
					<xsl:when test="normalize-space(javaee:type)">
						<code>javax.el.ValueExpression</code>
						<br />(<i>must evaluate to </i><code><xsl:value-of select="javaee:type" /></code>)
					</xsl:when>
					<xsl:when test="normalize-space(javaee:method-signature)">
						<code>javax.el.MethodExpression</code>
						<br />(<i>signature must match </i><code><xsl:value-of select="javaee:method-signature" /></code>)
					</xsl:when>
					<xsl:otherwise>
						<code>java.lang.String</code>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="colLast">
				<xsl:choose>
					<xsl:when test="normalize-space(javaee:description)">
						<xsl:value-of select="javaee:description" disable-output-escaping="yes" />
					</xsl:when>
					<xsl:otherwise>
						<i>No Description</i>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>
