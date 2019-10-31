# Downloads

- [Single page](https://github.com/gnuvince/scorecard/releases/latest/download/one-page.pdf)
- [Duplex](https://github.com/gnuvince/scorecard/releases/latest/download/duplex.pdf)

# Guiding principles

1. **Target U.S. Letter (8.5" x 11") Format:** U.S. Letter is the most common printer paper format for American and Canadian printer owners. I want this scoresheet to be used by baseball fans and I don't want them to have to run to Staples to get a different paper size.
2. **Keep the design “quiet”:** Many baseball scorecards have labels for ways to get on base (1B, 2B, 3B, HR, BB, HBP), they have small checkboxes for balls, strikes and out, they have lines to separate multiple players in the same batting position, etc. I want to keep the design of this card quiet. I've allowed the small field in the inning boxes to guide the scorer, but otherwise I've attempted to avoid putting in too much visual noise.
3. **Optimize the common case:** I've seen scorecards that include information such as the number of spectators, the wheather, the number of balks per pitcher, etc. I've tried to avoid such things. If you want to include such information, the free-form box in the bottom right is the perfect place for that.

# Building

To build the scorecard yourself, you'll need an installation of LaTeX.
On Debian systems, you can run this command to have a full installation:

    $ sudo apt install texlive-full

Then you can run `make` in the repository.
