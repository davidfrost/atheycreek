<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="component-teachings">

	<xsl:param name="component" />
	<xsl:param name="position" />
	<xsl:param name="entries" />

	<xsl:if test="count($entries)">

		<xsl:choose>
			<xsl:when test="not(number($pt3)) and not(number($pt4)) and $pt4">
				<div class="title-wrapper">
					<div class="container">
						<div class="row">
							<div class="span12">
								<h2>
									<xsl:choose>
										<xsl:when test="$pt4 = 'psalm'">
											<xsl:text>Psalms</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$pt4" />
										</xsl:otherwise>
									</xsl:choose>
								</h2>
							</div>
						</div>
					</div>
				</div>
			</xsl:when>
			<xsl:when test="not(number($pt3)) and number($pt3) and $pt4">
				<div class="title-wrapper">
					<div class="container">
						<div class="row">
							<div class="span12">
								<h2>
									<xsl:text>Series: </xsl:text>
									<em>
										<xsl:call-template name="string-replace-all">
			                <xsl:with-param name="text" select="$pt5" />
			                <xsl:with-param name="replace" select="'-'" />
			                <xsl:with-param name="by" select="' '" />
			              </xsl:call-template>
									</em>
								</h2>
							</div>
						</div>
					</div>
				</div>
			</xsl:when>
			<xsl:when test="$pt2 = 'tag'">
				<div class="title-wrapper">
					<div class="container">
						<div class="row">
							<div class="span12">
								<h2>
									<xsl:text>Tag: </xsl:text>
									<em>
										<xsl:value-of select="/data/teachings-entry-by-tag-filtered/entry/tags/item[@id=$pt3]/tag/@handle" disable-output-escaping="yes" />
									</em>
								</h2>
							</div>
						</div>
					</div>
				</div>
			</xsl:when>
		</xsl:choose>

		<div>
			<xsl:call-template name="class-position">
				<xsl:with-param name="component" select="$component" />
			</xsl:call-template>
			<div class="row">
				<xsl:choose>
	 				<xsl:when test="number($pt2)">
						<div class="span12">
							<xsl:for-each select="$entries">
								<div class="result">
									<xsl:attribute name="class">
										<xsl:if test="number($pt3)">
											<xsl:text>result individual</xsl:text>
										</xsl:if>
									</xsl:attribute>
									<xsl:call-template name="teaching-entry" />
								</div>
							</xsl:for-each>
						</div>
					</xsl:when>
					<xsl:when test="$pt2 = 'book' or $pt2 = 'tag' or $pt2 = 'year' or $pt2 = 'series'">
						<div class="span12 poster">
							<xsl:if test="$pt2 = 'series'">
								<img class="img-responsive">
									<xsl:attribute name="src">
										<xsl:value-of select="$root"/>
										<xsl:text>/workspace/uploads/images/</xsl:text>
										<xsl:value-of select="/data/teachings-series-entries-all/entry[@id = $pt3]/poster/item/image/file/filename" disable-output-escaping="yes" />
									</xsl:attribute>
								</img>
								<xsl:if test="/data/teachings-series-entries-all/entry[@id = $pt3]/description != ''">
							    <div class="container">
							      <div class="row">
								    	<div class="span12 center">
												<span class="intro big">
													<xsl:value-of select="/data/teachings-series-entries-all/entry[@id = $pt3]/description" disable-output-escaping="yes" />
												</span>
								    	</div>
							      </div>
							    </div>
								</xsl:if>
							</xsl:if>
						</div>
						<div class="span8 results">
							<h3>
								<xsl:choose>
									<xsl:when test="$pt2 = 'series'">
										<xsl:text disable-output-escaping="yes">Teachings</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$entries/../pagination/@total-entries" disable-output-escaping="yes" />
										<xsl:text disable-output-escaping="yes"> results</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</h3>
							<xsl:for-each select="$entries">
								<div class="result">
									<xsl:call-template name="teaching-entry" />
								</div>
							</xsl:for-each>
							<xsl:call-template name="teachings-pagination">
								<xsl:with-param name="entries" select="$entries" />
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="/data/featured-teachings/entry">
							<div class="latest">
								<div class="span8 teaching-main">
									<h3>Latest Teaching</h3>
									<ul class="nav nav-tabs" id="teachingTab">
									  <xsl:choose>
									    <xsl:when test="string-length(video-id) or video-podcast = 'Yes'">
									      <li class="active"><a href="#video" data-toggle="tab">Video</a></li>
									      <li><a href="#audio" data-toggle="tab">Audio</a></li>
									    </xsl:when>
									    <xsl:otherwise>
									      <li class="active"><a href="#audio" data-toggle="tab">Audio</a></li>
									    </xsl:otherwise>
									  </xsl:choose>
									</ul>
									<xsl:if test="$cookie-username">
										<div class="edit-wrapper">
											<xsl:call-template name="edit-entry">
											  <xsl:with-param name="component" select="'teachings'"/>
											</xsl:call-template>
										</div>
									</xsl:if>

									<div class="tab-content">
									  <xsl:choose>
									    <xsl:when test="string-length(video-id)">
									      <div class="tab-pane fade active in" id="video">
									        <iframe src="http://player.vimeo.com/video/{video-id}?title=0&amp;byline=0&amp;portrait=0&amp;color=d83629" width="500" height="281" frameborder="0" webkitAllowFullScreen="webkitAllowFullScreen" mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen"></iframe>
									      </div>
									      <div class="tab-pane fade in" id="audio">
									        <div class="audio-poster">
									          <img style="width:620px; height:348px" src="/workspace/assets/img/spacer.gif">
									            <xsl:attribute name="data-responsimage">
									              <xsl:choose>
									                <xsl:when test="string-length(poster/item)">
									                  <xsl:value-of select="poster/item/image/file/filename" disable-output-escaping="yes" />
									                </xsl:when>
									                <xsl:otherwise>
									                  <xsl:text disable-output-escaping="yes">accf-flat-4fc3e05b81747.jpg</xsl:text>
									                </xsl:otherwise>
									              </xsl:choose>
									            </xsl:attribute>
									          </img>
									        </div>
									        <xsl:call-template name="teaching-actions" />
									      </div>
									    </xsl:when>
									    <xsl:otherwise>
									      <div class="tab-pane fade active in" id="audio">
									        <div class="audio-poster">
									          <img style="width:620px; height:348px" src="/workspace/assets/img/spacer.gif">
									            <xsl:attribute name="data-responsimage">
									              <xsl:choose>
									                <xsl:when test="string-length(poster/item)">
									                  <xsl:value-of select="poster/item/image/file/filename" disable-output-escaping="yes" />
									                </xsl:when>
									                <xsl:otherwise>
									                  <xsl:text disable-output-escaping="yes">accf-flat-4fc3e05b81747.jpg</xsl:text>
									                </xsl:otherwise>
									              </xsl:choose>
									            </xsl:attribute>
									          </img>
									        </div>
									        <xsl:call-template name="teaching-actions" />
									      </div>
									    </xsl:otherwise>
									  </xsl:choose>
									</div>
								</div>
								<div class="span4">
									<h2>
										<a>
											<xsl:call-template name="url-teachings" />
											<xsl:value-of select="title" disable-output-escaping="yes" />
										</a>
									</h2>
									<div class="meta">
										<div class="verse">
											<xsl:value-of select="book/item" />
											<xsl:text> </xsl:text>
											<xsl:value-of select="chapter" />
										</div>
										<div class="teacher">
											<em>by </em>
											<xsl:value-of select="speaker/item/first-name" disable-output-escaping="yes" />
											<xsl:text disable-output-escaping="yes"> </xsl:text>
											<xsl:value-of select="speaker/item/last-name" disable-output-escaping="yes" />
										</div>
										<div class="date">
											<xsl:call-template name="date-teaching">
												<xsl:with-param name="date" select="date/date/start/@iso" />
											</xsl:call-template>
										</div>
									</div>
									<div class="description">
										<xsl:call-template name="truncate">
                        <xsl:with-param name="node" select="description" />
                        <xsl:with-param name="length" select="230" />
                    </xsl:call-template>
									</div>
									<xsl:if test="tags/item">
										<xsl:call-template name="teaching-tag-list">
											<xsl:with-param name="tags" select="tags/item" />
										</xsl:call-template>
									</xsl:if>
								</div>
							</div>
						</xsl:for-each>
						<div class="span8">
							<xsl:variable name="items-per-row" select="2" />
							<div class="component-series">
								<h3>Teaching Series</h3>
								<div class="row">
								<xsl:for-each select="/data/teachings-series-entries-filtered/entry[position() &lt; 5]">
									<div class="span4 series">
										<a>
											<xsl:call-template name="url-teachings-series" />
											<xsl:call-template name="teaching-poster-or-default">
												<xsl:with-param name="poster" select="poster" />
											</xsl:call-template>
										</a>
									</div>
								</xsl:for-each>
								</div>
								<p class="center">
									<a class="link link-big inline" href="/teachings/series">
										<xsl:text>All Teaching Series</xsl:text>
									</a>
								</p>
								<hr/>
								<h3>Special Series</h3>
								<div class="row">
									<xsl:for-each select="/data/teachings-series-special-filtered/entry">
										<div class="span4 series">
											<a>
												<xsl:call-template name="url-teachings-series" />
												<xsl:call-template name="teaching-poster-or-default">
													<xsl:with-param name="poster" select="poster" />
												</xsl:call-template>
											</a>
										</div>
									</xsl:for-each>
								</div>
								<p class="center">
									<a class="link link-big inline" href="/teachings/series/#special">
										<xsl:text>All Special Series</xsl:text>
									</a>
								</p>
							</div>
							<h3>Recent Teachings</h3>
								<div class="row">
								  <xsl:for-each select="/data/teachings-latest/entry[position() &lt; 5]">
                    <div>
                    	<xsl:attribute name="class">
                    		<xsl:text>span4 recent number</xsl:text>
                    		<xsl:value-of select="position()" />
                    	</xsl:attribute>
                    	<a>
                  			<xsl:call-template name="url-teachings" />
	                      <h4>
                        	<xsl:choose>
                        		<xsl:when test="position() = 1 and featured = 'Yes'">
                        			<xsl:call-template name="truncate">
				                        <xsl:with-param name="node" select="title" />
				                        <xsl:with-param name="length" select="25" />
				                      </xsl:call-template>
				                      <span class="label accent">FEATURED</span>
                        		</xsl:when>
                        		<xsl:otherwise>
                        			<xsl:call-template name="truncate">
				                        <xsl:with-param name="node" select="title" />
				                        <xsl:with-param name="length" select="30" />
				                      </xsl:call-template>
                        		</xsl:otherwise>
                        	</xsl:choose>
	                      </h4>
		                    <div class="meta">
		                      <p>
		                        <xsl:call-template name="date-teaching">
		                           <xsl:with-param name="date" select="date/date/start/@iso" />
		                        </xsl:call-template>
		                      </p>
		                    </div>
		                    <div class="description">
		                    	<p>
		                    		<span>
		                    			<xsl:call-template name="truncate">
				                        <xsl:with-param name="node" select="description" />
				                        <xsl:with-param name="length" select="100" />
				                      </xsl:call-template>
		                    		</span>
		                    	</p>
		                    </div>
                  		</a>
                  	</div>
                	</xsl:for-each>
              	</div>
              	<xsl:value-of select="normalize-space(/data/misc-all-entries/entry[name='radio']/content)" disable-output-escaping="yes" />
						</div>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="$position = 'column-full-width' and not(number($pt2))">
						<xsl:call-template name="teachings-sidebar"/>
					</xsl:when>
				</xsl:choose>
			</div>
		</div>
	</xsl:if>

</xsl:template>

<xsl:template name="teaching-series-entry">
	<xsl:param name="entry" select="." />
	<xsl:for-each select="$entry">
		<div class="row">
			<div class="span12">
				<a>
					<xsl:call-template name="url-teachings-series" />
					<xsl:call-template name="teaching-poster-or-default">
						<xsl:with-param name="poster" select="poster" />
					</xsl:call-template>
				</a>
			</div>
		</div>
		<div class="carousel-caption">
			<a>
				<xsl:call-template name="url-teachings-series" />
				<h3>
					<xsl:text>Featured Series: </xsl:text>
					<em class="verse">
						<xsl:text> </xsl:text>
						<xsl:value-of select="title" />
					</em>
				</h3>
			</a>
		</div>
	</xsl:for-each>
</xsl:template>


<xsl:template name="teachings-sidebar">

	<div class="span4">
		<h3>Search</h3>
		<div class="widget filter">
			<h4>Teachings by Series</h4>
			<h5>Books of the Bible</h5>
			<div class="collection books">
				<xsl:for-each select="/data/teachings-series-entries-all/entry[not(special) or special = 'No']">
					<a>
						<xsl:call-template name="url-teachings-series" />
						<xsl:value-of select="title" disable-output-escaping="yes" />
					</a>
					<xsl:if test="position() &lt; last()">, </xsl:if>
				</xsl:for-each>
			</div>
			<h5>Special Series</h5>
			<div class="collection books">
				<xsl:for-each select="/data/teachings-series-entries-all/entry[special = 'Yes']">
					<a>
						<xsl:call-template name="url-teachings-series" />
						<xsl:value-of select="title" disable-output-escaping="yes" />
					</a>
					<xsl:if test="position() &lt; last()">, </xsl:if>
				</xsl:for-each>
			</div>
		</div>
		<div class="widget filter">
			<h4>Teachings by Year</h4>
			<div class="collection">
				<xsl:call-template name="years-counter" />
			</div>
		</div>
		<div class="widget filter">
			<h4>Teachings by Tags</h4>
			<div class="inline-search">
				<form>
					<xsl:attribute name="action">
						<xsl:call-template name="url-search-home">
							<xsl:with-param name="url-only" select="true()" />
						</xsl:call-template>
					</xsl:attribute>
					<label for="keywords"><span class="icon">s</span></label>
					<input type="hidden" name="sections" value="teachings-tags" />
					<input name="keywords" class="keywords" placeholder="Search" autocomplete="off" onclick="this.select()" />
				</form>
			</div>
			<div class="collection">
				<xsl:for-each select="/data/teachings-tags-random-filtered/entry">
					<a>
						<xsl:call-template name="url-teachings-tags" />
						<xsl:value-of select="tag" disable-output-escaping="yes" />
					</a>
					<xsl:if test="position() &lt; last()">, </xsl:if>
				</xsl:for-each>
			</div>
		</div>
		<h3>Podcasts</h3>
  	<div class="podcast">
  		<div>
				<p>One of the best ways to connect to our Bible teachings is through podcasts. Our podcasts stream all of our latest teachings to your device.</p>
				<p class="center">
					<a class="link link-small inline center">
						<xsl:attribute name="href">
							<xsl:value-of select="$main-podcast-audio" disable-output-escaping="yes" />
						</xsl:attribute>
						<xsl:text>Audio Podcast</xsl:text>
					</a>
				</p>
				<p class="center">
					<a class="link link-small inline center">
						<xsl:attribute name="href">
							<xsl:value-of select="$main-podcast-video" disable-output-escaping="yes" />
						</xsl:attribute>
						<xsl:text>Video Podcast</xsl:text>
					</a>
				</p>
				<p class="center">
					<a class="link link-small inline center">
						<xsl:attribute name="href">
							<xsl:value-of select="$main-podcast-video-hd" disable-output-escaping="yes" />
						</xsl:attribute>
						<xsl:text>Video Podcast HD</xsl:text>
					</a>
				</p>
			</div>
		</div>
	</div>

</xsl:template>


<xsl:template name="teachings-series-landing">

	<div class="title-wrapper">
		<div class="container">
			<div class="row">
				<div class="span12">
					<h2 style="text-align: center !important;">
						<xsl:text>Teaching Series</xsl:text>
					</h2>
				</div>
			</div>
		</div>
	</div>
	<div class="component component-teachings">
		<div class="container">
			<div class="component-series">
				<div class="row">
					<xsl:for-each select="/data/teachings-series-entries-all/entry[not(special) or special = 'No']">
						<div class="span4 series">
							<a>
								<xsl:call-template name="url-teachings-series" />
								<xsl:call-template name="teaching-poster-or-default">
									<xsl:with-param name="poster" select="poster" />
								</xsl:call-template>
							</a>
							<div class="info">
								<a>
									<xsl:call-template name="url-teachings-series" />
									<h4 class="center">
										<xsl:value-of select="title" disable-output-escaping="yes" />
									</h4>
								</a>
							</div>
						</div>
					</xsl:for-each>
				</div>
				<div class="row">
					<br/>
					<h2 id="special" class="center">Special Series</h2>
					<xsl:for-each select="/data/teachings-series-entries-all/entry[special = 'Yes']">
						<div class="span4 series">
							<a>
								<xsl:call-template name="url-teachings-series" />
								<xsl:call-template name="teaching-poster-or-default">
									<xsl:with-param name="poster" select="poster" />
								</xsl:call-template>
							</a>
							<div class="info">
								<a>
									<xsl:call-template name="url-teachings-series" />
									<h4 class="center">
										<xsl:value-of select="title" disable-output-escaping="yes" />
										<xsl:if test="featured = 'Yes'">
											<xsl:text>&#160;</xsl:text>
											<span class="label accent">Featured</span>
											<xsl:text>&#160;</xsl:text>
										</xsl:if>
									</h4>
								</a>
							</div>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</div>
	</div>

</xsl:template>


<xsl:template name="teachings-home">

	<div class="component-teachings">
		<div class="row">
			<div class="span12">
				<h3>Recent Teachings</h3>
	        <div class="row">
	          <xsl:for-each select="/data/teachings-latest/entry[position() &lt; 4]">
	            <div>
	            	<xsl:attribute name="class">
	            		<xsl:text>span4 recent number</xsl:text>
	            		<xsl:value-of select="position()" />
	            	</xsl:attribute>
	              <a>
	                <xsl:call-template name="url-teachings" />
	                <h4>
	                  <xsl:choose>
	                    <xsl:when test="position() = 1 and featured = 'Yes'">
	                      <xsl:call-template name="truncate">
	                        <xsl:with-param name="node" select="title" />
	                        <xsl:with-param name="length" select="25" />
	                      </xsl:call-template>
	                      <span class="label accent">FEATURED</span>
	                    </xsl:when>
	                    <xsl:otherwise>
	                      <xsl:call-template name="truncate">
	                        <xsl:with-param name="node" select="title" />
	                        <xsl:with-param name="length" select="30" />
	                      </xsl:call-template>
	                    </xsl:otherwise>
	                  </xsl:choose>
	                </h4>

	                <div class="meta">
	                  <p>
	                    <xsl:call-template name="date-teaching">
	                       <xsl:with-param name="date" select="date/date/start/@iso" />
	                    </xsl:call-template>
	                  </p>
	                </div>
	                <div class="description">
	                  <p>
	                    <span>
	                      <xsl:call-template name="truncate">
	                        <xsl:with-param name="node" select="description" />
	                        <xsl:with-param name="length" select="100" />
	                      </xsl:call-template>
	                    </span>
	                  </p>
	                </div>
	            	</a>
	            </div>
	          </xsl:for-each>
	        </div>
	        <div class="row num2">
	          <xsl:for-each select="/data/teachings-latest/entry[position() &gt; 3]">
	            <div>
	            	<xsl:attribute name="class">
	            		<xsl:text>span4 recent number</xsl:text>
	            		<xsl:value-of select="position()" />
	            	</xsl:attribute>
	              <a>
	              	<xsl:call-template name="url-teachings" />

	                <h4>
	                  <xsl:value-of select="title" disable-output-escaping="yes" />
	                  <xsl:if test="featured = 'Yes'">
	                  	<span class="label accent">FEATURED</span>
	                  </xsl:if>
	                </h4>

	                <div class="meta">
	                  <p>
	                    <xsl:call-template name="date-teaching">
	                    	<xsl:with-param name="date" select="date/date/start/@iso" />
	                    </xsl:call-template>
	                  </p>
	                </div>
	                <div class="description">
	                  <p>
	                    <span>
	                      <xsl:call-template name="truncate">
	                        <xsl:with-param name="node" select="description" />
	                        <xsl:with-param name="length" select="100" />
	                      </xsl:call-template>
	                    </span>
	                  </p>
	                </div>
	            	</a>
	            </div>
	          </xsl:for-each>
	        </div>
			</div>
		</div>

		<div class="component-series">
			<h3 class="title-row">Teaching Series <a href="/teachings/series" class="pull-right hidden-phone">All Teaching Series</a></h3>
			<div class="row">
				<xsl:for-each select="/data/teachings-series-entries-filtered/entry[position() &lt; 4]">
					<div class="span4 series">
						<a>
							<xsl:call-template name="url-teachings-series" />
							<xsl:call-template name="teaching-poster-or-default">
								<xsl:with-param name="poster" select="poster" />
							</xsl:call-template>
						</a>
					</div>
				</xsl:for-each>
				<div class="center visible-phone">
					<a href="/teachings/series" class="link-big inline">See All Teachings Series</a>
				</div>
			</div>
			<h3 class="title-row">Special Series <a href="/teachings/series/#special" class="pull-right hidden-phone">All Special Series</a></h3>
			<div class="row">
				<xsl:for-each select="/data/teachings-series-special-filtered/entry[position() &lt; 4]">
					<div class="span4 series">
						<a>
							<xsl:call-template name="url-teachings-series" />
							<xsl:call-template name="teaching-poster-or-default">
								<xsl:with-param name="poster" select="poster" />
							</xsl:call-template>
						</a>
					</div>
				</xsl:for-each>
				<div class="center visible-phone">
					<a href="/teachings/series/#special" class="link-big inline">See All Special Series</a>
				</div>
			</div>

			<hr/>

			<xsl:value-of select="normalize-space(/data/misc-all-entries/entry[name='main-podcast']/content)" disable-output-escaping="yes" />

		</div>

	</div>

</xsl:template>


<xsl:template name="teaching-entry">

	<xsl:param name="entry" select="." />

	<xsl:for-each select="$entry">
		<xsl:if test="not($pt1)">
			<div class="row">
				<div class="span12">
					<a>
						<xsl:call-template name="url-teachings" />
							<img style="width:940px; height: 529px" src="/workspace/assets/img/spacer.gif">
								<xsl:attribute name="data-responsimage">
									<xsl:choose>
										<xsl:when test="string-length(poster/item)">
											<xsl:value-of select="poster/item/image/file/filename" disable-output-escaping="yes" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">accf-flat-4fc3e05b81747.jpg</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
							</img>
					</a>
				</div>
			</div>
			<div class="carousel-caption">
				<a>
					<xsl:call-template name="url-teachings" />
					<h3>
						<xsl:text>Featured Teaching: </xsl:text>
						<em class="verse">
							<xsl:text> </xsl:text>
							<xsl:value-of select="book/item" />
							<xsl:text> </xsl:text>
							<xsl:value-of select="chapter" />
						</em>
					</h3>
				</a>
			</div>
		</xsl:if>
		<xsl:if test="number($pt2)">

			<div class="title-wrapper">
				<div class="container">
					<div class="row">
						<div class="span12 center">
							<h2>
								<xsl:value-of select="title" disable-output-escaping="yes" />
								<span class="verse">
									<xsl:text>&#160;&#160;(</xsl:text>
									<xsl:if test="book/item != ''">
										<xsl:value-of select="book/item" />
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:value-of select="chapter" />
									<xsl:text>)</xsl:text>
								</span>
							</h2>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
			  <div class="span8 teaching-main">
			    <ul class="nav nav-tabs" id="teachingTab">
			      <xsl:choose>
			        <xsl:when test="string-length(video-id) or video-podcast = 'Yes'">
			          <li class="active"><a href="#video" data-toggle="tab">Video</a></li>
			          <li><a href="#audio" data-toggle="tab">Audio</a></li>
			        </xsl:when>
			        <xsl:otherwise>
			          <li class="active"><a href="#audio" data-toggle="tab">Audio</a></li>
			        </xsl:otherwise>
			      </xsl:choose>
			    </ul>
			    <xsl:if test="$cookie-username">
			    	<div class="edit-wrapper">
			    		<xsl:call-template name="edit-entry">
			    		  <xsl:with-param name="component" select="'teachings'"/>
			    		</xsl:call-template>
			    	</div>
			    </xsl:if>
			    <div class="tab-content">
			      <xsl:choose>
			        <xsl:when test="string-length(video-id)">
			          <div class="tab-pane fade active in" id="video">
			          	<iframe src="http://player.vimeo.com/video/{video-id}?title=0&amp;byline=0&amp;portrait=0&amp;color=d83629" width="500" height="281" frameborder="0" webkitAllowFullScreen="webkitAllowFullScreen" mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen"></iframe>
			          </div>
			          <div class="tab-pane fade in" id="audio">
			            <div class="audio-poster">
			              <img style="width:620px; height:348px" src="/workspace/assets/img/spacer.gif">
			                <xsl:attribute name="data-responsimage">
			                  <xsl:choose>
			                    <xsl:when test="string-length(poster/item)">
			                      <xsl:value-of select="poster/item/image/file/filename" disable-output-escaping="yes" />
			                    </xsl:when>
			                    <xsl:otherwise>
			                      <xsl:text disable-output-escaping="yes">accf-flat-4fc3e05b81747.jpg</xsl:text>
			                    </xsl:otherwise>
			                  </xsl:choose>
			                </xsl:attribute>
			              </img>
			            </div>
			            <xsl:call-template name="teaching-actions" />
			          </div>
			        </xsl:when>
			        <xsl:otherwise>
			          <div class="tab-pane fade active in" id="audio">
			            <div class="audio-poster">
			              <img style="width:620px; height:348px" src="/workspace/assets/img/spacer.gif">
			                <xsl:attribute name="data-responsimage">
			                  <xsl:choose>
			                    <xsl:when test="string-length(poster/item)">
			                      <xsl:value-of select="poster/item/image/file/filename" disable-output-escaping="yes" />
			                    </xsl:when>
			                    <xsl:otherwise>
			                      <xsl:text disable-output-escaping="yes">accf-flat-4fc3e05b81747.jpg</xsl:text>
			                    </xsl:otherwise>
			                  </xsl:choose>
			                </xsl:attribute>
			              </img>
			            </div>
			            <xsl:call-template name="teaching-actions" />
			          </div>
			        </xsl:otherwise>
			      </xsl:choose>

			    </div>
			  </div>
			  <div class="span4">
			    <div class="teacher">
			      <em>by </em>
			      <strong>
			        <xsl:value-of select="speaker/item/first-name" disable-output-escaping="yes" />
			        <xsl:text disable-output-escaping="yes"> </xsl:text>
			        <xsl:value-of select="speaker/item/last-name" disable-output-escaping="yes" />
			      </strong>
			    </div>
			    <div class="avatar">
			      <xsl:call-template name="speaker-avatar">
			        <xsl:with-param name="photo" select="speaker/item/photo/file/filename" />
			        <xsl:with-param name="height" select="140" />
			        <xsl:with-param name="width" select="140" />
			      </xsl:call-template>
			    </div>
			    <div class="about">
			      <xsl:value-of select="speaker/item/about" disable-output-escaping="yes" />
			    </div>
			  </div>
			</div>

			<div class="row">
				<div class="span8">
					<div class="meta">
						<p>
							<xsl:if test="string-length(filename) &gt; 0">
								<span class="badge">
									<xsl:value-of select="filename" />
								</span>
								<span class="divider">|</span>
							</xsl:if>
							<span class="date">
								<xsl:call-template name="date-teaching">
									<xsl:with-param name="date" select="date/date/start/@iso" />
								</xsl:call-template>
							</span>
						</p>
					</div>
					<div class="description">
						<xsl:value-of select="description"  disable-output-escaping="yes" />
					</div>

				</div>
				<div class="span4">
					<xsl:if test="tags/item">
						<xsl:call-template name="teaching-tag-list">
							<xsl:with-param name="tags" select="tags/item" />
						</xsl:call-template>
					</xsl:if>
				</div>
				<div class="span12">
					<br/><br/>
					<hr/>
					<br/><br/>
					<xsl:value-of select="normalize-space(/data/misc-all-entries/entry[name='main-podcast']/content)" disable-output-escaping="yes" />
				</div>
			</div>

		</xsl:if>

		<xsl:if test="not(number($pt2))">
			<xsl:choose>
				<xsl:when test="not($pt1)">
				</xsl:when>
				<xsl:otherwise>
					<h4>
						<a>
							<xsl:call-template name="url-teachings" />
							<xsl:value-of select="title" disable-output-escaping="yes" />
							<span class="verse">
								<xsl:value-of select="book/item" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="chapter" />
							</span>
						</a>
					</h4>
					<div class="meta">
						<p>
							<xsl:if test="string-length(filename)">
								<span class="badge">
									<xsl:value-of select="filename" />
								</span>
							</xsl:if>
							<span class="teacher">
								<em>by </em>
								<xsl:value-of select="speaker/item/first-name" disable-output-escaping="yes" />
								<xsl:text disable-output-escaping="yes"> </xsl:text>
								<xsl:value-of select="speaker/item/last-name" disable-output-escaping="yes" />
							</span>
							<span class="verse">
								<span class="icon">u</span>
								<xsl:text> </xsl:text>
								<xsl:value-of select="book/item" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="chapter" />
							</span>
							<span class="divider">|</span>
							<span class="date">
								<xsl:call-template name="format-date">
									<xsl:with-param name="date" select="date/date/start/@iso" />
									<xsl:with-param name="format" select="'%m+; %d;%ds;, %y+;'" />
								</xsl:call-template>
							</span>
						</p>
					</div>
					<div class="description">
						<xsl:value-of select="description" disable-output-escaping="yes" />
					</div>
					<xsl:call-template name="teaching-tag-list">
						<xsl:with-param name="tags" select="tags/item" />
					</xsl:call-template>

					<xsl:if test="string-length(filename)">
						<span class="pull-right" style="position:relative;top:-38px;right:5px;">
							<xsl:variable name="audio-url">
								<xsl:text disable-output-escaping="yes">http://66.147.244.244/~atheycre/teachings/</xsl:text>
								<xsl:value-of select="translate(filename,$en-uppercase-letters,$en-lowercase-letters)"/>
								<xsl:text>.mp3</xsl:text>
							</xsl:variable>
							<a href="{$audio-url}" class="btn btn-default" target="_blank">
					    	<span class="icon">d</span>
					    	<span class="text">Download</span>
					    </a>
						</span>
					</xsl:if>

				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:for-each>

</xsl:template>


<xsl:template name="teaching-actions">

	<xsl:param name="entry" select="." />

	<xsl:variable name="audio-url">
		<!-- <xsl:text>http://72.10.33.203/media/audio/teachings/</xsl:text> -->
		<xsl:text disable-output-escaping="yes">http://66.147.244.244/~atheycre/teachings/</xsl:text>
		<xsl:value-of select="translate(filename,$en-uppercase-letters,$en-lowercase-letters)"/>
		<xsl:text>.mp3</xsl:text>
	</xsl:variable>

	<div class="teaching-actions">

		<div class="audio-container">
			<audio src="{$audio-url}" preload="auto" controls="true"></audio>
		</div>

		<a href="{$audio-url}" class="link link-small downloadPopover pull-left" target="_blank">
    	<span class="icon">d</span>
    	<span class="text hidden-phone">Download</span>
    </a>

	</div>

</xsl:template>


<xsl:template name="teaching-tag-list">

	<xsl:param name="tags" />

	<div class="tags" style="text-transform: uppercase;">
		<span class="icon">z</span>
		<xsl:for-each select="tags/item">
			<a>
				<xsl:call-template name="url-teachings-tags" />
				<xsl:value-of select="." disable-output-escaping="yes" />
			</a>
			<xsl:if test="position() &lt; last()">,</xsl:if>
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</div>

</xsl:template>


<xsl:template name="date-teaching">

	<xsl:param name="date" />

	<xsl:call-template name="format-date">
		<xsl:with-param name="date" select="$date" />
		<xsl:with-param name="format" select="'%d+;, %m+; %d;%ds;, %y+;'" />
	</xsl:call-template>

</xsl:template>


<xsl:template name="bible-book">

	<xsl:param name="book" />

	<xsl:choose>
		<xsl:when test="$book = 'Psalms'">
			<a href="{$root}/{/data/tags-all-entries/entry[tag/@handle = 'teachings']/@id}/teachings/book/psalm/">
				<xsl:text>Psalms</xsl:text>
			</a>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$root}/{/data/tags-all-entries/entry[tag/@handle = 'teachings']/@id}/teachings/book/{$book/@handle}/">
				<xsl:value-of select="$book" />
			</a>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>


<xsl:template name="years-counter">

	<xsl:param name="howMany">1997</xsl:param>

	<xsl:if test="$howMany &lt; $this-year + 1">
		<a href="{$root}/teachings/year/{$howMany}/"><xsl:value-of select="$howMany" /></a>
		<xsl:if test="$howMany &lt; $this-year">, </xsl:if>
		<xsl:call-template name="years-counter">
		<xsl:with-param name="howMany" select="$howMany + 1" />
		</xsl:call-template>
	</xsl:if>

</xsl:template>


<xsl:template name="teaching-poster-or-default">

	<xsl:param name="poster" />

	<xsl:call-template name="component-images">
		<xsl:with-param name="component" select="'images'"/>
		<xsl:with-param name="position" select="'column-full-width'"/>
		<xsl:with-param name="entries" select="images/item" />
	</xsl:call-template>

	<img style="height:169px; width:100%;" src="/workspace/assets/img/spacer.gif">
		<xsl:attribute name="data-responsimage">
			<xsl:choose>
				<xsl:when test="string-length(poster/item)">
					<xsl:value-of select="$poster/item/image/file/filename" disable-output-escaping="yes" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">accf-flat-4fc3e05b81747.jpg</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</img>

</xsl:template>

<xsl:template name="teachings-pagination">

	<xsl:param name="entries" />

	<xsl:call-template name="cd-pagination">
		<xsl:with-param name="pagination" select="$entries/../pagination" />
		<xsl:with-param name="pagination-url">
			<xsl:value-of select="$root" /><xsl:text>/</xsl:text>
			<xsl:if test="$pt1">
				<xsl:value-of select="$pt1" /><xsl:text>/</xsl:text>
			</xsl:if>
			<xsl:if test="$pt2">
				<xsl:value-of select="$pt2" /><xsl:text>/</xsl:text>
			</xsl:if>
			<xsl:if test="$pt3">
				<xsl:value-of select="$pt3" /><xsl:text>/</xsl:text>
			</xsl:if>
			<xsl:if test="$pt4">
				<xsl:value-of select="'$'" /><xsl:text>/</xsl:text>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>

</xsl:template>

<xsl:template name="speaker-avatar">

	<xsl:param name="photo" />
	<xsl:param name="width" />
	<xsl:param name="height" />

	<img width="{$width}" height="{$height}" class="img-circle" data-responsimage-anchor="5" src="/workspace/assets/img/spacer.gif">
		<xsl:attribute name="data-responsimage">
			<xsl:choose>
				<xsl:when test="string-length($photo)">
					<xsl:value-of select="$photo" disable-output-escaping="yes" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">anonymous-4fef5a675fd64.jpg</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</img>

</xsl:template>


</xsl:stylesheet>
