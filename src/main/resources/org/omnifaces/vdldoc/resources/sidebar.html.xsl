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
 - @author Bauke Scholtz
-->
<xsl:stylesheet
	xmlns:javaee="http://xmlns.jcp.org/xml/ns/javaee"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:vdldoc="http://vdldoc.omnifaces.org"
	version="2.0"
>

	<xsl:output method="html" />

	<xsl:template name="sidebar-styles">
		<style>
			.namespace-children {
				display: none;
			}
		</style>
		<noscript>
			<style>
				.namespace-children {
					display: block;
				}
			</style>
		</noscript>
	</xsl:template>

	<xsl:template name="sidebar">
		<div class="indexContainer sidebar">
			<ul>
				<xsl:for-each select="/javaee:vdldoc/javaee:facelet-taglib">
					<xsl:sort select="@id" />
					<li>
						<a>
							<xsl:attribute name="onclick">toggle('<xsl:value-of select="@id" />');</xsl:attribute>
							<b>Toggle <code><xsl:value-of select="@id" /></code> Namespace</b>
						</a>
						<ul class="namespaceChildren">
							<xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
							<xsl:for-each select="javaee:tag|javaee:function|javaee:taglib-extension/vdldoc:el-variable">
								<xsl:sort select="javaee:tag-name" />
								<xsl:sort select="javaee:function-name" />
								<xsl:sort select="vdldoc:el-variable-name" />
								<xsl:if test="name() = 'tag'">
									<li>
										<a>
											<xsl:attribute name="href">../<xsl:value-of select="../@id" />/<xsl:value-of select="javaee:tag-name" />.html</xsl:attribute>
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
											<xsl:attribute name="href">../<xsl:value-of select="../@id" />/<xsl:value-of select="javaee:function-name" />.fn.html</xsl:attribute>
											<i><xsl:value-of select="../@id" />:<xsl:value-of select="javaee:function-name" />()</i>
										</a>
									</li>
								</xsl:if>
								<xsl:if test="name() = 'el-variable'">
									<!-- TODO figure out why this is failing -->
<!--									file:///Users/kylestiemann/Projects/omnifaces.org/vdldoc/target/vdldoc/alloy/audio.html
									http://www.w3schools.com/xml/xsl_elementref.asp
									https://github.com/omnifaces/vdldoc/issues/12
									http://jsfiddle.net/t40pxetc/									-->
									<li>
										<a>
											<xsl:attribute name="href">../<xsl:value-of select="../../@id" />/<xsl:value-of select="vdldoc:el-variable-name" />.el.html</xsl:attribute>
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

	<xsl:template name="sidebar-scripts">
		<script type="text/javascript">
			// <![CDATA[
				function toggle(namespace) {

					var namespaceChildren = document.querySelectorAll('.namespaceChildren');

					for (var i = 0; i < namespaceChildren.length; i++) {

						if (namespaceChildren[i].id !== namespace || namespaceChildren[i].style.display === 'block') {
							namespaceChildren[i].style.display = 'none';
						}
						else {
							namespaceChildren[i].style.display = 'block';
						}
					}
				}
			// ]]>
		</script>
	</xsl:template>

</xsl:stylesheet>