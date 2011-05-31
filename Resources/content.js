{	"last_updated": "201105280937",  
	"cell_textLabel_numberOfLines":1,
	"cell_textLabel_fontSize":20,   
	"cell_height":60,
	"cell_types":"UITableViewCellStyleDefault",     
	"title":"Latin Squares",
	"items": [[
		{                                                
			"cell_types":"UITableViewCellStyleSubtitle",    
			"cell_height":90,           
  			"cell_textLabel_numberOfLines":3,
			"cell_textLabel_fontSize":20,
			"icon": "theory",
			"title": "Theory",
			"content_type": "LSTableView",
			"items": [
				[
					{
						"content_type": "LSWebsiteView",
						"title":"What is a Latin Square?",       
						"subtitle":"A definition and common examples",
						"html":"<style>.nocolor{ background-color:#ffffff; } .nocolor td{ background-color:#ffffff; } table { background-color:#333333; } td { background-color:#ffffff; }  th { color:#ffffff; }  </style> <p>Suppose you have n copies of n different objects that you want to arrange in a grid. If you place them in such a way so that each row and each column of the grid contains exactly one of each object, then your grid is what we call a Latin square of order n. The objects are usually the numbers in the set { 1 , 2 , ..., n }, but they can be anything. For example, the following is a Latin square of order 4</p><table cellspacing=\"1\" cellpadding=\"10\"> <tbody> <tr> <td>1</td> <td>2</td> <td>3</td> <td>4</td> </tr> <tr> <td>2</td> <td>1</td> <td>4</td> <td>3</td> </tr> <tr> <td>3</td> <td>4</td> <td>1</td> <td>2</td> </tr> <tr> <td>4</td> <td>3</td> <td>2</td> <td>1</td> </tr> </tbody> </table> </p>"
					},
					{
						"content_type": "LSWebsiteView",
						"title":"When are two squares different?",        
						"subtitle":"Isotopism VS Isomorphism.",
						"html":"<style>.nocolor{ background-color:#ffffff; } .nocolor td{ background-color:#ffffff; } table { background-color:#333333; } td { background-color:#ffffff; }  th { color:#ffffff; }  </style> <p>Given a Latin square, there are 6 special moves that you can perform, which I have split up in to two categories.</p> <h4>Isotopy moves</h4> <ol> <li>Swap the position of two rows.</li> <li>Swap the position of two columns.</li> <li>Swap every occurrence of some symbol with every occurrence of another symbol.</li> </ol> <p>Using these moves, we are able to alter the any Latin square so that the numbers in the first row and first column appear in ascending numerical order; this is know as <strong>reduced form</strong>.</p> <h4>Conjugacy moves</h4> <p>For the following 3 moves, it might be best to think about Latin squares in a slightly different way. Suppose we have a little ordered triple or the form (row, column, symbol) for every cell in the grid, for example, in this Latin square,</p><br/><table cellspacing=\"1\" cellpadding=\"10\"> <tbody> <tr> <td>1</td> <td>2</td> <td>3</td> <td>4</td> </tr> <tr> <td>2</td> <td>1</td> <td>4</td> <td>3</td> </tr> <tr> <td>3</td> <td>4</td> <td>1</td> <td>2</td> </tr> <tr> <td>4</td> <td>3</td> <td>2</td> <td>1</td> </tr> </tbody> </table></p> we would have the following set of triples:</p> <p>{<br /> (1,1,1),(1,2,2),(1,3,3),(1,4,4),<br /> (2,1,2),(2,2,1),(2,3,4),(2,4,3),<br /> (3,1,3),(3,2,4),(3,3,1),(3,4,2),<br /> (4,1,4),(4,2,3),(4,3,2),(4,4,1)<br /> }</p> <p>Now what would happen if instead of each triple being of the form (row, column, symbol) they were of the form (column, symbol, row)? The above set of triples would still describe a Latin square! As soon as you notice that reordering the triple doesn&#8217;t change how often each symbol appears in each row/column or how many symbols appear in any cell, you&#8217;ll realise that this type of swapping can&#8217;t cause a violation of the definition of a Latin square. The next three moves formalise this process.</p> <ol start=\"4\"> <li>Swap the meaning of rows and columns (i.e. flip the square along the main diagonal to get the <a href=\"http://en.wikipedia.org/wiki/Transpose\">transpose</a> of the square).</li> <li>Swap the meaning of rows and symbols.</li> <li>Swap the meaning of columns and symbols.</li> </ol> <p>Let A and B be a couple of Latin squares of the same order. If I can convert A into B by using any of the isotopy moves, then we say A is <strong>isotopic</strong> to B (and vice versa). If I can convert A in to B using any of the conjugacy moves, then, you guessed it, A is <strong>conjugate</strong> to B (and vice versa). Finally if A is isotopic to a conjugate of B, then we say that A is <strong>main class equivalent</strong> (or, for brevity, <strong>equivalent</strong>) to B. If two Latin squares are not main class equivalent, we call them <strong>different</strong>.</p> "
					},
					{
						"content_type": "LSWebsiteView",
						"title":"How many squares of order n are there?",  
						"subtitle":"Is there an combinatorial explosion?",
						"html":"<style>.nocolor{ background-color:#ffffff; } .nocolor td{ background-color:#ffffff; } table { background-color:#333333; } td { background-color:#ffffff; }  th { color:#ffffff; }  </style> <p>If you haven't read the &quot;When are two squares different&quot; article, you might like to do that now. In the following table, two squares are described as &quot;different&quot; if they are not main-class equivalent.</p><table cellspacing=\"1\" cellpadding=\"10\"> <thead> <tr> <th>n</th> <th>Number of different Latin squares of order n</th> </tr> </thead> <tbody> <tr> <td>1</td> <td>1</td> </tr> <tr> <td>2</td> <td>1</td> </tr> <tr> <td>3</td> <td>1</td> </tr> <tr> <td>4</td> <td>2</td> </tr> <tr> <td>5</td> <td>2</td> </tr> <tr> <td>6</td> <td>12</td> </tr> <tr> <td>7</td> <td>147</td> </tr> <tr> <td>8</td> <td>283657</td> </tr> <tr> <td>9</td> <td>19270853541</td> </tr> <tr> <td>10</td> <td>34817397894749940</td> </tr> <tr> <td>11</td> <td>2036029552582883134196099</td> </tr> </tbody> </table> <p>What you see here is very common in my area of mathematics, and it is affectionately known as the <a href=\"http://en.wikipedia.org/wiki/Combinatorial_explosion\">combinatorial explosion</a> &#8211; the point at which the number of objects we&#8217;re looking at grows very rapidly.</p> <p>The dream would be to have a formula DifferentLS(n) that computes the number of Latin squares for any value of n, but so far nobody has managed to create such a formula. Having said that, we do know something about the maximum and minimum values DifferentLS(n) could take, for any value of n. That is, we have upper and lower bounds for DifferentLS(n). </p> <p>We can very quickly create crude lower bounds, for example a lower bound is 1, because there does always exist a Latin square. To prove this, create an empty (n x n) grid and place the numbers 1, 2, &#8230;, n in the top row. In the second row, cycle the numbers round by 1 position, and place the numbers 2, 3, &#8230;, n, 1. In the third row, cycle the numbers around again, and place the numbers 3, 4, &#8230;, n, 1, 2. Carry on in this way until you reach the end of the square. You have now created the <strong>Cyclic Latin square</strong>! For an upper bound, we know that each row contains a permutatation of the symbols in the set {1, 2, &#8230;, n} and there are n! = n * (n-1) * (n-2) * &#8230; * 2 * 1 different permutations to choose from. As there are also n rows, we have an upper bound of (n!)^n. </p> <p>However, I&#8217;ll think you&#8217;ll agree that those bounds are not very good. How can we do better? Can we make the problem easier? Rather than calculate the number of different squares, we could just calculate the total number of squares, that is, all Latin squares that are not identical, but might be isotopic or a conjugates, denoted L(n). For this question, we have the bounds of van Lint and Wilson:</p> <p><img alt=\"Bounds for LS(n)\" src=\"http://upload.wikimedia.org/math/a/c/1/ac14365a19c81dc26d2b2f2750c29ade.png\" title=\"Bounds for LS(n)\" class=\"alignnone\" width=\"229\" height=\"53\" /></p> <p>Any improvements on these bounds would not only be a significant event in the world of Latin squares, but it would also have knock-on effects to those applications that use Latin squares.</p> "
					}
				]
			]
		},
		{
			"content_type": "LSTableView",   
			"cell_types":"UITableViewCellStyleSubtitle",  
			"cell_height":100,           
			"cell_textLabel_numberOfLines":3,
			"cell_textLabel_fontSize":16,
			"icon": "books",
			"title": "Books",
			"items": [
						[
							{
								"content_type": "LSWebsiteView",
								"icon": "denes_keedwellA",
								"title":"Latin Squares and Their Applications",
								"subtitle":"J. Denes, A. D. Keedwell",
								"html":"<p><a href='http://www.amazon.co.uk/Latin-Squares-Their-Applications-Keedwell/dp/034012489X/ref=sr_1_3?ie=UTF8&qid=1306598411&sr=8-3'>View book on Amazon.co.uk</a></p><h3>Summary</h3><p>An excellent primer in the field of Latin squares, although because this book is hard to find, it's usually very expensive.</p>"
							},
							{
								"content_type": "LSWebsiteView",
								"icon": "denes_keedwell",
								"title":"Latin squares: new developments in the theory and applications",
								"subtitle":"J. Denes, A. D. Keedwell",
								"html":"<p><a href='http://www.amazon.co.uk/Latin-squares-Developments-Applications-Mathematics/dp/0444888993/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1303631222&amp;sr=1-1'>View book on Amazon.co.uk</a></p><h3>Summary</h3><p>In 1974 the editors of the present volume published a well-received book entitled &quot;Latin Squares and their Applications&quot;. It included a list of 73 unsolved problems of which about 20 have been completely solved in the intervening period and about 10 more have been partially solved. </p><p>The present work comprises six contributed chapters and also six further chapters written by the editors themselves. As well as discussing the advances which have been made in the subject matter of most of the chapters of the earlier book, this new book contains one chapter which deals with a subject (r-orthogonal latin squares) which did not exist when the earlier book was written.</p><p>The success of the former book is shown by the two or three hundred published papers which deal with questions raised by it. </p>"
							},
							{
								"content_type": "LSWebsiteView",
								"icon": "van_lint_wilson",
								"title":"A Course in Combinatorics",
								"subtitle":"J. H. van Lint, R. M. Wilson",
								"html":"<p><a href='http://www.amazon.co.uk/Course-Combinatorics-J-van-Lint/dp/0521006015/ref=sr_1_1?ie=UTF8&qid=1306598424&sr=8-1'>View book on Amazon.co.uk</a></p><h3>Summary</h3><p>This is the second edition of a popular book on combinatorics, a subject dealing with ways of arranging and distributing objects, and which involves ideas from geometry, algebra and analysis. The breadth of the theory is matched by that of its applications, which include topics as diverse as codes, circuit design and algorithm complexity. It has thus become essential for workers in many scientific fields to have some familiarity with the subject. The authors have tried to be as comprehensive as possible, dealing in a unified manner with, for example, graph theory, extremal problems, designs, colorings and codes. The depth and breadth of the coverage make the book a unique guide to the whole of the subject. The book is ideal for courses on combinatorical mathematics at the advanced undergraduate or beginning graduate level. Working mathematicians and scientists will also find it a valuable introduction and reference.</p>"
							}
						]
			]
		},
		{
			"content_type": "LSTableView",        
			"cell_types":"UITableViewCellStyleSubtitle",  
			"cell_height":100,           
			"cell_textLabel_numberOfLines":3,
			"cell_textLabel_fontSize":16,
			"icon": "papers",
			"title": "Articles",   
			"section_titles":[
				"2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1996","1994","1975"
			],
			
			"items": [
						[
							{
								"title":"Gerechte Designs with Rectangular Regions", 
								"content_type": "LSWebsiteView",    
								"subtitle":"J. Courtiel, E. R. Vaughan",
								"html":"<p><a href='http://arxiv.org/pdf/1104.0637v1'>Download the PDF</a></p><h3>Abstract</h3><p>A <i>gerechte framework</i> is a partition of an n &times; n array into n regions of n cells each. A <i>realization</i> of a gerechte framework is a latin square of order n with the property that when its cells are partitioned by the framework, each region contains exactly one copy of each symbol. A <i>gerechte design</i> is a gerechte framework together with a realization. </p><p>We investigate gerechte frameworks where each region is a rectangle. It seems plausible that all such frameworks have realizations, and we present some progress towards answering this question. In particular, we show that for all positive integers s and t, any gerechte framework where each region is either an s &times; t rectangle or a t&times; s rectangle is realizable.</p>"
							},
							{
								"title":"Monogamous Latin squares", 
								"content_type": "LSWebsiteView",    
								"subtitle":"P. Danziger, I. M. Wanless and B. S. Webb",
								"html":"<p><a href='http://www.sciencedirect.com/science/article/pii/S009731651000172X'>Download the PDF</a></p><h3>Abstract</h3><p>We show for all n not in {1,2,4} that there exists a latin square of order n that contains two entries &gamma;<sub>1</sub> and &gamma;<sub>2</sub> such that there are some transversals through &gamma;<sub>1</sub> but they all include &gamma;<sub>2</sub> as well. We use this result to show that if n>6 and n is not of the form 2p for a prime p&ge;11 then there exists a latin square of order n that possesses an orthogonal mate but is not in any triple of MOLS. Such squares provide examples of 2-maxMOLS.</p>"
							},
							{"content_type": "LSWebsiteView","subtitle":"J. Egan and I. M. Wanless", "title":"Indivisible partitions of latin squares","html":"<a href='http://www.sciencedirect.com/science/article/pii/S0378375810003137'>Download the PDF</a><h3>Abstract</h3>A k-plex is a selection of kn entries of a latin square of order n in which each row, column and symbol occurs k times.  A 1-plex is also called a transversal.  An indivisible k-plex is one that contains no c-plex for 0 < c < k.  For orders n not in {2,6}, existence of latin squares with a decomposition into 1-plexes was famously shown in 1960 by Bose, Shrikhande and Parker. A main result of this paper is that if k is a proper divisor of n then there exists a latin square of order n composed of disjoint indivisible k-plexes.<p> Define &kappa;(n) to be the largest integer k such that some latin square of order n contains an indivisible k-plex.  We report on extensive computations of indivisible plexes and partitions in latin squares of order at most 9.  We determine &kappa;(n) exactly for n &le; 8 and find that &kappa;(9) in {6,7}. In the process we confirm that the latin squares of order 9 satisfy a conjecture by Rodney that every latin square contains a 2-plex.<p> For each group table of order n &le; 8 we report the number of indivisible plexes and indivisible partitions.  For group tables of order 9 we give the number of indivisible plexes and identify which types of indivisible partitions occur.<p> By extending an argument used by Mann, we show that for all n &ge; 5 there is some k in {1,2,3,4} for which there exists a latin square of order n that has k disjoint transversals and a disjoint (n-k)-plex that contains no c-plex for any odd c."}
						],
						[	
							{"content_type": "LSWebsiteView","subtitle":"J. Browning, P. Vojtechovský and I. M. Wanless", "title":"Overlapping latin subsquares and full products","html":"<a href='http://www.du.edu/media/documents/nsm/mathematics/preprints/m0914.pdf'>Download the PDF</a><h3>Abstract</h3>We derive necessary and sufficient conditions for there to exist a latin square of order n containing two subsquares of order a and b that intersect in a subsquare of order c. We also solve the case of two disjoint subsquares. We use these results to show that:<ul> <li> A latin square of order n cannot have more than      n{n choose h} / m{m choose h} subsquares of order m, where    h&ge;(m+1)/2. Indeed, the number of subsquares of order m    is bounded by a polynomial of degree at most &#8730;(2m)+2 in n. <li> For all n&ge;5 there exists a loop of order n in which every    element can be obtained as a product of all n elements in some order    and with some bracketing. </ul> "},
							{"content_type": "LSWebsiteView","subtitle":"N. J. Cavenagh and I. M. Wanless", "title":"On the number of transversals in Cayley tables of cyclic groups","html":"<a href='http://www.sciencedirect.com/science/article/pii/S0166218X0900359X'>Download the PDF</a><h3>Abstract</h3>It is well known that if n is even, the addition table for the integers modulo n (which we denote by B<sub>n</sub>) possesses no transversals. We show that if n is odd, then the number of transversals in B<sub>n</sub> is at least exponential in n. Equivalently, for odd n, the number of diagonally cyclic latin squares of order n, the number of complete mappings or orthomorphisms of the cyclic group of order n, and the number of placements of n non-attacking semi-queens on an n &times; n toroidal chessboard are at least exponential in n.  For all large n we show there is a latin square of order n with at least (3.246)<sup>n</sup> transversals.<p> We diagnose all possible sizes for the intersection of two transversals in B<sub>n</sub> and use this result to complete the spectrum of possible sizes of homogeneous latin bitrades.<p> We also briefly explore potential applications of our results in constructing random mutually orthogonal latin squares."},
							{"content_type": "LSWebsiteView","subtitle":"D. S. Stones and I. M. Wanless", "title":"Divisors of the number of Latin rectangles","html":"<a href='http://www.sciencedirect.com/science/article/pii/S0097316509000855'>Download the PDF</a><h3>Abstract</h3>A k by n Latin rectangle on the symbols {1, 2,...,n} is called reduced if the first row is (1,2,...,n) and the first column is (1,2,...,k)<sup>T</sup>.  Let R<sub>k,n</sub> be the number of k by n reduced Latin rectangles and m = floor(n/2).  We prove several results giving divisors of R<sub>k,n</sub>. For example, (k-1)!  divides R<sub>k,n</sub> when k &le; m and m! divides R<sub>k,n</sub> when m < k &le; n.  We establish a recurrence which determines the congruence of R<sub>k,n</sub> mod t for a range of different t. We use this to show that R<sub>k,n</sub> = ((-1)<sup>k-1</sup>(k-1)!)<sup>n-1</sup>  mod n. In particular, this means that if n is prime, then R<sub>k,n</sub> = 1 mod n for 1 &le; k &le; n and if n is composite then R<sub>k,n</sub> = 0 mod n if and only if k is greater than the largest prime divisor of n."}
						],
						[	
							{"content_type": "LSWebsiteView","subtitle":"D. Bryant, J. Egan, B. Maenhaut and I. M. Wanless", "title":"Indivisible plexes in latin squares","html":"<a href='http://www.springerlink.com/content/c113107xg8332258/'>Download the PDF</a><h3>Abstract</h3>A k-plex is a selection of kn entries of a latin square of order n in which each row, column and symbol is represented precisely k times.  A transversal of a latin square corresponds to the case k=1. A k-plex is said to be indivisible if it contains no c-plex for any 0 < c < k.  We prove that if n=2km for integers k &ge; 2 and m &ge; 1 then there exists a latin square of order n composed of 2m disjoint indivisible k-plexes.  Also, for positive integers k and n satisfying n=3k, n=4k or n &ge; 5k, we construct a latin square of order n containing an indivisible k-plex. "},
							{"content_type": "LSWebsiteView","subtitle":"N.J. Cavenagh and I.M. Wanless", "title":"Latin trades in groups defined on planar triangulations","html":"<a href='http://www.springerlink.com/content/y158174m17047007/'>Download the PDF</a><h3>Abstract</h3>For a finite triangulation of the plane with faces properly coloured white and black, let A be the abelian group constructed by labelling the vertices with commuting indeterminates and adding relations which say that the labels around each white triangle add to the identity. We show that A has free rank exactly two. Let A* be the torsion subgroup of A, and B* the corresponding group for the black triangles. We show that A* and B* have the same order, and conjecture that they are isomorphic.<p>For each spherical latin trade W, we show there is a unique disjoint mate B such that (W,B) is a connected and separated bitrade.  The bitrade (W,B) is associated with a two-colourable planar triangulation and we show that W can be embedded in A*, thereby proving a conjecture due to Cavenagh and Dr&aacute;pal. The proof involves constructing a (0,1) presentation matrix whose permanent and determinant agree up to sign. The Smith Normal Form of this matrix determines A*, so there is an efficient algorithm to construct the embedding.  Contrasting with the spherical case, for each genus g&gt;0 we construct a latin trade which is not embeddable in any group and another that is embeddable in a cyclic group.<p>We construct a sequence of spherical latin trades which cannot be embedded in any family of abelian groups whose torsion ranks are bounded. Also, we show that any trade that can be embedded in a finitely generated abelian group can be embedded in a finite abelian group. As a corollary, no trade can be embedded in a free abelian group."}
						],
						[	
							{"content_type": "LSWebsiteView","subtitle":"P. J. Cameron", "title":"A generalisation of t-designs","html":"<a href='http://www.sciencedirect.com/science/article/pii/S0012365X08004421'>Download the PDF</a><h3>Abstract</h3><p>This paper defines a class of designs which generalise t-designs, resolvable designs, and orthogonal arrays. For the parameters t=2,k=3 and &#955;=1, the designs in the class consist of Steiner triple systems, Latin squares, and 1-factorisations of complete graphs. For other values of t and k, we obtain t-designs, Kirkman systems, large sets of Steiner triple systems, sets of mutually orthogonal Latin squares, and (with a further generalisation) resolvable 2-designs and indeed much more general partitions of designs, as well as orthogonal arrays over variable-length alphabets. </p><p>The Markov chain method of Jacobson and Matthews for choosing a random Latin square extends naturally to Steiner triple systems and 1-factorisations of complete graphs, and indeed to all designs in our class with t=2,k=3, and arbitrary &#955;, although little is known about its convergence or even its connectedness.</p>"},
							{"content_type": "LSWebsiteView","subtitle":"J. A. Egan and I. M. Wanless", "title":"Latin squares with no small odd plexes","html":"<a href='http://onlinelibrary.wiley.com/doi/10.1002/jcd.20178/abstract'>Download the PDF</a><h3>Abstract</h3>A k-plex in a latin square of order n is a selection of kn entries in which each row, column and symbol is represented precisely k times.  A transversal of a latin square corresponds to the case k =1.  We show that for all even n > 2 there exists a latin square of order n which has no k-plex for any odd k < floor(n/4) but does have a k-plex for every other k up to n/2."},
							{"content_type": "LSWebsiteView","subtitle":"N. J. Cavenagh, C. Greenhill and I. M. Wanless", "title":"The cycle structure of two rows in a random latin square","html":"<a href='http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.123.4733&rep=rep1&type=pdf'>Download the PDF</a><h3>Abstract</h3>Let L be chosen uniformly at random from among the latin squares of order n&#8805;4 and let r,s be arbitrary distinct rows of L.  We study the distribution of &sigma;<sub>r,s</sub>, the permutation of the symbols of L which maps r to s. We show that for any constant c>0, the following events hold with probability 1-o(1) as n->&#8734;:<p>(i) &sigma;<sub>r,s</sub> has more than (log n)<sup>1-c</sup> cycles,<p>(ii) &sigma;<sub>r,s</sub> has fewer than 9&#8730;n cycles,<p>(iii) L has fewer than (9/2)n<sup>5/2</sup> intercalates (latin subsquares of order 2).<p>We also show that the probability that &sigma;<sub>r,s</sub> is an even permutation lies in an interval [1/4-o(1),3/4+o(1)] and the probability that it has a single cycle lies in [2n<sup>-2</sup>,2n<sup>-2/3</sup>]. Indeed, we show that almost all derangements have similar probability (within a factor of n<sup>3/2</sup>) of occurring as &sigma;<sub>r,s</sub> as they do if chosen uniformly at random from among all derangements of {1,2,...,n}.  We conjecture that &sigma;<sub>r,s</sub> shares the asymptotic distribution of a random derangement.<p>  Finally, we give computational data on the cycle structure of latin squares of orders n&#8804;11."},
							{"content_type": "LSWebsiteView","subtitle":"B. D. McKay and I. M. Wanless", "title":"A census of small latin hypercubes","html":"<a href=''>Download the PDF</a><h3>Abstract</h3>We count all latin cubes of order n&le;6 and latin hypercubes of order n&le;5 and dimension d&le;5. We classify these (hyper)cubes into isotopy classes and main classes.  For the same values of n and d we classify all d-ary quasigroups of order n into isomorphism classes and also count them according to the number of identity elements they possess (meaning we have counted the d-ary loops).<p> We also give an exact formula for the number of (isomorphism classes of) d-ary quasigroups of order 3 for every d. Then we give a number of constructions for d-ary quasigroups with a specific number of identity elements. In the process, we prove that no 3-ary loop of order n can have exactly n-1 identity elements (but no such result holds in dimensions other than 3).  Finally, we give some new examples of latin cuboids which cannot be extended to latin cubes."}
						],
						[	
							{"content_type": "LSWebsiteView","subtitle":"I. M. Wanless", "title":"A computer enumeration of small latin trades","html":"Australas. J. Combin. 39, (2007) 247-258.<h3>Abstract</h3>We report the results of a computer enumeration of latin trades and bi-trades of sizes up to 19. The (bi-)trades were counted according to various equivalences and those with special properties (such as being primary or homogeneous) were identified. Finally we looked at minimal embeddings of the trades in latin squares and of the bi-trades in topological surfaces."},
							{"content_type": "LSWebsiteView","subtitle":"I. M. Wanless", "title":"Transversals in latin squares","html":"Quasigroups Related Systems 15, (2007) 169-190<h3>Abstract</h3>A latin square of order n is an n by n array of n symbols in which each symbol occurs exactly once in each row and column. A transversal of such a square is a set of n entries such that no two entries share the same row, column or symbol. Transversals are closely related to the notions of complete mappings and orthomorphisms in (quasi)-groups, and are fundamental to the concept of mutually orthogonal latin squares.<p> Here we provide a brief survey of the literature on transversals. We cover (1) existence and enumeration results, (2) generalisations of transversals including partial transversals and plexes, (3) the special case when the latin square is a group table, (4) a connection with coding theory through covering radii of sets of permutations. The survey includes a number of conjectures and open problems."},
							{"content_type": "LSWebsiteView","subtitle":"B. M. Maenhaut, I. M. Wanless and B. S. Webb", "title":"Subsquare-free Latin Squares of odd order","html":"<a href='http://dx.doi.org/doi:10.1016/j.ejc.2005.07.002'>Download the PDF</a><h3>Abstract</h3>For every odd positive integer m we prove the existence of an N<sub>infinity</sub> square (that is, a Latin square with no proper Latin subsquares) of order 3m.  Combining this with previous results it follows that N<sub>infinity</sub> Latin squares exist for all odd orders."}
						],
						[	
							{"content_type": "LSWebsiteView","subtitle":"B. D. McKay, J. C. McLeod and I. M. Wanless", "title":"The number of transversals in a Latin square","html":"<a href='http://dx.doi.org/10.1007/s10623-006-0012-8'>Download the PDF</a><h3>Abstract</h3>A latin square of order n is an n &times; n array of n symbols in which each symbol occurs exactly once in each row and column. A transversal is a set of n entries, one selected from each row and each column of a latin square of order n such that no two entries contain the same symbol. Define T(n) to be the maximum number of transversals over all latin squares of order n. We show that b<sup>n</sup> &lt; T(n) &lt; c<sup>n</sup>n!&radic;n for n&ge;5 where b&asymp;1.719 and c&asymp;0.614. A corollary of this result is an upper bound on the number of placements of n non-attacking queens on an n &times; n  toroidal chess board.<p> Some divisibility properties of the number of transversals in latin squares based on finite groups are established. We also provide data from a computer enumeration of transversals in all latin squares of order at most 9, all groups of order at most 23 and all possible turn-squares of order 14.<p>  Various data collected during the writing of this paper can be found at <a href=\"http://users.monash.edu.au/~iwanless/data/transversals/\">http://users.monash.edu.au/~iwanless/data/transversals/</a>."},
							{"content_type": "LSWebsiteView","subtitle":"I. M. Wanless and B. S. Webb", "title":"The Existence of Latin Squares without Orthogonal Mates","html":"<a href='http://dx.doi.org/doi:10.1007/s10623-006-8168-9'>Download the PDF</a><h3>Abstract</h3>A latin square is a bachelor square if it does not possess an orthogonal mate; equivalently, it does not have a decomposition into disjoint transversals. We define a latin square to be a confirmed bachelor square if it contains an entry through which there is no transversal. We prove the existence of confirmed bachelor squares for all orders greater than three. This resolves the existence question for bachelor squares."},
							{"content_type": "LSWebsiteView","subtitle":"D. Bryant, B. M. Maenhaut and I. M. Wanless", "title":"New families of atomic Latin squares and perfect one-factorisations","html":"J. Combin. Theory A 113, (2006) 608-624<h3>Abstract</h3>A perfect 1-factorisation of a graph G is a decomposition of G into edge disjoint 1-factors such that the union of any two of the factors is a Hamiltonian cycle.  Let p &ge; 11 be prime. We demonstrate the existence of two non-isomorphic perfect 1-factorisations of K<sub>{p+1}</sub> (one of which is well-known) and five non-isomorphic perfect 1-factorisations of K<sub>{p,p}</sub>. If 2 is a primitive root modulo p then we show the existence of eleven non-isomorphic perfect 1-factorisations of K<sub>{p,p}</sub> and five main classes of atomic Latin squares of order p. Only three of these main classes were previously known. One of the two new main classes has a trivial autotopy group."}
						],
						[	
							{"content_type": "LSWebsiteView","subtitle":"B. D. McKay and I. M. Wanless", "title":"On the number of Latin squares","html":"<a href='http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.69.8343&rep=rep1&type=pdf'>Download the PDF</a><h3>Abstract</h3>We (1) determine the number of Latin rectangles with 11 columns and each possible number of rows, including the Latin squares of order 11, (2) answer some questions of Alter by showing that the number of reduced Latin squares of order n is divisible by f! where f is a particular integer close to n/2, (3) provide a formula for the number of Latin squares in terms of permanents of (+1,-1)-matrices, (4) find the extremal values for the number of 1-factorisations of k-regular bipartite graphs on 2n vertices whenever 1 &le; k &le; n &le; 11, (5) show that the proportion of Latin squares with a non-trivial symmetry group tends quickly to zero as the order increases."},
							{"content_type": "LSWebsiteView","subtitle":"I. M. Wanless", "title":"Atomic Latin squares based on cyclotomic orthomorphisms","html":"<a href='http://www.combinatorics.org/Volume_12/PDF/v12i1r22.pdf'>Download the PDF</a><h3>Abstract</h3>Atomic latin squares have indivisible structure which mimics that of the cyclic groups of prime order. They are related to perfect 1-factorisations of complete bipartite graphs. Only one example of an atomic latin square of a composite order (namely 27) was previously known. We show that this one example can be generated by an established method of constructing latin squares using cyclotomic orthomorphisms in finite fields. The same method is used in this paper to construct atomic latin squares of composite orders 25, 49, 121, 125, 289, 361, 625, 841, 1369, 1849, 2809, 4489, 24649 and 39601. It is also used to construct many new atomic latin squares of prime order and perfect 1-factorisations of the complete graph K<sub>q+1</sub> for many prime powers q. As a result, existence of such a factorisation is shown for the first time for q in {529, 2809, 4489, 6889, 11449, 11881, 15625, 22201, 24389, 24649, 26569, 50653, 78125, 79507, 103823, 161051, 205379, 300763, 357911, 371293, 493039, 571787} </P> We show that latin squares built by the `orthomorphism method' have large automorphism groups and discuss conditions under which different orthomorphisms produce isomorphic latin squares.  We also introduce an invariant called the train of a latin square, which proves to be useful for distinguishing non-isomorphic examples. "},
							{"content_type": "LSWebsiteView","subtitle":"I. M. Wanless and E. C. Ihrig", "title":"Symmetries that Latin squares inherit from 1-factorizations","html":"<a href='http://onlinelibrary.wiley.com/doi/10.1002/jcd.20045/abstract'>Download the PDF</a><h3>Abstract</h3>A 1-factorisation of a graph is a decomposition of the graph into edgedisjoint perfect matchings.  There is a well known method, which we call the <b>K</b>-construction, for building a 1-factorisation of K<sub>n,n</sub> from a 1-factorisation of K<sub>n+1</sub>. The 1-factorisation of K<sub>n,n</sub> can be written as a latin square of order n.  The <b>K</b>-construction has been used, among other things, to make perfect 1-factorisations, subsquare-free latin squares and atomic latin squares.</p> This paper studies the relationship between the factorisations involved in the <b>K</b>-construction. In particular, we show how symmetries (automorphisms) of the starting factorisation are inherited as symmetries by the end product, either as automorphisms of the factorisation or as autotopies of the latin square. </p> Suppose that the <b>K</b>-construction produces a latin square L from a 1-factorisation F of K<sub>n+1</sub>.  We show that the main class of L determines the isomorphism class of F (although the converse is false).  We also prove a number of restrictions on the symmetries (autotopies and paratopies) which L may possess, many of which are simple consequences of the fact that L must be idempotent and symmetric (in the usual matrix sense). In some circumstances these restrictions are tight enough to ensure that L has trivial autotopy group. </p> Finally, we give an algorithm for deciding, in time cubic in the order of the squares, whether a main class of latin squares contains any square derived from the <b>K</b>-construction.  The algorithm also detects symmetric squares and totally symmetric squares (latin squares which equal their six conjugates).</p>"}
						],
						[
							{
								"title":"Cycle switches in Latin squares", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p><a href='http://www.springerlink.com/content/pkburjjv916qaq81/'>Download the PDF</a></p><h3>Abstract</h3><p>Cycle switches are examples of latin interchanges or trades in latin square designs.  They represent minimal changes which can be used to alter latin squares, and as such have found many applications in the generation of latin squares. In this paper we construct graphs in which the vertices are classes of latin squares.  Edges arise from switching cycles to move from one class to another.  Such graphs are constructed on sets of isotopy or main classes of latin squares for orders up to and including eight. Variants considered are when (i) only intercalates may be switched, (ii) any row cycle may be switched and (iii) all cycles may be switched. </P> The structure of these graphs reveals special roles played by N<sub>2</sub>, pan-Hamiltonian, atomic, semi-symmetric and totally-symmetric latin squares. In some of the graphs parity is important because, for example, the odd latin squares may be disconnected from the even latin squares.</P> An application of our results to the compact storage of large catalogues of latin squares is discussed. We also prove lower bounds on the number of cycles in latin squares of both even and odd orders and show these bounds are sharp for infinitely many orders.</p>"
							} ,  
							{
								"title":"A partial latin squares problem posed by Blackburn", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p>Bull. Inst. Comb. Appl., 42 (2004), 76-80</p><h3>Abstract</h3><p>Blackburn asked for the largest possible density of filled cells in a partial latin square with the property that whenever two distinct cells P<sub>ab</sub> and P<sub>cd</sub> are occupied by the same symbol the `opposite corners' P<sub>ad</sub> and P<sub>bc</sub> are blank.  We show that, as the order n of the partial latin square increases, a density of at least exp(-c(log n)<sup>1/2</sup>) is possible using a diagonally cyclic construction, where c is a positive constant. The question of whether a constant density is achievable remains, but we show that a density exceeding (&radic;11-1)(1+4/n)/5 is not possible.</p>"
							} ,  
							{
								"title":"Diagonally Cyclic Latin squares", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p><a href='http://www.sciencedirect.com/science/article/pii/S0195669803001537'>Download the PDF</a></p><h3>Abstract</h3><p>A latin square of order n possessing a cyclic automorphism of order n is said to be <b>diagonally cyclic</b> because its entries occur in cyclic order down each broken diagonal.  More generally, we consider squares possessing any cyclic automorphism. Such squares will be named after Parker, in recognition of his seminal contribution to the study of orthogonal latin squares. Our primary aim is to survey the multitude of applications of Parker squares and to collect the basic results on them together in a single location. We mention connections with orthomorphisms and near-orthomorphisms of the cyclic group as well as with starters, even starters, atomic squares, Knut-Vik designs, bachelor squares and pairing squares. </p> In addition to presenting the basic theory we prove a number of original results.  The deepest of these concern sets of mutually orthogonal Parker squares and their interpretation in terms of orthogonal arrays. In particular we study the effect of the various transformations of these orthogonal arrays which were introduced by Owens and Preece.</p> Finally, we exhibit a new application for diagonally cyclic squares; namely, the production of subsquare free squares (so called N<sub>&#8734;</sub> squares). An explicit construction is given for a latin square of any odd order. The square is conjectured to be N<sub>&#8734;</sub> and this has been confirmed up to order 10000 by computer. This represents the first published construction of an N<sub>&#8734;</sub> square for orders 729, 2187 and 6561.</p>"
							} , 
							{
								"title":"Atomic Latin squares of order eleven", 
								"content_type": "LSWebsiteView",    
								"subtitle":"B. M. Maenhaut and I. M. Wanless",
								"html":"<p><a href='http://onlinelibrary.wiley.com/doi/10.1002/jcd.10064/abstract'>Download the PDF</a></p><h3>Abstract</h3><p>A Latin square is <I>pan-Hamiltonian</I> if the permutation which defines row i relative to row j consists of a single cycle for every i&ne;j. A Latin square is <I>atomic</I> if all of its conjugates are pan-Hamiltonian. We give a complete enumeration of atomic squares for order 11, the smallest order for which there are examples distinct from the cyclic group. We find that there are seven main classes, including the three that were previously known. </P> A <I>perfect 1-factorisation</I> of a graph is a decomposition of that graph into matchings such that the union of any two matchings is a Hamiltonian cycle.  Each pan-Hamiltonian Latin square of order n describes a perfect 1-factorisation of K<sub>n,n</sub>, and vice versa. Perfect 1-factorisations of K<sub>n,n</sub> can be constructed from a perfect 1-factorisation of K<sub>n+1</sub>. Six of the seven main classes of atomic squares of order 11 can be obtained in this way. </P> For each atomic square of order 11 we find the largest set of MOLS involving that square. In the process we discuss algorithms for counting orthogonal mates, and discover the number of orthogonal mates possessed by the cyclic squares of orders up to 11 and by Parker's famous turn-square. We also define a new sort of Latin square, called a pairing square, which is mapped to its transpose by an involution acting on the symbols. We show that pairing squares are often orthogonal mates for symmetric Latin squares. </P> Finally, we discover connections between our atomic squares and Franklin's diagonally-cyclic self-orthogonal squares, and we correct a theorem of Longyear which uses tactical representations to identify self-orthogonal forms of a Latin square.</p>"
							}  
						], 
						[
							{
								"title":"Latin squares and the Hall-Paige conjecture", 
								"content_type": "LSWebsiteView",    
								"subtitle":"M. Vaughan-Lee and I. M. Wanless",
								"html":"<p><a href='citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.108.3365&rep=rep1&type=pdf'>Download the PDF</a></p><h3>Abstract</h3><p>The Hall-Paige conjecture deals with conditions under which a finite group G will possess a complete mapping, or equivalently, a Latin square based on the Cayley table of G will possess a transversal. Two necessary conditions are known to be (i) that the Sylow 2-subgroups of G are trivial or non-cyclic and (ii) that there is some ordering of the elements of G which yields a trivial product. These two conditions are known to be equivalent but the first direct, elementary proof that (i) implies (ii) is given here.</P> It is also shown that the Hall-Paige conjecture implies the existence of a duplex in every group table, thereby proving a special case of Rodney's conjecture that every Latin square contains a duplex. A duplex is a \"double transversal\", that is, a set of 2n entries in a Latin square of order n such that each row, column and symbol is represented exactly twice.</p>"
							}  
						], 
						[
						    {
								"title":"A family of perfect factorisations of complete bipartite graphs", 
								"content_type": "LSWebsiteView",    
								"subtitle":"D. Bryant, B. M. Maenhaut and I. M. Wanless",
								"html":"<p><a href='http://www.sciencedirect.com/science/article/pii/S0097316501932406'>Download the PDF</a></p><h3>Abstract</h3><p>A 1-factorisation of a graph is perfect if the union of any two of its 1-factors is a Hamiltonian cycle.  Let n=p<sup>2</sup> for an odd prime p. We construct a family of (p-1)/2 non-isomorphic perfect 1-factorisations of K<sub>n,n</sub>.  Equivalently, we construct pan-Hamiltonian Latin squares of order n. A Latin square is pan-Hamiltonian if the permutation defined by any row relative to any other row is a single cycle.</p>"
							},
							{
								"title":"A generalisation of transversals for Latin squares", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p><a href='http://www.combinatorics.org/Volume_9/PDF/v9i1r12.pdf'>Download the PDF</a></p><h3>Abstract</h3><p>We define a k-plex to be a partial latin square of order n containing kn entries such that exactly k entries lie in each row and column and each of n symbols occurs exactly k times. A transversal of a latin square corresponds to the case k=1. For k>n/4 we prove that not all k-plexes are completable to latin squares. Certain latin squares, including the Cayley tables of many groups, are shown to contain no (2c+1)-plex for any integer c. However, Cayley tables of soluble groups have a 2c-plex for each possible c. We conjecture that this is true for all latin squares and confirm this for orders n&le;8. Finally, we demonstrate the existence of indivisible k-plexes, meaning that they contain no c-plex for 1&le;c&lt;k.</p>"
							}
						],
						[
						    {
								"title":"Answers to questions by Denes on Latin power sets", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p><a href='http://www.sciencedirect.com/science/article/pii/S0195669801905189'>Download the PDF</a></p><h3>Abstract</h3><p>The i-th power, L<sup>i</sup>, of a Latin square L is that matrix obtained by replacing each row permutation in L by its i-th power.  A Latin power set of cardinality m&ge;2 is a set of Latin squares {A,A<sup>2</sup>,A<sup>3</sup>,...,A<sup>m</sup>}. We prove some basic properties of Latin power sets and use them to resolve questions asked by Denes and his various collaborators.</P> <p>Denes has used Latin power sets in an attempt to settle a conjecture by Hall and Paige on complete mappings in groups. Denes suggested three generalisations of the Hall-Paige conjecture. We refute all three with counterexamples. </P> <p>Elsewhere, Denes et al. unsuccessfully tried to construct three mutually orthogonal Latin squares of order 10 based on a Latin power set. We confirm as a result of an exhaustive computer search that there is no Latin power set of the kind sought. However we do find a set of four mutually orthogonal 9&times;10 Latin rectangles.</P> We also show the non-existence of a 2-fold perfect (10,9,1)-Mendelsohn design which was conjectured to exist by Denes. Finally, we prove a conjecture originally due to Denes and Keedwell and show that two others of Denes and Owens are false.</p>"
							}, 
							{
								"title":"On McLeish's construction for Latin squares without intercalates", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p>Ars Combin., 58 (2001) 313-317</p><h3>Abstract</h3><p>A Latin square is N2 if it has no intercalates (Latin subsquares of order 2). We correct results published in an earlier paper by McLeish, dealing with a construction for N2 Latin squares.</p>"
							}, 
							{
								"title":"Latin squares with one subsquare", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p><a href='http://onlinelibrary.wiley.com/doi/10.1002/1520-6610(2001)9:2%3C128::AID-JCD1003%3E3.0.CO;2-C/abstract'>Download the PDF</a></p><h3>Abstract</h3>We look at two classes of constructions for Latin squares which have exactly one proper subsquare. The first class includes known squares due to McLeish and to Kotzig and Turgeon, which had not previously been shown to possess unique subsquares. The second class is a new construction called the corrupted product. It uses subsquare-free squares of orders m and n to build a Latin square of order mn whose only subsquare is one of the two initial squares. We also provide tight bounds on the size of a unique subsquare and a survey of small order examples. Finally, we foreshadow how our squares might be used to create new Latin squares devoid of proper subsquares—so called N∞ squares. © 2001 John Wiley & Sons, Inc. J Combin Designs 9: 128–146, 2001"
							}
						],      
						[
						
						],
						[
						    {
								"title":"Some series of cyclic balanced hyper-graeco-Latin superimpositions of three Youden squares", 
								"content_type": "LSWebsiteView",    
								"subtitle":"D. A. Preece and B. J. Vowden",
								"html":"<p><a href='http://www.sciencedirect.com/science/article/pii/S0012365X99901310'>Download the PDF</a></p><h3>Abstract</h3>General constructions are provided for some cyclic balanced hyper-Graeco-Latin superimpositions of three Youden squares. These superimpositions are all row column designs of sizes q × (2q + 1) and (q + 1) × (2q + 1) where 2q + 1 is a prime power congruent to 3 (modulo 4). For 2q + 1 >= 11, the designs of each size fall into three combinatorially (and statistically) distinct classes. The basic constructions, which extend constructions by Potthoff (1963) and Agrawal and Sharma (1978), involve systematic use of successive even powers and successive odd powers of a primitive element of GF(2q + 1). However, we illustrate how an idea taken from Preece and Phillips (1997) can be extended to produce some slightly more involved variants of the constructions when q is composite and sufficiently large."
							},
							{
								"title":"Most Latin squares have many subsquares", 
								"content_type": "LSWebsiteView",    
								"subtitle":"B. D. McKay and I. M. Wanless",
								"html":"<p><a href='http://www.sciencedirect.com/science/article/pii/S0097316598929478'>Download the PDF</a></p><h3>Abstract</h3>A k&times;n Latin rectangle is a k&times;n matrix of entries from {1,2,...,n} such that no symbol occurs twice in any row or column.  An intercalate is a 2&times;2 Latin sub-rectangle.  Let N(R) be the number of intercalates in R, a randomly chosen k&times;n Latin rectangle.  We obtain a number of results about the distribution of N(R) including its asymptotic expectation and a bound on the probability that N(R)=0.  For &epsilon;>0 we prove most Latin squares of order n have N(R) &ge; n<sup>3/2-&epsilon;</sup>.  We also provide data from a computer enumeration of Latin rectangles for small k,n."
							},
							{
								"title":"Permanents, matchings and Latin rectangles (thesis abstract)", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p><a href='http://journals.cambridge.org/action/displayAbstract?fromPage=online&aid=4854364'>Download the PDF</a></p><h3>Abstract</h3>This thesis investigates three fundamentally related combinatorial objects: regular bipartite graphs, Latin rectangles and (0,1)-matrices with all line sums equal.  The links between these objects are exploited to give some strong results on problems which had seemed intractable when considered in isolation. A central question, phrased in three ways, is the following:</P> <OL> <LI> Which k-regular bipartite graphs on 2n vertices contain the most perfect matchings?<LI> Which (n-k)&times; n Latin rectangles have the most extensions to (n-k+1) &times; n Latin rectangles?<LI> Which square (0,1)-matrices of order n, with precisely k ones in each row and column, achieve the maximum permanent?</OL>   Items (1) to (3) will be referred to below as the maximising problem. The most general previous result was due to Br&egrave;gman, who solved the case when k divides n. We essentially settle the complementary case (that is, when n-k divides n) which relates to a conjecture of Godsil and McKay. We also make substantial progress on the general case, which is an open question listed in Minc's survey article on permanents. In fact that catalogue contains two problems (numbers 4 and 12) which we partly solve and five conjectures (numbers 12, 21, 22, 25 and 26) which we disprove. (Conjectures 25 and 26 were previously known to fail, but were easily patched to exclude the known counterexamples. We identify more serious flaws.)</P> The method of attack on the maximising problem is via a certain integral involving rook polynomials. These polynomials are studied in some depth, including their connections with Laguerre polynomials. An important step is to relate properties of the roots of the rook polynomials to the number of short cycles in an associated bipartite graph. On this issue, we ask the following question.  If G is a k-regular bipartite graph on 2n vertices (n>2k) such that G maximises the number of 4-cycles among all such graphs, does G always contain a copy of K<sub>k,k</sub>? It is shown how an affirmative answer would completely characterize G. The maximising problem for n-k &lt;&lt; n could then be resolved using a result from Godsil and McKay.</P> Chapter 3 was the subject of the B.H.Neumann award winning talk at the 1996 meeting of the Australian Mathematical Society.  In that talk the long standing Holens-Dokovic conjecture on the ratio of subpermanent sums was shown to fail, by converting it to a problem on the ratio of perfect matchings to near perfect matchings in a graph. As a result the problem known as `monotonicity of the permanent' is answered in the negative.  This question asked whether for every doubly stochastic matrix A of order n, the permanent is a monotone function on the interval joining A to J<sub>n</sub>, the matrix in which every entry is 1/n. Despite the disproof of the general case of the Holens-Dokovic conjecture, several specialised cases are proved. </P> In the final chapter, the asymptotic distribution of subsquares in Latin rectangles is considered.  We find that almost all Latin squares contain a large number of intercalates (order 2 subsquares).  We also show that N<sub>&#8734;</sub> squares (Latin squares without proper subsquares) are very rare and then briefly explore a method of creating such squares. The smallest order for which existence of an N<sub>&#8734;</sub> square is unknown is raised from 24 to 256. This last result has been improved in recent work by the author (as yet unpublished)."
							},
							{
								"title":"Perfect factorisations of bipartite graphs and Latin squares without proper subrectangles", 
								"content_type": "LSWebsiteView",    
								"subtitle":"I. M. Wanless",
								"html":"<p><a href='http://www.combinatorics.org/Volume_6/PDF/v6i1r9.pdf'>Download the PDF</a></p><h3>Abstract</h3><p>A Latin square is pan-Hamiltonian if every pair of rows forms a single cycle. Such squares are related to perfect 1-factorisations of the complete bipartite graph. A square is atomic if every conjugate is pan-Hamiltonian. These squares are indivisible in a strong sense -- they have no proper subrectangles. We give some existence results and a catalogue for small orders. In the process we identify all the perfect 1-factorisations of Kn,n for n≤9, and count the Latin squares of order 9 without proper subsquares.</p>"
						   } 
						], 
						[
							{
								"title":"Generating Uniformly Distributed Random Latin Squares", 
								"content_type": "LSWebsiteView",    
								"subtitle":"M. T. Jacobson and P. Matthews",
								"html":"<p><a href='http://onlinelibrary.wiley.com/doi/10.1002/(SICI)1520-6610(1996)4:6%3C405::AID-JCD3%3E3.0.CO;2-J/abstract'>Download the PDF</a></p><h3>Abstract</h3><p>By simulating an ergodic Markov chain whose stationary distribution is uniform over the space of n × n Latin squares, we can obtain squares that are (approximately) uniformly distributed; we offer two such chains. The central issue is the construction of “moves” that connect the squares. Our first approach uses the fact that an n × n Latin square is equivalent to an n × n × n contingency table in which each line sum equals 1. We relax the nonnegativity condition on the table&#39;s cells, allowing “improper” tables that have a single—1-cell. A simple set of moves connects this expanded space of tables [the diameter of the associated graph is bounded by 2(n − 1)3], and suggests a Markov chain whose subchain of proper tables has the desired uniform stationary distribution (with an average of approximately n steps between proper tables). By grouping these moves appropriately, we derive a class of moves that stay within the space of proper Latin squares [with graph diameter bounded by 4(n − 1)2]; these may also be used to form a suitable Markov chain. © 1996 John Wiley & Sons, Inc.</p>"
							}     
						],
						[   
							{"content_type": "LSWebsiteView","subtitle":"P. J. Cameron", "title":"How few entries determine any Latin square?","html":"Bull. Inst. Combinatorics Appl. 10 (1994), 63-65"}
                        ],
						[   
							{"content_type": "LSWebsiteView","subtitle":"P. J. Cameron, D. A. Preece", "title":"Some new fully-balanced Graeco-Latin Youden \"squares\"","html":"Utilitas Math. 8 (1975), 193-204"}
                        ]
			]
		},
		{
			"content_type": "LSTableView",        
			"cell_types":"UITableViewCellStyleSubtitle",  
			"cell_height":60,           
			"cell_textLabel_numberOfLines":3,
			"cell_textLabel_fontSize":16,
			"icon": "unsolved",
			"title": "Unsolved Problems", 
			"section_titles":["Problems on the web","Problems"],
			"items": [
						[
							{
								"title":"Wikipedia",
								"content_type":"LSWebsiteView",
								"subtitle":"",
								"html":"",
								"url":"http://en.wikipedia.org/wiki/Problems_in_Latin_squares"
							} ,
							{
								"title":"Open Problem Garden",
								"content_type":"LSWebsiteView",
								"subtitle":"",
								"html":"",
								"url":"http://garden.irmacs.sfu.ca/?q=category/latin_square"
							} 
						],
						[
							{
								"title":"Ryser's Conjecture",
								"content_type": "LSWebsiteView",        
								"subtitle":"",
								"html":"<p>Prove that every Latin square of odd order has a transversal</p>"
							},
							{
								"title":"Brualdi's Conjecture",
								"content_type": "LSWebsiteView",    
								"subtitle":"",
								"html":"<p>Prove that every Latin square of order 2n has a near-transversal (i.e. a transversal of length 2n-1).</p>"
							},
							{
								"title":"Probaility of being a transversal",
								"content_type": "LSWebsiteView",    
								"subtitle":"",
								"html":"<p>What is the probability that, in a randomly generated Latin square, the main diagonal is a transversal?</p>"
							},
							{
								"title":"Decompose in to a few partial transversals",
								"content_type": "LSWebsiteView",    
								"subtitle":"",
								"html":"<p>As a function of n, what is the fewest number of near transversals that a Latin square can be decomposed in to?</p>"
							}     
						]
			]
		},
		{
			"content_type": "LSSquareView",
			"icon": "random_square",
			"title":"Random Square",
			"blocks":[],
			"description":"Generate a random LS",
			"n":"undefined"
		}, 
		{
			"content_type": "LSTableView",
			"cell_types":"UITableViewCellStyleSubtitle",
			"cell_height":100,           
			"cell_textLabel_numberOfLines":3,
			"cell_textLabel_fontSize":20,
			"icon": "notable",
			"title": "Notable Squares",
			"items":[
				[{
					"content_type": "LSSquareView",
					"title":"Cyclic Squares",
					"subtitle":"A Latin square exists for every order",
					"description":"A Latin square exists for every order, for example the Cayley table of the Cyclic group is always a Latin square, shown here.",
					"n":6,
					"blocks":[
								  [ 1, 7, 13 ], [ 1, 8, 14 ], [ 1, 9, 15 ], [ 1, 10, 16 ], 
							      [ 1, 11, 17 ], [ 1, 12, 18 ], [ 2, 7, 14 ], [ 2, 8, 15 ], [ 2, 9, 16 ], 
							      [ 2, 10, 17 ], [ 2, 11, 18 ], [ 2, 12, 13 ], [ 3, 7, 15 ], 
							      [ 3, 8, 16 ], [ 3, 9, 17 ], [ 3, 10, 18 ], [ 3, 11, 13 ], 
							      [ 3, 12, 14 ], [ 4, 7, 16 ], [ 4, 8, 17 ], [ 4, 9, 18 ], [ 4, 10, 13 ], 
							      [ 4, 11, 14 ], [ 4, 12, 15 ], [ 5, 7, 17 ], [ 5, 8, 18 ], [ 5, 9, 13 ], 
							      [ 5, 10, 14 ], [ 5, 11, 15 ], [ 5, 12, 16 ], [ 6, 7, 18 ], 
							      [ 6, 8, 13 ], [ 6, 9, 14 ], [ 6, 10, 15 ], [ 6, 11, 16 ], [ 6, 12, 17 ]
							],
					"highlight_blocks":[],
					"highlight_blocks_colours":[],
					"allowPertubation":false,
					"allowRecolouring":false
				}],
				[{
					"content_type": "LSSquareView",
					"title":"Finding an orthogonal mate",
					"subtitle":"A complete set of transversals indicates an orthogonal Latin square.",
					"description":"A complete set of transversals indicates an orthogonal Latin square",
					"n":3,
					"blocks":[
								[0,3,6],[0,4,7],[0,5,8],[1,3,7],[1,4,8],[1,5,6],
								[2,3,8],[2,4,6],[2,5,7]
							],
					"highlight_blocks":[
											[0,3,6],[1,4,8],[2,5,7],
											[0,4,7],[1,5,6],[2,3,8],
											[0,5,8],[1,3,7],[2,4,6]
										],
					"highlight_blocks_colours":[
													{"red":1.0,"blue":0,"green":0.88,"alpha":1.0},
													{"red":1.0,"blue":0,"green":0.88,"alpha":1.0},
													{"red":1.0,"blue":0,"green":0.88,"alpha":1.0},
											
													{"red":0.86,"blue":0.35,"green":0.35,"alpha":1.0},
													{"red":0.86,"blue":0.35,"green":0.35,"alpha":1.0},
													{"red":0.86,"blue":0.35,"green":0.35,"alpha":1.0},
											
													{"red":0.4,"blue":0.54,"green":0.8,"alpha":1.0},
													{"red":0.4,"blue":0.54,"green":0.8,"alpha":1.0},
													{"red":0.4,"blue":0.54,"green":0.8,"alpha":1.0}
												],
					"allowPertubation":false,
					"allowRecolouring":false
				}] 
			]
		},  
		{
			"content_type": "LSWebsiteView",
			"icon": "about",
			"title": "About this app",
			"html": "<h3>Overview</h3><p>This app was made by Andy Drizen, a London-based freelance iOS developer. For more of my work, you might like to <a href='http://www.andydrizen.co.uk'>visit my website.</a></p><h3>Licences</h3><h4>All-Seeing Interactive</h4><p>* Copyright (c) 2007-2011, All-Seeing Interactive</p><p> All rights reserved.</p><p> Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:</p><p>     * Redistributions of source code must retain the above copyright       notice, this list of conditions and the following disclaimer.</p><p>     * Redistributions in binary form must reproduce the above copyright       notice, this list of conditions and the following disclaimer in the       documentation and/or other materials provided with the distribution.</p><p>     * Neither the name of the All-Seeing Interactive nor the       names of its contributors may be used to endorse or promote products       derived from this software without specific prior written permission.</p><p> THIS SOFTWARE IS PROVIDED BY All-Seeing Interactive ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL All-Seeing Interactive BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p><p>A different license may apply to other software included in this package, including GHUnit and Andrew Donoho's Reachability class. Please consult their respective headers for the terms of their individual licenses.</p><h4>JSON Parser</h4><p> Copyright (C) 2009-2010 Stig Brautaset. All rights reserved.</p><p> Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:</p><p> * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.</p><p> * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.</p><p> * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.</p> <p>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>"
		}
	]],
	"external_files":{
		"random_square":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/random_square.png",
			"url_retina": "http://server.andydrizen.co.uk/latinsquares/images/random_square@2x.png",
			"type":"image"
		},
		"theory":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/theory.png",
			"url_retina": "http://server.andydrizen.co.uk/latinsquares/images/theory@2x.png",
			"type":"image"
		},
		"books":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/books.png",
			"url_retina": "http://server.andydrizen.co.uk/latinsquares/images/books@2x.png",
			"type":"image"
			
		},
		"papers":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/papers.png",
			"url_retina":"http://server.andydrizen.co.uk/latinsquares/images/papers@2x.png",
			"type":"image"
		},
		"notable":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/notable.png",
			"url_retina":"http://server.andydrizen.co.uk/latinsquares/images/notable@2x.png",
			"type":"image"
		},
		"unsolved":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/unsolved3.png",
			"url_retina": "http://server.andydrizen.co.uk/latinsquares/images/unsolved3@2x.png",
			"type":"image"
		},
		"about":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/about2.png",
			"url_retina":"http://server.andydrizen.co.uk/latinsquares/images/about2@2x.png",
			"type":"image"
		},
				
		"denes_keedwellA":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/denes_keedwellA.png",
			"url_retina":"http://server.andydrizen.co.uk/latinsquares/images/denes_keedwellA@2x.png",
			"type":"image"
		}, 		
		"denes_keedwell":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/denes_keedwell.png",
			"url_retina":"http://server.andydrizen.co.uk/latinsquares/images/denes_keedwell@2x.png",
			"type":"image"
		},		
		"van_lint_wilson":{
			"url":"http://server.andydrizen.co.uk/latinsquares/images/van_lint_wilson.png",
			"url_retina":"http://server.andydrizen.co.uk/latinsquares/images/van_lint_wilson@2x.png",
			"type":"image"
		} 
	}
   
}
