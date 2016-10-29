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
 - Creates the EL variable detail page, listing the known information for a given tag in a tag library.
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
	<xsl:param name="elVariableName" />

	<xsl:template match="/">
		<html lang="en">
			<xsl:call-template name="head">
				<xsl:with-param name="pageTitle" select="$elVariableName" />
				<xsl:with-param name="cssLocation" select="/javaee:vdldoc/javaee:config/@subfolder-css-location" />
			</xsl:call-template>
			<body>
				<xsl:call-template name="top-content">
					<xsl:with-param name="pageType" select="'EL Variable'" />
				</xsl:call-template>
				<div>
					<xsl:call-template name="sidebar-content">
						<xsl:with-param name="namespace" select="$id" />
						<xsl:with-param name="pageType" select="'EL Variable'" />
					</xsl:call-template>

					<div id="main_content" class="mainContent">
						<xsl:apply-templates select="/javaee:vdldoc/javaee:facelet-taglib[@id=$id]/javaee:taglib-extension/vdldoc:el-variable/vdldoc:el-variable-name[text()=$elVariableName]/parent::vdldoc:el-variable" />
					</div>

				</div>
				<xsl:call-template name="bottom-content">
					<xsl:with-param name="pageType" select="'EL Variable'" />
				</xsl:call-template>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/javaee:vdldoc/javaee:facelet-taglib/javaee:taglib-extension/vdldoc:el-variable">

		<div class="header">
			<h1 title="Library" class="title">
				<xsl:value-of select="$id" />
			</h1>
			<h2 class="title">
				EL Variable
				<xsl:choose>
					<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
					<xsl:when test="vdldoc:deprecated or vdldoc:deprecation/vdldoc:deprecated = 'true'">
						<del>
							<xsl:value-of select="vdldoc:el-variable-name" />
						</del>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="vdldoc:el-variable-name" />
					</xsl:otherwise>
				</xsl:choose>
			</h2>
		</div>

		<div class="contentContainer">

			<!-- EL Variable Information -->
			<div class="description">
				<ul class="blockList">
					<li class="blockList">
						<dl>
							<dt>Description:</dt>
							<dd>
								<div class="block">
									<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
									<xsl:if test="vdldoc:deprecated or vdldoc:deprecation/vdldoc:deprecated = 'true'">
										<b>Deprecated. </b>
										<xsl:choose>
											<xsl:when test="vdldoc:deprecated">
												<xsl:value-of select="vdldoc:deprecated" />
											</xsl:when>
											<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
											<xsl:when test="vdldoc:deprecation/vdldoc:deprecated = 'true'">
												<xsl:value-of select="vdldoc:deprecation/vdldoc:description" />
											</xsl:when>
										</xsl:choose>
										<xsl:text>&#160;</xsl:text>
									</xsl:if>
									<xsl:choose>
										<xsl:when test="normalize-space(vdldoc:description)">
											<xsl:value-of select="vdldoc:description" disable-output-escaping="yes" />
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

			<div class="type">
				<ul class="blockList">
					<li class="blockList">
						<dl>
							<dt>Type:</dt>
							<dd>
								<xsl:choose>
									<xsl:when test="normalize-space(vdldoc:type)">
										<xsl:value-of select="vdldoc:type" disable-output-escaping="yes" />
									</xsl:when>
									<xsl:otherwise>
										<i>java.lang.Object</i>
									</xsl:otherwise>
								</xsl:choose>
							</dd>
						</dl>
					</li>
				</ul>
			</div>

			<xsl:if test="normalize-space(vdldoc:since)">
				<div class="since">
					<ul class="blockList">
						<li class="blockList">
							<dl>
								<dt>Since:</dt>
								<dd>
									<xsl:value-of select="vdldoc:since" disable-output-escaping="yes" />
								</dd>
							</dl>
						</li>
					</ul>
				</div>
			</xsl:if>

			<xsl:if test="normalize-space(vdldoc:example-url)">
				<div class="example-url">
					<ul class="blockList">
						<li class="blockList">
							<dl>
								<dt>Example usage of this component can be found at:</dt>
								<br />
								<dd>
									<a href="{vdldoc:example-url}" target="_blank">
										<xsl:value-of select="vdldoc:example-url" disable-output-escaping="yes" />
									</a>
								</dd>
							</dl>
						</li>
					</ul>
				</div>						
			</xsl:if>
		</div>

	</xsl:template>

</xsl:stylesheet>