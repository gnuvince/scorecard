
def draw_field(expr x, y, dx, dy) =
  color field;
  field := (0.8, 0.8, 0.8);
  pickup pensquare scaled 0.05pt;
  draw (x, y)                   % 0, 0
    -- (x+dx, y+dy)             % 1, 1
    -- (x, y+2*dy)              % 0, 2
    -- (x-dx, y+dy)             %-1, 1
    -- (x, y)
    withcolor field;
  draw (x, y) -- (x+2*dx, y+2*dy) withcolor field;
  draw (x, y) -- (x-2*dx, y+2*dy) withcolor field;
  draw (x-2*dx, y+2*dy)
    .. (x, y+3.4*dy)
    .. (x+2*dx, y+2*dy)
    withcolor field;
enddef;

beginfig (1)
  draw_field(0, 0, 1, 1);
  draw_field(10, 10, 2, 2);
  %draw (dxstart+dsize,dystart+dsize)--(dxstart+(dsize*ofactor),dystart+(dsize*ofactor))..(dxstart,dystart+(2*dsize*ofactor))..(dxstart-(dsize*ofactor),dystart+(dsize*ofactor))--(dxstart-dsize,dystart+dsize) withcolor diamond;
endfig;
bye
