#############################################################################
##
#W  oper.tst
#Y  Copyright (C) 2014                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("Digraphs package: oper.tst");
gap> LoadPackage("digraphs", false);;

#
gap> DigraphsStartTest();

# DigraphReverse (for a digraph by adjacency)
gap> gr := Digraph(
> [ [ 3 ], [ 1, 3, 5 ], [ 1 ], [ 1, 2, 4 ], [ 2, 3, 5 ] ]);
<digraph with 5 vertices, 11 edges>
gap> rgr := DigraphReverse(gr);
<digraph with 5 vertices, 11 edges>
gap> OutNeighbours(rgr);
[ [ 2, 3, 4 ], [ 4, 5 ], [ 1, 2, 5 ], [ 4 ], [ 2, 5 ] ]
gap> gr = DigraphReverse(rgr);
true

# DigraphReverse (for a digraph with source)
gap> gr := Digraph( rec ( nrvertices := 5,
> source := [ 1, 1, 2, 2, 2, 2, 2, 3, 4, 4, 4, 5, 5, 5 ],
> range  := [ 1, 3, 1, 2, 2, 4, 5, 4, 1, 3, 5, 1, 1, 3 ] ) );
<multidigraph with 5 vertices, 14 edges>
gap> e := DigraphEdges(gr);
[ [ 1, 1 ], [ 1, 3 ], [ 2, 1 ], [ 2, 2 ], [ 2, 2 ], [ 2, 4 ], [ 2, 5 ], 
  [ 3, 4 ], [ 4, 1 ], [ 4, 3 ], [ 4, 5 ], [ 5, 1 ], [ 5, 1 ], [ 5, 3 ] ]
gap> rev := DigraphReverse(gr);
<multidigraph with 5 vertices, 14 edges>
gap> erev := DigraphEdges(rev);
[ [ 1, 1 ], [ 1, 2 ], [ 1, 5 ], [ 1, 4 ], [ 1, 5 ], [ 2, 2 ], [ 2, 2 ], 
  [ 3, 1 ], [ 3, 4 ], [ 3, 5 ], [ 4, 3 ], [ 4, 2 ], [ 5, 2 ], [ 5, 4 ] ]
gap> temp := List( erev, x -> [ x[2], x[1] ] );;
gap> Sort(temp);
gap> e = temp;
true

# DigraphTransitiveClosure & DigraphReflexiveTransitiveClosure
gap> gr := Digraph( 
> rec( nrvertices := 2, source := [ 1, 1 ], range := [ 2, 2 ] ) );
<multidigraph with 2 vertices, 2 edges>
gap> DigraphReflexiveTransitiveClosure(gr);
Error, Digraphs: DigraphReflexiveTransitiveClosure: usage,
the argument <graph> cannot have multiple edges,

gap> DigraphTransitiveClosure(gr);
Error, Digraphs: DigraphTransitiveClosure: usage,
the argument <graph> cannot have multiple edges,

gap> r := rec( vertices:=[ 1 .. 4 ], source := [ 1, 1, 2, 3, 4 ], 
> range := [ 1, 2, 3, 4, 1 ] );
rec( range := [ 1, 2, 3, 4, 1 ], source := [ 1, 1, 2, 3, 4 ], 
  vertices := [ 1 .. 4 ] )
gap> gr := Digraph(r);
<digraph with 4 vertices, 5 edges>
gap> IsAcyclicDigraph(gr);
false
gap> DigraphTopologicalSort(gr);
fail
gap> gr1 := DigraphTransitiveClosure(gr);
<digraph with 4 vertices, 16 edges>
gap> gr2 := DigraphReflexiveTransitiveClosure(gr);
<digraph with 4 vertices, 16 edges>
gap> gr1 = gr2;
true
gap> adj := [ [ 2, 6 ], [ 3 ], [ 7 ], [ 3 ], [  ], [ 2, 7 ], [ 5 ] ];;
gap> gr := Digraph(adj);
<digraph with 7 vertices, 8 edges>
gap> IsAcyclicDigraph(gr);
true
gap> gr1 := DigraphTransitiveClosure(gr);
<digraph with 7 vertices, 18 edges>
gap> gr2 := DigraphReflexiveTransitiveClosure(gr);
<digraph with 7 vertices, 25 edges>
gap> gr := Digraph( [ [ 2 ], [ 3 ], [ 4 ], [ 3 ] ] );
<digraph with 4 vertices, 4 edges>
gap> gr1 := DigraphTransitiveClosure(gr);
<digraph with 4 vertices, 9 edges>
gap> gr2 := DigraphReflexiveTransitiveClosure(gr);
<digraph with 4 vertices, 11 edges>

# DigraphRemoveLoops (for a digraph by adjacency)
gap> adj := [ [ 1, 2 ], [ 3, 2 ], [ 1, 2 ], [ 4 ], [ ], [ 1, 2, 3, 6 ] ];
[ [ 1, 2 ], [ 3, 2 ], [ 1, 2 ], [ 4 ], [  ], [ 1, 2, 3, 6 ] ]
gap> gr := Digraph(adj);
<digraph with 6 vertices, 11 edges>
gap> DigraphRemoveLoops(gr);
<digraph with 6 vertices, 7 edges>

# DigraphRemoveLoops (for a digraph by source and range)
gap> source := [ 1, 1, 2, 2, 3, 3, 4, 6, 6, 6, 6 ];;
gap> range  := [ 1, 2, 3, 2, 1, 2, 4, 1, 2, 3, 6 ];;
gap> gr := Digraph( 
> rec ( nrvertices := 6, source := source, range := range ) );
<digraph with 6 vertices, 11 edges>
gap> DigraphRemoveLoops(gr);
<digraph with 6 vertices, 7 edges>
gap> 

# DigraphRelabel (for a digraph by adjacency and perm)
gap> gr := Digraph( [ [ 2 ], [ 1 ], [ 3 ] ] );
<digraph with 3 vertices, 3 edges>
gap> DigraphEdges(gr);
[ [ 1, 2 ], [ 2, 1 ], [ 3, 3 ] ]
gap> g := (1, 2, 3);
(1,2,3)
gap> DigraphRelabel(gr, g);
<digraph with 3 vertices, 3 edges>
gap> DigraphEdges(last);
[ [ 1, 1 ], [ 2, 3 ], [ 3, 2 ] ]
gap> h := (1, 2, 3, 4);
(1,2,3,4)

#
gap> gr := Digraph(rec(nrvertices := 10, source := [1,1,5,5,7,10],
> range := [3,3, 1, 10, 7, 1]));
<multidigraph with 10 vertices, 6 edges>
gap> InNeighboursOfVertex(gr, 7);
[ 7 ]
gap> gr := Digraph([[1,1,4],[2,3,4],[2,4,4,4],[2]]);
<multidigraph with 4 vertices, 11 edges>
gap> InNeighboursOfVertex(gr, 3);
[ 2 ]

#
gap> gr := Digraph([[2,2,2,2], [2,2]]);
<multidigraph with 2 vertices, 6 edges>
gap> OutNeighboursOfVertex(gr, 2);
[ 2, 2 ]
gap> gr := Digraph(rec(nrvertices := 10, source := [5,5,5,5,5,5],
> range := [1,2,3,1,2,3]));
<multidigraph with 10 vertices, 6 edges>
gap> OutNeighboursOfVertex(gr, 2);
[  ]
gap> OutNeighboursOfVertex(gr, 5);
[ 1, 2, 3, 1, 2, 3 ]

# InducedSubdigraph (source and range version)
gap> r := rec( nrvertices := 8,
> source := [ 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 5, 5, 5, 5, 5, 5 ],
> range  := [ 1, 1, 2, 3, 3, 4, 1, 1, 3, 4, 5, 1, 3, 4, 4, 5, 7 ] );
rec( nrvertices := 8, 
  range := [ 1, 1, 2, 3, 3, 4, 1, 1, 3, 4, 5, 1, 3, 4, 4, 5, 7 ], 
  source := [ 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 5, 5, 5, 5, 5, 5 ] )
gap> gr := Digraph(r);
<multidigraph with 8 vertices, 17 edges>
gap> InducedSubdigraph( gr, [ -1 ] );
Error, Digraphs: InducedSubdigraph: usage,
the second argument <subverts> must be a duplicate-free subset
of the vertices of the first argument <digraph>,

gap> InducedSubdigraph( gr, [ 1 .. 9 ] );
Error, Digraphs: InducedSubdigraph: usage,
the second argument <subverts> must be a duplicate-free subset
of the vertices of the first argument <digraph>,

gap> InducedSubdigraph( gr, [ ] );
<digraph with 0 vertices, 0 edges>
gap> InducedSubdigraph( gr, [ 2 .. 6 ] );
<multidigraph with 5 vertices, 7 edges>
gap> InducedSubdigraph( gr, [ 8 ] );
<digraph with 1 vertex, 0 edges>
gap> i1 := InducedSubdigraph( gr, [ 1, 4, 3 ] );
<multidigraph with 3 vertices, 6 edges>
gap> OutNeighbours(i1);
[ [ 1, 1, 2, 2, 3 ], [ 3 ], [  ] ]
gap> i2 := InducedSubdigraph( gr, [ 3, 4, 3, 1 ] );
Error, Digraphs: InducedSubdigraph: usage,
the second argument <subverts> must be a duplicate-free subset
of the vertices of the first argument <digraph>,


# InducedSubdigraph (OutNeighbours version)
gap> adj := [
> [ 2, 3, 4, 5, 6, 6, 7 ],
> [ 1, 1, 1, 3, 4, 5 ],
> [ 4 ],
> [ 3, 5 ],
> [ 1, 2, 2, 3, 4, 4, 6, 5, 6, 7 ],
> [ ],
> [ 1 ],
> [ ] ];;
gap> gr := Digraph(adj);
<multidigraph with 8 vertices, 27 edges>
gap> InducedSubdigraph( gr, [ "a" ] );
Error, Digraphs: InducedSubdigraph: usage,
the second argument <subverts> must be a duplicate-free subset
of the vertices of the first argument <digraph>,

gap> InducedSubdigraph( gr, [ 0 ] );
Error, Digraphs: InducedSubdigraph: usage,
the second argument <subverts> must be a duplicate-free subset
of the vertices of the first argument <digraph>,

gap> InducedSubdigraph( gr, [ 2 .. 9 ] );
Error, Digraphs: InducedSubdigraph: usage,
the second argument <subverts> must be a duplicate-free subset
of the vertices of the first argument <digraph>,

gap> InducedSubdigraph( gr, [ ] );
<digraph with 0 vertices, 0 edges>
gap> i1 := InducedSubdigraph( gr, [ 1, 3, 5, 7 ] );
<digraph with 4 vertices, 8 edges>
gap> OutNeighbours(i1);
[ [ 2, 3, 4 ], [  ], [ 1, 2, 3, 4 ], [ 1 ] ]
gap> i2 := InducedSubdigraph( gr, [ 7, 5, 3, 1 ] );
<digraph with 4 vertices, 8 edges>
gap> i1 = i2;
true
gap> InducedSubdigraph( gr, [ 2 .. 8 ] );
<multidigraph with 7 vertices, 15 edges>
gap> InducedSubdigraph( gr, [ 8 ] );
<digraph with 1 vertex, 0 edges>
gap> InducedSubdigraph( gr, [ 7, 8 ] );
<digraph with 2 vertices, 0 edges>

#
gap> DigraphsStopTest();

#
gap> STOP_TEST( "Digraphs package: attrs.tst", 0);
