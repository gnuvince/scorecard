main.pdf: main.tex scorecard-1.pdf
	pdftex $<

scorecard-1.pdf: scorecard.mp
	mptopdf $<

clean:
	rm -f *.log *.1 *.pdf

.PHONY: clean
