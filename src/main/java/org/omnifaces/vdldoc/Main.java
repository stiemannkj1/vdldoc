/*
 * Copyright (c) 2012, OmniFaces
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
 * following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice, this list of conditions and the
 *       following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
 *       following disclaimer in the documentation and/or other materials provided with the distribution.
 *     * Neither the name of OmniFaces nor the names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package org.omnifaces.vdldoc;

import java.io.File;
import java.util.Arrays;
import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * Main entry point for Vdldoc. Allows commandline access.
 *
 * @author Bauke Scholtz
 */
public class Main {

	private static final String USAGE = ""
		+ " ------------------------------------------------------------------------------\n"
		+ "                         VDL Documentation Generator                           \n"
		+ " Usage:                                                                        \n"
		+ "                vdldoc [options] taglib1 [taglib2 [taglib3 ...]]               \n"
		+ "                                                                               \n"
		+ " options:                                                                      \n"
		+ "   -help                  Displays this help message.                          \n"
		+ "   -d <directory>         Destination directory for output files.              \n"
		+ "                          This defaults to new dir called 'vdldoc'.            \n"
		+ "   -windowtitle <text>    Browser window title. This defaults to               \n"
		+ "                          VDL Documentation Generator - Generated Documentation\n"
		+ "   -doctitle <html-code>  Documentation title for the VDL index page.          \n"
		+ "                          This defaults to the same as window title.           \n"
		+ "   -css <uri>             URI of the CSS file. This defaults to internal CSS.  \n"
		+ "   -facesconfig <path>    Path to the faces-config.xml file.                   \n"
		+ "   -attr <path>           Path to properties file containing descriptions for  \n"
		+ "                          implied attributes of composite components, such as  \n"
		+ "                          'id', 'rendered', etc.                               \n"
		+ "   -f                     Hide 'Output generated by Vdldoc' footer.            \n"
		+ "   -disable-frame-pages   Disable generation of obsolete frame pages (which    \n"
		+ "                          duplicate content of the overview page: index.html). \n"
		+ "                          By default, vdlddoc generates pages like alltags.html\n"
		+ "                          with the same content as index.html to ensure that   \n"
		+ "                          links to the previous version of the documentation   \n"
		+ "                          are not broken. Disabling these pages is not         \n"
		+ "                          recommended unless you plan on redirecting users to  \n"
		+ "                          index.html via server functionality or you have never\n"
		+ "                          used vdldoc 2 or lower to generate your vlddoc.      \n"
		+ "   -q                     Quiet Mode, i.e. disable logging.                    \n"
		+ "                                                                               \n"
		+ " taglib1 [taglib2 [taglib3 ...]]: Space separated paths to .taglib.xml files.  \n"
		+ "                                                                               \n"
		+ "     NOTE: if an argument or file path contains by itself spaces, quote it.    \n"
		+ " ------------------------------------------------------------------------------\n"
		+ "";

	/**
	 * Runs the {@link VdldocGenerator} with the given arguments.
	 * @param args The arguments.
	 */
	public static void main(String[] args) {
		VdldocGenerator generator = new VdldocGenerator();
		Iterator<String> iter = Arrays.asList(args).iterator();
		boolean atLeastOneTaglib = false;

		try {
			while (iter.hasNext()) {
				String arg = iter.next();

				if (arg.equals("-help")) {
					showUsage(null);
				}
				else if (arg.equals("-d")) {
					generator.setOutputDirectory(new File(iter.next()));
				}
				else if (arg.equals("-windowtitle")) {
					generator.setWindowTitle(iter.next());
				}
				else if (arg.equals("-doctitle")) {
					generator.setDocTitle(iter.next());
				}
				else if (arg.equals("-css")) {
					generator.setCssLocation(iter.next());
				}
				else if (arg.equals("-facesconfig")) {
					generator.setFacesConfig(new File(iter.next()));
				}
				else if (arg.equals("-attr")) {
					generator.setAttributes(new File(iter.next()));
				}
				else if (arg.equals("-f")) {
					generator.setHideGeneratedBy(true);
				}
				else if (arg.equals("-disable-frame-pages")) {
					generator.setEnableFramePages(false);
				}
				else if (arg.equals("-q")) {
					generator.setQuiet(true);
				}
				else {
					generator.addTaglib(new File(arg));
					atLeastOneTaglib = true;
				}
			}

			if (!atLeastOneTaglib) {
				showUsage("Please specify at least one .taglib.xml file.");
			}
		}
		catch (NoSuchElementException e) {
			showUsage("Invalid Syntax.");
		}

		try {
			generator.generate();
			System.exit(0);
		}
		catch (IllegalArgumentException e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	private static void showUsage(String error) {
		if (error != null) {
			System.err.println("\nERROR: " + error + " See below for the usage.\n");
		}

		System.out.println(USAGE);
		System.exit(error != null ? 1 : 0);
	}

}