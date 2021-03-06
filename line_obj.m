## -*- Mode: octave; Package: OCTAVE -*-
##
## $Id:$
##
## Author: Leo Butler (l.butler@cmich.edu)
##
## This file is OCTAVE code (http://www.octave.org/)
##
## It is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or (at your
## option) any later version.
##
## This software is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
## or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
## License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this file. If not, see http://www.gnu.org/licenses/.
##
## usage:  d = line_obj (L,M,normalise_directions=1,W=1)
##
## L,M are lines in R^3 = [p;v] where p is a point in R^3 closest to 0
## and v is a unit direction vector = 2 x 3 matrix
## W=3x3 weight matrix
## normalise_directions=1 ==> make sure |v|=1.

function d = line_obj (L,M,normalise_directions=1,W=1)
  global line_obj_use_acos;
  if normalise_directions==1
    L(2,:)/=norm(L(2,:));
    M(2,:)/=norm(M(2,:));
  endif
  if line_obj_use_acos==1 && normalise_directions==1
    yp=L-M;
    d=yp(1,:) * yp(1,:)';
    s=arclengthsq(L(2,:) * M(2,:)');
    d=d+s;
  else
    yp=L-M;
    d=trace(yp * W * yp');
    L(2,:)=-L(2,:);
    ym=L-M;
    d=min([d,trace(ym * W * ym')]);
  endif
endfunction
%!test
%! L=[1,1,1;1,1,1]/sqrt(3);
%! M=[1,1,1;1,1,1]/sqrt(3);

#  end of line_obj.m 
