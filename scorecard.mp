verbatimtex \font\small    pcrb at 9pt etex

defaultfont := "pcrb";
defaultscale := 1.2;

color field_color; field_color := (.8, .8, .8);
color box_color; box_color := (.6, .6, .6);

batters             := 9; % How many batter boxes
pitchers            := 6; % How many pitcher boxes
innings             := 12; % How many innings with a diamond
extra_innings       := 4;  % How many diamond-less innings and/or stats boxes
inning_box_len      := 40; % How wide/tall an inning box is
pitching_box_height := inning_box_len / 2; % How tall a pitcher's name box is
name_box_width      := inning_box_len * 3; % How wide a batter or pitcher's name box is
diamond_len         := inning_box_len / 5; % How big the diamond should be
gap                 := 4; % How big gaps should be

%% Draw an empty box at (x,y) with width = w and height = h.
def draw_box(expr x, y, w, h) =
  path box;
  box := (x, y) -- (x+w, y) -- (x+w, y-h) -- (x, y-h) -- cycle;
  pickup pensquare scaled 0.5pt;
  draw box withcolor box_color;
enddef;

%% Draw a small baseball field.
def draw_field(expr x, y) =
  path wholefield;
  path diamond;
  d := diamond_len;
  wholefield :=
    (x, y) -- (x-2d, y+2d) .. (x, y+3.2d) .. (x+2d, y+2d) -- cycle;
  diamond :=
    (x, y) -- (x-d, y+d) -- (x, y+2d) -- (x+d, y+d) -- cycle;
  pickup pensquare scaled 0.25pt;
  draw wholefield withcolor field_color;
  draw diamond withcolor field_color;
enddef;


def draw_field_box(expr x, y) =
  draw_field(x + .42 * inning_box_len, y - .7 * inning_box_len);
  draw_box(x, y, inning_box_len, inning_box_len);
enddef;

def draw_inning_header(expr x, y, top_label, bottom_label) =
  d := inning_box_len;
  label.top(top_label, (x + d/2, y - d/2));
  label.bot(bottom_label, (x + d/2, y - d/2));
  draw_box(x, y, d, d);
enddef;

def draw_name_box(expr x, y, dy, descr) =
  draw_box(x, y, name_box_width, dy);
  label(descr, (x+4, y-6));
enddef;

def draw_inning_summary_box(expr x, y) =
  d := inning_box_len;
  draw_box(x, y, inning_box_len, inning_box_len);
  label(btex {\small H} etex, (x + .1d, y - .1d));
  label(btex {\small R} etex, (x + .1d, y - .35d));
  label(btex {\small E} etex, (x + .1d, y - .60d));
  label(btex {\small LOB} etex, (x + .25d, y - .85d));
enddef;

def draw_pitcher_header(expr x, y, dx, descr) =
  draw_box(x, y, dx, pitching_box_height);
  label(descr, (x+dx/2, y-pitching_box_height/2));
enddef;

def draw_pitcher_header_line(expr x, y) =
  draw_pitcher_header(x, y, name_box_width, "Pitcher");
  string pitching_labels[];
  pitching_labels[0] := "W/S/L";
  pitching_labels[1] := "IP";
  pitching_labels[2] := "H";
  pitching_labels[3] := "R";
  pitching_labels[4] := "ER";
  pitching_labels[5] := "SO";
  pitching_labels[6] := "BB";
  for i = 0 upto 6:
    draw_pitcher_header(x + name_box_width + (i*inning_box_len), y, inning_box_len, pitching_labels[i]);
  endfor;
enddef;

def draw_pitcher_line(expr x, y, number) =
  draw_name_box(x, y, pitching_box_height, decimal number);
  for i = 0 upto 6:
    draw_pitcher_header(x + name_box_width + (i*inning_box_len), y, inning_box_len, "");
  endfor;
enddef;

beginfig (1)
  %% Batters header
  draw_box(0, 0, name_box_width, inning_box_len);
  label.bot("Batter", (name_box_width/2, -(inning_box_len/2)));

  %% Regular inning headers
  for i = 0 upto innings - 1:
    x := name_box_width + i * inning_box_len;
    draw_inning_header(x, 0, "", decimal (i+1));
  endfor;

  %% Player stats / extra innings headers
  string stats[];
  stats[0] := "AB";
  stats[1] := "H";
  stats[2] := "R";
  stats[3] := "RBI";
  for i = 0 upto extra_innings-1:
    x := gap + name_box_width + (i+innings)*inning_box_len;
    draw_inning_header(x, 0, stats[i], decimal (innings+i+1));
  endfor;

  %% Draw one row per batter
  for j = 1 upto batters:
    y := j * inning_box_len;
    if j = batters:
      height := 2*inning_box_len;
    else:
      height := inning_box_len;
    fi;
    draw_name_box(0, -y, height, decimal j);

    for i = 0 upto innings - 1:
      x := name_box_width + i * inning_box_len;
      draw_field_box(x, -y);
    endfor;

    for i = innings upto innings + extra_innings - 1:
      x := gap + name_box_width + i * inning_box_len;
      draw_box(x, -y, inning_box_len, inning_box_len);
    endfor
  endfor;

  %% Draw last row for inning totals
  y := (batters + 1) * inning_box_len;
  for i = 0 upto innings + extra_innings - 1:
    x := name_box_width + i * inning_box_len;
    if i >= innings:
      x := x + gap;
    fi;
    draw_inning_summary_box(x, -y);
  endfor;

  %% Pitcher box
  yoff := (batters + 2) * inning_box_len + gap;
  draw_pitcher_header_line(0, -yoff);
  for i = 1 upto pitchers:
    draw_pitcher_line(0, -yoff - i*pitching_box_height, i);
  endfor;
endfig;
bye
