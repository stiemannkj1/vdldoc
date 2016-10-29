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
 - TODO
 -
 - @author Kyle Stiemann
-->
<xsl:stylesheet
	xmlns:javaee="http://xmlns.jcp.org/xml/ns/javaee"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:vdldoc="http://vdldoc.omnifaces.org"
	version="2.0"
>

	<xsl:output method="html" />

	<!-- Example usage of these templates: -->
	<!--
	<xsl:include href="templates.xsl" />

	<xsl:param name="id" />

	<xsl:template match="/">
		<html lang="en">
			<xsl:call-template name="head">
				<xsl:with-param name="pageTitle" select="...YOUR PAGE TITLE HERE..." />
				<xsl:with-param name="cssLocation" select="/javaee:vdldoc/javaee:config/@css-location" />
				OR
				<xsl:with-param name="cssLocation" select="/javaee:vdldoc/javaee:config/@subfolder-css-location" />
			</xsl:call-template>
			<body>
				<xsl:call-template name="top-content">
					<xsl:with-param name="type" select="...YOUR PAGE TYPE HERE..." />
				</xsl:call-template>
				<div>
					<xsl:call-template name="sidebar-content">
						OPTIONAL: <xsl:with-param name="namespace" select="$id" />
						<xsl:with-param name="type" select="...YOUR PAGE TYPE HERE..." />
					</xsl:call-template>

					<div id="main_content" class="mainContent">
						...YOUR CONTENT HERE...
					</div>

				</div>
				<xsl:call-template name="bottom-content">
					<xsl:with-param name="type" select="...YOUR PAGE TITLE HERE..." />
				</xsl:call-template>
			</body>
		</html>
	</xsl:template>
	-->

	<xsl:template name="head">
		<xsl:param name="pageTitle" />
		<xsl:param name="cssLocation" />
		<xsl:variable name="title">
			<xsl:value-of select="$pageTitle" /> (<xsl:value-of select="/javaee:vdldoc/javaee:config/javaee:window-title" />)
		</xsl:variable>
		<head>
			<title>
				<xsl:value-of select="$title" />
			</title>
			<meta name="keywords" content="$title" />
			<link rel="stylesheet" type="text/css" title="Style">
				<xsl:attribute name="href">
					<xsl:value-of select="$cssLocation" />
				</xsl:attribute>
			</link>
			<!-- ========= BEGIN SIDEBAR STYLES ========= -->
			<noscript>
				<style>
					.sidebarNamespaceChildren {
						display:block;
					}

					.toggleSidebar {
						display:none;
					}
				</style>
			</noscript>
			<!-- ========= END SIDEBAR STYLES ========= -->
		</head>
	</xsl:template>

	<xsl:template name="top-content">
		<xsl:param name="pageType" />

		<noscript>
			<div>JavaScript is disabled on your browser.</div>
		</noscript>

		<!-- ========= START OF TOP NAVBAR ======= -->
		<div class="topNav">
			<a name="navbar_top"></a>
			<a href="#skip-navbar_top" title="Skip navigation links"></a>
			<a name="navbar_top_firstrow"></a>
			<xsl:call-template name="nav-list">
				<xsl:with-param name="pageType" select="$pageType" />
			</xsl:call-template>
		</div>
		<!-- ========= END OF TOP NAVBAR ========= -->
	</xsl:template>

	<xsl:template name="nav-list">
		<xsl:param name="pageType" />
		<ul class="navList" title="Navigation">
			<li>
				<xsl:choose>
					<xsl:when test="$pageType = 'Overview'">
						<xsl:attribute name="class">navBarCell1Rev</xsl:attribute>
						Overview
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$pageType != 'All Tags' and $pageType != 'Help'">
								<a href="../overview-summary.html">Overview</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="overview-summary.html">Overview</a>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				<xsl:choose>
					<xsl:when test="$pageType = '' or $pageType = 'All Tags' or $pageType = 'Library' or $pageType = 'Help' or $pageType = 'Overview'">
						<xsl:if test="$pageType = 'Library'">
							<xsl:attribute name="class">navBarCell1Rev</xsl:attribute>
						</xsl:if>
						Library
					</xsl:when>
					<xsl:otherwise>
						<a href="tld-summary.html">Library</a>
					</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				<xsl:choose>
					<xsl:when test="$pageType != '' and $pageType != 'All Tags' and $pageType != 'Help' and $pageType != 'Library' and $pageType != 'Overview'">
						<xsl:attribute name="class">navBarCell1Rev</xsl:attribute>
						<xsl:value-of select="$pageType" />
					</xsl:when>
					<xsl:otherwise>
						Tag
					</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				<xsl:choose>
					<xsl:when test="$pageType = 'Help'">
						<xsl:attribute name="class">navBarCell1Rev</xsl:attribute>
						Help
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$pageType != 'All Tags' and $pageType != 'Overview'">
								<a href="../help-doc.html">Help</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="help-doc.html">Help</a>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</li>
		</ul>
	</xsl:template>

	<xsl:template name="sidebar-content">
		<xsl:param name="namespace">
			default
		</xsl:param>
		<xsl:param name="pageType" />
		<xsl:variable name="pathPrefix">
			<xsl:choose>
				<xsl:when test="$pageType != '' and $pageType != 'All Tags' and $pageType != 'Help' and $pageType != 'Overview'">../</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div class="toggleSidebar subNav">
			<ul class="navList">
				<li>
					<a>
						<xsl:attribute name="onclick">toggleSidebar();</xsl:attribute>
						<b>Toggle Sidebar</b>
					</a>
				</li>
			</ul>
		</div>
		<div id="sidebar" class="indexContainer sidebar">
			<ul>
				<xsl:for-each select="/javaee:vdldoc/javaee:facelet-taglib">
					<xsl:sort select="@id" />
					<li>
						<a>
							<xsl:attribute name="onclick">toggleNamespace('<xsl:value-of select="@id" />');</xsl:attribute>
							<b>Toggle <code><xsl:value-of select="@id" /></code> Namespace</b>
						</a>
						<ul class="sidebarNamespaceChildren">
							<xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
							<xsl:if test="$namespace = @id">
								<xsl:attribute name="style">display: block;</xsl:attribute>
							</xsl:if>
							<xsl:for-each select="javaee:tag|javaee:function|javaee:taglib-extension/vdldoc:el-variable">
								<xsl:sort select="javaee:tag-name" />
								<xsl:sort select="javaee:function-name" />
								<xsl:sort select="vdldoc:el-variable-name" />
								<xsl:if test="name() = 'tag'">
									<li>
										<a>
											<xsl:attribute name="href"><xsl:value-of select="$pathPrefix" /><xsl:value-of select="../@id" />/<xsl:value-of select="javaee:tag-name" />.html</xsl:attribute>
											<xsl:choose>
												<!-- vdldoc:deprecation is deprecated. It has been replaced by vdldoc:deprecated. -->
												<xsl:when test="javaee:tag-extension/vdldoc:deprecated or javaee:tag-extension/vdldoc:deprecation/vdldoc:deprecated = 'true'">
													<del>
														<xsl:value-of select="../@id" />:<xsl:value-of select="javaee:tag-name" />
													</del>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="../@id" />:<xsl:value-of select="javaee:tag-name" />
												</xsl:otherwise>
											</xsl:choose>
										</a>
									</li>
								</xsl:if>
								<xsl:if test="name() = 'function'">
									<li>
										<a>
											<xsl:attribute name="href"><xsl:value-of select="$pathPrefix" /><xsl:value-of select="../@id" />/<xsl:value-of select="javaee:function-name" />.fn.html</xsl:attribute>
											<i><xsl:value-of select="../@id" />:<xsl:value-of select="javaee:function-name" />()</i>
										</a>
									</li>
								</xsl:if>
								<xsl:if test="name() = 'vdldoc:el-variable'">
									<li>
										<a>
											<xsl:attribute name="href"><xsl:value-of select="$pathPrefix" /><xsl:value-of select="../../@id" />/<xsl:value-of select="vdldoc:el-variable-name" />.el.html</xsl:attribute>
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
										</a>
									</li>
								</xsl:if>
							</xsl:for-each>
						</ul>
					</li>
				</xsl:for-each>
			</ul>
		</div>
	</xsl:template>

	<xsl:template name="bottom-content">
		<xsl:param name="pageType" />

		<!-- ========= START OF BOTTOM NAVBAR ======= -->
		<div class="bottomNav">
			<a name="navbar_bottom"></a>
			<a href="#skip-navbar_bottom" title="Skip navigation links"></a>
			<a name="navbar_bottom_firstrow"></a>
			<xsl:call-template name="nav-list">
				<xsl:with-param name="pageType" select="$pageType" />
			</xsl:call-template>
		</div>
		<!-- ========= END OF BOTTOM NAVBAR ========= -->

		<xsl:if test="/javaee:vdldoc/javaee:config/@hide-generated-by != 'true'">
			<p class="about">Output generated by <a href="http://vdldoc.omnifaces.org" target="_blank">Vdldoc</a> View Declaration Language Documentation Generator.</p>
		</xsl:if>

		<!-- ========= BEGIN SIDEBAR SCRIPTS ========= -->
		<script type="text/javascript">
			// <![CDATA[
				function toggleNamespace(namespace) {

					var sidebarUnorderedLists = document.getElementById('sidebar').getElementsByTagName('ul');

					for (var i = 0; i < sidebarUnorderedLists.length; i++) {

						if (sidebarUnorderedLists[i].className === 'sidebarNamespaceChildren') {

							if (sidebarUnorderedLists[i].id !== namespace ||
								sidebarUnorderedLists[i].style.display === 'block') {
								sidebarUnorderedLists[i].style.display = 'none';
							} else {
								sidebarUnorderedLists[i].style.display = 'block';
							}
						}
					}
				}

				function toggleSidebar() {

					var sidebar = document.getElementById('sidebar');
					var mainContent = document.getElementById('main_content');

					if (sidebar.style.display === 'none') {
						sidebar.style.display = null;
						mainContent.className = mainContent.className.replace('full', '');
					} else {
						sidebar.style.display = 'none';
						mainContent.className += ' full';
					}
				}
			// ]]>
		</script>
		<!-- ========= END SIDEBAR SCRIPTS ========= -->
	</xsl:template>

</xsl:stylesheet>
